class OrderMailer < ApplicationMailer
  before_action :set_mailer
  def notify_order_placed(order)
    mail(to: @user.email, subject: "[JDstore] 感谢您完成本次的下单,以下是您这次购物明细 #{order.token}")
  end

  def apply_cancel(order)
    mail(to: "admin@gmail.com", subject: "[JDstore]用户#{order.user.email}申请取消订单 #{order.token}")
  end

  def notify_ship(order)
    mail(to: @user.email, subject: "[JDstore] 您的订单 #{order.token}已发货")
  end

  def notify_cancel(order)
    mail(to: @user.email, subject: "[JDstore] 您的订单#{order.token}已取消")
  end

  private

  def set_mailer
    @order = order
    @user  = order.user
    @product_lists = @order.product_lists
  end
end
