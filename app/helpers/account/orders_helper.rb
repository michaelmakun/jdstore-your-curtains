module Account::OrdersHelper
    def render_order_time(order)
      Time.zone.parse(order.created_at.to_s(:long)).in_time_zone("Beijing").to_s(:long)
    end
end
