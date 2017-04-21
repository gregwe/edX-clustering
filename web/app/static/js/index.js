var app = angular.module('dvisual', ['ngMaterial'])
.config(function($mdThemingProvider){

  $mdThemingProvider.theme('default')
  .primaryPalette('teal')
  .backgroundPalette('grey')
  .accentPalette('blue-grey')
  .warnPalette('red');
});

app.config(['$qProvider', function ($qProvider) {
    $qProvider.errorOnUnhandledRejections(false);
}]);

app.directive('fileModel', ['$parse', function ($parse) {
  return {
     restrict: 'A',
     link: function(scope, element, attrs) {
        var model = $parse(attrs.fileModel);
        var modelSetter = model.assign;

        element.bind('change', function(){
           scope.$apply(function(){
              modelSetter(scope, element[0].files[0]);
           });
        });
     }
  };
}]);

app.service('fileUpload', ['$http', function ($http) {
  this.uploadFileToUrl = function(file, uploadUrl){
     var fd = new FormData();
     fd.append('file', file);

     $http.post(uploadUrl, fd, {transformRequest: angular.identity,headers: {'Content-Type': undefined}})
      .then(function(data, status, headers, config){
        console.log(data);
      });
  }
}]);

app.controller("mainCtrl", function($scope, $http, $window, fileUpload) {
    $scope.uploadFile = function(){
    var file = $scope.myFile;

    console.log('file is ' );
    console.dir(file);

    var uploadUrl = "/fileUploadAPI";
    fileUpload.uploadFileToUrl(file, uploadUrl);
  };
});