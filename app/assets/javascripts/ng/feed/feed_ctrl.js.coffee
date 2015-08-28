angular.module('tj').controller 'FeedCtrl', ['$scope', 'leafletData', '$pusher', '$http', ($scope, leafletData, $pusher, $http) ->

  follow_current_position = true

  $scope.markers = {}
  $scope.paths   = {}
  $scope.center  = {}

  $http.get('/api/tracks.json').then (response) ->
    _.each response.data, (track) ->
      $scope.paths["track_#{track.id}"] = {
        color: 'blue',
        weight: 2,
        latlngs: JSON.parse(track.json)
      }

  $scope.init = (last_position) ->
    $scope.current_position = last_position

    $scope.center = _.merge({ zoom: 12 }, $scope.current_position)

    $scope.markers = { current_position: $scope.current_position }

    $scope.paths.online_track = {
      color: 'red',
      weight: 2,
      latlngs: [ $scope.current_position ]
    }

  $pusher.subscribe 'tj:map:update_current_position', (data) ->
    $scope.markers.current_position = data
    _.merge($scope.center, data) if follow_current_position
    $scope.paths.online_track.latlngs.push data
]