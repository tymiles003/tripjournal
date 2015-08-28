module Location
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
end