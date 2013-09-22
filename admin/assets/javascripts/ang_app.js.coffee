@app = angular.module("admin_interface", ['restangular']).
  config( ($routeProvider, RestangularProvider) ->
    $routeProvider.
    when('/', {controller: RecordsController, templateUrl: 'records.html'}).
    when('/update/:rid', {controller: RecordEditController, templateUrl: '/templates/record/edit.partial.html', resolve: { record: (Restangular, $route) ->
      Restangular.one('records', $route.current.params.rid).get() }}).
    otherwise({redirectTo: '/'})
    RestangularProvider.setBaseUrl('/admin/data')
    RestangularProvider.setRestangularFields({id: '_id'})
  )

@app.directive 'recordElement', ->
  {
    restrict: 'A'
    transclude: true
    replace: false
    templateUrl: '/templates/record/edit.html'
    scope: {
      edit: '@false'
      record: '=recordModel'
      saveRecord: '&'
      editForm: '&editForm'
    }
    link: ($scope, element, attributes) ->
      $scope.editForm = () ->
        $scope.edit = true

      $scope.saveRecord = () ->
        $scope.edit = false
  }

@RecordsController = ($scope, Restangular) ->
  $scope.records = Restangular.all('records').getList()

  $scope.saveRecord = (record) ->
    me


@RecordEditController = ($scope, Restangular) ->
