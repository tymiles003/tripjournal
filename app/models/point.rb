class Point < ActiveRecord::Base
  include Location

  after_create :notify

  def to_json
    {
        lat: self.lat,
        lng: self.lng,
        alt: self.alt,
        speed: self.speed,
        created_at: self.created_at,
    }.to_json
  end

  def to_x_y
    {x: self.lat, y: self.lng}
  end

  private

  def notify
    Pusher["tj.#{Rails.env}"].trigger('tj:map:update_current_position', self.to_json )
  end
end
