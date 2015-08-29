class AggregatePointsJob < ActiveJob::Base
  queue_as :default

  def perform
    Point.transaction do
      last_point = Point.order(created_at: :desc).first
      return if last_point.blank?
      points = Point.where('id <= ?', last_point.id).order(created_at: :asc).all.map { |p| { x: p.lat, y: p.lng } }
      Track.create_from_points(points, last_point.created_at)
      Point.where('id < ?', last_point.id).delete_all
    end
  end
end
