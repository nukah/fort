//= require_tree .
//= require_self


@app = angular.module("application", [])
@RecordListController = ($scope, $http) ->
  $scope.departments_filter = {}
  $scope.sorter = 'department'
  $http.get('/data.json').success( (data) ->
    $scope.records = data
  )
  $scope.clearQuery = ->
    $scope.departments_filter = {}
    $scope.search = {}