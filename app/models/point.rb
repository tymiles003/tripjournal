class Point < ActiveRecord::Base

  def lat
    self.latlng.first
  end

  def lat=(value)
    self.latlng = [] if self.latlng.nil?
    self.latlng[0] = value.to_f rescue 0.0
  end

  def lng
    self.latlng.last
  end

  def lng=(value)
    self.latlng = [] if self.latlng.nil?
    self.latlng[1] = value.to_f rescue 0.0
  end

  def to_json
    {
        lat: self.lat,
        lng: self.lng,
        alt: self.alt,
        speed: self.speed,
        created_at: self.created_at,
    }.to_json
  end

  def self.import(file)
    gpx =  GPX::GPXFile.new(gpx_file: file)
    gpx.tracks.each do |t|
      points = t.points.map { |p| { x: p.lat, y: p.lon, time: p.time } }
      points = SimplifyRb.simplify(points, 0.00005, true)
      transaction do
        points.each do |p|
          connection.execute("INSERT INTO points (latlng, created_at, updated_at) VALUES ('(#{p[:x]},#{p[:y]})','#{p[:time]}','#{p[:time]}')")
        end
      end
    end
  end

  private

  def notify
    Pusher["tj.#{Rails.env}"].trigger('tj:map:update_current_position', self.to_json )
  end
end
