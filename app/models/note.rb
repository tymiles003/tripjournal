class Note < ActiveRecord::Base
  include Location

  enum kind: [ :text, :photo ]

end
