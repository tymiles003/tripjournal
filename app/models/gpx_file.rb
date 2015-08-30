class GpxFile

  def self.read(filename)
    gpx =  GPX::GPXFile.new(gpx_file: filename)
    gpx.tracks.map do |t|
      {
          points: t.points.map { |p| { x: p.lat, y: p.lon } },
          created_at: t.points.last.time
      }
    end
  end

end