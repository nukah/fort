(function() {
  var RecordElement, RecordService, RecordsController, Routes;
  this.app = angular.module("admin_interface", ['ngResource']);
  RecordService = (function() {
    function RecordService($resource) {
      this.records = $resource('./data/records', {}, {
        update: {
          method: 'PUT'
        },
        query: {
          method: 'GET',
          isArray: true
        }
      });
      this.records;
    }
    RecordService.prototype.query = function() {
      return this.records.query();
    };
    return RecordService;
  })();
  Routes = (function() {
    function Routes($routeProvider) {
      $routeProvider.when('/', {
        controller: 'recordsController',
        templateUrl: 'records.html'
      }).otherwise({
        redirectTo: '/'
      });
    }
    return Routes;
  })();
  RecordElement = (function() {
    function RecordElement() {
      var link;
      link = function($scope, element, attributes) {
        $scope.editForm = function() {
          return $scope.edit = true;
        };
        return $scope.saveRecord = function(record) {
          record.$update();
          return $scope.edit = false;
        };
      };
      return {
        link: link,
        restrict: 'A',
        transclude: true,
        require: '^ngModel',
        replace: false,
        templateUrl: '/templates/record/edit.html',
        scope: {
          edit: '@false',
          saveRecord: '&',
          record: '=ngModel',
          editForm: '&editForm'
        }
      };
    }
    return RecordElement;
  })();
  RecordsController = (function() {
    function RecordsController($scope, recordService) {
      $scope.records = recordService.query();
    }
    return RecordsController;
  })();
  this.app.config(['$routeProvider', Routes]);
  this.app.service('recordService', ['$resource', RecordService]);
  this.app.directive('recordElement', [RecordElement]);
  this.app.controller('recordsController', ['$scope', 'recordService', RecordsController]);
}).call(this);
