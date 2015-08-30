class MapController < ApplicationController

  def index
    @current_position = center_point
  end

  private

  def center_point
    Point.last || Note.where('latlng is not null').order(created_at: :desc).first || Point.new(lat: 53.1958769, lng: 50.1283811)
  end

end
