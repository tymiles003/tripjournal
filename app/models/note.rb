class Note < ActiveRecord::Base
  enum kind: [ :text, :photo ]
end
