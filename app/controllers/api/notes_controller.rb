class Api::NotesController < ApplicationController

  def index
    @notes = Note.where('latlng is not null')
  end

end
