angular.module('tj').factory '$pusher', ['$rootScope', ($rootScope) ->
  _pusher = new Pusher(Rails.pusher_key)

  _channel = undefined

  subscribe: (event, callback) ->
    _channel = _channel || _pusher.subscribe("tj.#{Rails.env}")

    _channel.bind 'pusher:subscription_error', (data) ->
      console.log(data) if console

    _channel.bind event, (data) ->
      $rootScope.$apply ()->
        callback(data)

]
