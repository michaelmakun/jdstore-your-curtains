module ProductsHelper
  def last_item(index)
    if index > 0 && (index + 1) % 5 ==0
      "productList-lastItem"
    end
  end
  # 
  # def render_product_review_time(review)
  #   Time.zone.parse(review.created_at.to_s(:short)).in_time_zone("Beijing").to_s(:long)
  # end
end
