class ImportController < ApplicationController

  def show

  end

  def gpx
    Point.import(params[:file].tempfile)
    redirect_to import_url
  end

  def instagram
    SyncJob.perform_later
  end

end