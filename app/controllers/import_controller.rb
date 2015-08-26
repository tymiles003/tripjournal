class ImportController < ApplicationController

  def show

  end

  def create
    Point.import(params[:file].tempfile)
    redirect_to import_url
  end

end