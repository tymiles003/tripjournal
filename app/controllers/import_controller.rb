class ImportController < ApplicationController

  def show

  end

  def track
    Track.import(params[:file].tempfile.path)
    redirect_to import_url
  end

  def instagram
    SyncJob.perform_later
  end

end