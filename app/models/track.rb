class Track < ActiveRecord::Base

  def self.create_from_points(points, created_at)
    Track.create!(json: to_geojson(simplify(points)), created_at: created_at)
  end

  def self.import(file)
    gpx =  GPX::GPXFile.new(gpx_file: file)
    gpx.tracks.map do |t|
      points = t.points.map { |p| { x: p.lat, y: p.lon } }
      create_from_points(points, t.points.last.time)
    end
  end

  def self.to_geojson(points)
    geo_json = '{"type": "Feature", "geometry": {"type": "MultiLineString","coordinates": [['
    points.each { |tp| geo_json += '[' + "#{tp[:y].to_f}" + ', ' + "#{tp[:x].to_f}" + '], ' }
    geo_json = geo_json[0..-3]
    geo_json += ']]}}'
    geo_json
  end

  def self.simplify(points)
    SimplifyRb.simplify(points, 0.0000005, true)
  end

end
