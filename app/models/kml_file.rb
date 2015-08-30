require 'zip'

class KmlFile

  def self.read(filename)
    data = read_file(filename)
    coords = data.css('gxXcoord').to_a
    created_at = data.css('when').to_a.last
    points = coords.map do |c|
      x_y_z = c.content.split(' ')
      { x: x_y_z[1].to_f, y: x_y_z[0].to_f }
    end
    [{ points: points, created_at: created_at }]
  end

  private

  def self.read_file(filename)
    ext = filename[-3..-1]
    if ext == 'kmz'
      Nokogiri::XML(read_kmz(filename))
    elsif ext == 'kml'
      Nokogiri::XML(read_kml(filename))
    else
      raise 'Unsupported format'
    end
  end

  def self.read_kml(filename)
    File.read(filename).gsub('gx:', 'gxX')
  end

  def self.read_kmz(filename)
    kml = ''
    Zip::InputStream.open(filename) do |io|
      while io.get_next_entry
        kml << io.read.gsub('gx:', 'gxX')
      end
    end
    kml
  end
end