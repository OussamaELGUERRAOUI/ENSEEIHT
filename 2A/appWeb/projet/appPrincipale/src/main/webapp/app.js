var app = angular.module('myApp', ['ngRoute']);

app.config(function($routeProvider) {
    $routeProvider
    .when('/pageA', {
        templateUrl : 'pageA.html',
        controller  : 'PageAController'
    })
    .when('/pageB', {
        templateUrl : 'pageB.html',
        controller  : 'PageBController'
    })
    .otherwise({
        redirectTo: '/pageA' // Redirige vers la pageA par défaut
    });
});

app.controller('PageAController', function($scope) {
    $scope.message = 'Contenu de la page A';
});

app.controller('PageBController', function($scope) {
    $scope.message = 'Contenu de la page B';
});
