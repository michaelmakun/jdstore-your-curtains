module ReviewsHelper
  def render_review_time(review)
    review.created_at.to_s(:short)
  end
end
