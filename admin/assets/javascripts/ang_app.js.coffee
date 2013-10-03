@app = angular.module("admin_interface", ['ngResource'])

class RecordService
  constructor: ($resource) ->
    @records = $resource './data/records', {},
    update:
      method: 'PUT'
    query:
      method: 'GET'
      isArray: true

    @records

  RecordService::query = () ->
    @records.query()

class Routes
  constructor: ($routeProvider) ->
    $routeProvider
    .when '/',
      controller: 'recordsController'
      templateUrl: 'records.html'
    .otherwise
      redirectTo: '/'

class RecordElement
  constructor: () ->
    link = ($scope, element, attributes) ->
      $scope.editForm = () ->
        $scope.edit = true

      $scope.saveRecord = (record) ->
        record.$update()
        $scope.edit = false

    return {
      link
      restrict: 'A'
      transclude: true
      require: '^ngModel'
      replace: false
      templateUrl: '/templates/record/edit.html'
      scope:
        edit: '@false'
        saveRecord: '&'
        record: '=ngModel'
        editForm: '&editForm'
    }

class RecordsController
  constructor: ($scope, recordService) ->
    $scope.records = recordService.query()



@app.config ['$routeProvider', Routes]
@app.service 'recordService', ['$resource', RecordService]
@app.directive 'recordElement', [RecordElement]
@app.controller 'recordsController', ['$scope', 'recordService', RecordsController]