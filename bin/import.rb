#!/usr/bin/env ruby
require 'gpx'
require 'net/http'
require 'ruby-progressbar'

# host = 'abolmasov.pro'
host = 'localhost:3000'

gpx = GPX::GPXFile.new(:gpx_file => '/users/graf/Downloads/small.gpx')
points = gpx.tracks.first.points
progress = ProgressBar.create(total: points.length, format: '%a %B %p%% %r points/sec')
points.each do |point|
  uri = URI("http://#{host}/api/points")
  Net::HTTP.post_form(uri, {lat: point.lat, lng: point.lon})
  progress.increment
end