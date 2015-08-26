#!/usr/bin/env ruby
require 'gpx'
require 'net/http'

gpx =  GPX::GPXFile.new(:gpx_file => '/users/graf/Downloads/doc.gpx')
gpx.tracks.first.points.drop(1000).first(2000).each do |point|
  uri = URI('http://abolmasov.pro/api/points')
  Net::HTTP.post_form(uri, {lat: point.lat, lng: point.lon})
end