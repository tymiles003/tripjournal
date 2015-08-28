class Api::TracksController < Api::ApplicationController

  def index
    @tracks = Track.all
  end

end
