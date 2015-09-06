class AggregatePointsJob < ActiveJob::Base
  queue_as :default

  EPS = ENV['EPSILON_FOR_NEW_TRACK'] || 0.02

  def perform
    Point.transaction do
      return if Point.order(created_at: :desc).count < 2
      last_point = Point.order(created_at: :desc).first
      all_points = Point.where('id <= ?', last_point.id).order(created_at: :asc).to_a
      p1 = all_points.first.to_x_y
      points = [p1]
      all_points.drop(1).each do |p|
        p2 = p.to_x_y
        if distance(p1, p2) > EPS
          Track.create_from_points(points, p.created_at)
          points = []
        end
        points << p2
        p1 = p2
      end
      Track.create_from_points(points, last_point.created_at)
      Point.where('id < ?', last_point.id).delete_all
    end
  end

  private

  def dest_sqr(p1, p2)
    dx = p2[:x] - p1[:x]
    dy = p2[:y] - p1[:y]
    dx * dx + dy * dy
  end

  def distance(p1, p2)
    fi1 = to_rad(p1[:x])
    fi2 = to_rad(p2[:x])
    l1 = to_rad(p1[:y])
    l2 = to_rad(p2[:y])
    111.2 * Math.acos(Math.sin(fi1) * Math.sin(fi2) + Math.cos(fi1) * Math.cos(fi2) * Math.cos(l2-l1))
  end

  def to_rad(deg)
    deg * Math::PI / 180.0
  end
end
