#!/usr/bin/env ruby
require 'gpx'
require 'net/http'

# host = 'abolmasov.pro'
host = 'localhost:3000'

gpx =  GPX::GPXFile.new(:gpx_file => '/users/graf/Downloads/small.gpx')
gpx.tracks.first.points.first(1000).each do |point|
  uri = URI("http://#{host}/api/points")
  sleep(2)
  Net::HTTP.post_form(uri, {lat: point.lat, lng: point.lon})
end