class NotesController < ApplicationController

  def index
    @notes = Note.order(created_at: :desc)
  end

end
