app = angular.module('tj', ['angularMoment', "leaflet-directive"])

app.config ['$httpProvider', ($httpProvider) ->
  # CSFR token
  token = angular.element(document.querySelector('meta[name=csrf-token]')).attr('content')
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = token
  $httpProvider.defaults.headers.common['X-Requested-With'] = "XMLHttpRequest"
]
