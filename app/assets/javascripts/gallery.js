angular.module('TNStudio', ['lk-google-picker'])

.config(['lkGoogleSettingsProvider', function (lkGoogleSettingsProvider) {

  // Configure the API credentials here
  lkGoogleSettingsProvider.configure({
    apiKey   : ' AIzaSyCr7ziT1CQ-gxTRBAzcMuVCOYP6RCkbnos ',
    clientId : '212621071280-sjjdcrj2g47uk27nc0ona1dfdtm3bk6a.apps.googleusercontent.com',
    scopes   : ['https://www.googleapis.com/auth/drive'],
    locale   : 'fr',
    features : ['MULTISELECT_ENABLED']
  });
}])

.controller('TNStudioCtrl', ['$scope', 'lkGoogleSettings', function ($scope, lkGoogleSettings) {
  $scope.files = [];

  // Callback triggered after Picker is shown
  $scope.onLoaded = function () {
    console.log('Google Picker loaded!');
  }

  // Callback triggered after selecting files
  $scope.onPicked = function (docs) {
    angular.forEach(docs, function (file, index) {
      $scope.files.push(file);
    });
  }

  // Callback triggered after clicking on cancel
  $scope.onCancel = function () {
    console.log('Google picker close/cancel!');
  }
}]);