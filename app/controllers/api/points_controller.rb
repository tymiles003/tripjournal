class Api::PointsController < Api::ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  respond_to :json

  def index
    @points = Point.order(:created_at).all
  end

  def create
    @point = Point.create(point_params)
    respond_with @point
  end

  private

  def point_params
    params.permit(:lat, :lng, :speed, :alt, :hdop)
  end
end
