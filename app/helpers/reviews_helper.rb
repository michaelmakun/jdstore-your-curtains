module ReviewsHelper
  def render_review_time(review)
    Time.zone.parse(review.created_at.to_s(:short)).in_time_zone("Beijing").to_s(:long)
  end
end
