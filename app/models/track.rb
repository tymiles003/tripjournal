class Track < ActiveRecord::Base

  def self.import(file)
    gpx =  GPX::GPXFile.new(gpx_file: file)
    gpx.tracks.map do |t|
      points = t.points.map { |p| { x: p.lat, y: p.lon } }
      points = SimplifyRb.simplify(points, 0.0000005, true)
      Track.create!(json: to_geojson(points), created_at: t.points.last.time)
    end
  end

  def self.to_geojson(points)
    geo_json = '{"type": "Feature", "geometry": {"type": "MultiLineString","coordinates": [['
    points.each { |tp| geo_json += '[' + "#{tp[:y].to_f}" + ', ' + "#{tp[:x].to_f}" + '], ' }
    geo_json = geo_json[0..-3]
    geo_json += ']]}}'
    geo_json
  end

end
