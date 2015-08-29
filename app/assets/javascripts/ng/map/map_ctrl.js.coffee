angular.module('tj').controller 'MapCtrl', ['$scope', 'leafletData', '$pusher', '$http', ($scope, leafletData, $pusher, $http) ->

  follow_current_position = true

  $scope.defaults = {
    zoomControl: false
  }
  $scope.markers = {}
  $scope.paths   = {}
  $scope.geojson = {
    data: [],
    style: {
      fillColor: "blue",
      weight: 2,
      opacity: 1,
      color: 'white',
      dashArray: '3',
      fillOpacity: 0.7
    }
  }
  $scope.center  = {}

  $http.get('/api/points.json').then (response) ->
    $scope.paths.saved_track = {
      color: 'blue',
      weight: 2,
      latlngs: response.data
    }

  $http.get('/api/tracks.json').then (response) ->
    $scope.geojson = {
      data: response.data
    }

  $http.get('/api/notes.json').then (response) ->
    _.each response.data, (note) ->
      $scope.markers["note_#{note.id}"] = {
        lat: note.lat,
        lng: note.lng,
        compileMessage: true,
        message: "<div class='map-note-image'><img class='img-responsive' src='#{note.image_url}'/>@#{note.author}</div>"
        icon: {
          type: 'awesomeMarker',
          icon: _note_icon(note.kind)
          prefix: 'fa',
        }
      }

  $scope.init = (last_position) ->
    $scope.current_position = {
      lat: last_position.lat,
      lng: last_position.lng,
      icon: {
        type: 'awesomeMarker',
        icon: 'car',
        markerColor: 'red',
        prefix: 'fa',
      }
    }

    $scope.center = {
      zoom: 16,
      lat: last_position.lat,
      lng: last_position.lng,
      autoDiscover: false
    }

    $scope.markers = { current_position: $scope.current_position }

    $scope.paths.online_track = {
      color: 'red',
      weight: 2,
      latlngs: [ last_position ]
    }

  $pusher.subscribe 'tj:map:update_current_position', (data) ->
    $scope.current_position.lat = data.lat
    $scope.current_position.lng = data.lng
    if follow_current_position
      $scope.center.lat = data.lat
      $scope.center.lng = data.lng
    $scope.paths.online_track.latlngs.push data

  _note_message = (note) ->
    if note_type == 'photo'
      "<div class='map-note-image'><img class='img-responsive' src='#{note.image_url}'/>@#{note.author}</div>"
    else
      "<div class='map-note-text'>@#{note.text}</div>"

  _note_icon = (note_type) ->
    if note_type == 'photo'
      'instagram'
    else
      'comment'
]