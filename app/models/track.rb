class Track < ActiveRecord::Base

  def self.import(file)
    gpx =  GPX::GPXFile.new(gpx_file: file)
    gpx.tracks.map do |t|
      points = t.points.map { |p| { x: p.lat, y: p.lon } }
      points = SimplifyRb.simplify(points, 0.0000005, true)
      points = points.map { |p| { lat: p[:x], lng: p[:y] } }
      Track.create!(json: points.to_json, created_at: t.points.last.time)
    end
  end

end
