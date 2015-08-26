class FeedsController < ApplicationController
  def index
    @current_position = Point.last || Point.new(lat: 53.1958769, lng: 50.1283811)
  end

  def reset
    Point.delete_all
  end
end
