function initVar(){
    var blocs = [];
}


function initData(scope, http) {
    http.get('/appPrincipale/princ').then(function (response) {
        
        scope.blocs = response.data;
        console.log("blocs", scope.blocs);
            //scope.scope.info.schoolName = response.schoolName;
        }).catch(function (error) {
            console.error('Error fetching data:', error);
        });
}

function initView(scope) {
    scope.showAddInfo = false;
    scope.showAddSchool = false;
    scope.showAddBloc = false;
    scope.showAddQuestion = false;
    scope.showMessage = false;
    
    scope.editMode = false;
    scope.isSpecialiteDropdownOpen = false;
    scope.isCadreDropdownOpen = false;
    scope.showPrinc = true;
}



function dropdown(typed, scope) {
    if (typed === 'cadre') {
        console.log("cadre");
        scope.isCadreDropdownOpen = !scope.isCadreDropdownOpen;
        if (scope.isCadreDropdownOpen) {
            scope.isSpecialiteDropdownOpen = false;
        }
    } else if (typed === 'specialite') {
        console.log("specialite");
        scope.isSpecialiteDropdownOpen = !scope.isSpecialiteDropdownOpen;
        if (scope.isSpecialiteDropdownOpen) {
            scope.isCadreDropdownOpen = false;
        }
    }
}


function move(index, direction, scope) {
    if (direction === 'up') {
        if (index > 0) {
            var temp = $scope.phrases[index];
            $scope.phrases[index] = $scope.phrases[index - 1];
            $scope.phrases[index - 1] = temp;
        }
    } else if (direction === 'down') {
        if (index < $scope.phrases.length - 1) {
            var temp = $scope.phrases[index];
            $scope.phrases[index] = $scope.phrases[index + 1];
            $scope.phrases[index + 1] = temp;
        }
    }
}





function addInformation(scope, http) {
    console.log("addInf");
    var data = {
        action: "addInformation",
        schoolName: scope.info.schoolName,
        schoolLogo: scope.info.schoolLogo,
        file: scope.info.file
    };
    console.log(data);
    http.post('/appPrincipale/princ', data).then(function (response) {
        if (response.status === 204) {
            scope.message = "information was added";
        } else {
            scope.message = "failed to add information";
        }
        scope.showMessage = true;
    });
}

function addSchool(scope, http) {
    console.log("addSchool");
    var data = {
        action: "addSchool",
        schoolName: scope.university.schoolName,
        country: scope.university.country,
        cadreOptions: scope.university.cadreOptions,
        specialite: scope.university.specialite
    };

    console.log(data); 
    http.post('/appPrincipale/princ', data).then(function (response) {
        if (response.status === 204) {
            scope.message = "school was added";
        } else {
            scope.message = "failed to add a school";
        }
        scope.showMessage = true;
    });
}



/*function addBlocs(scope, http) {
    var data = {
        action: "addBloc",
        blocs: scope.blocs
    }
    console.log("addBloc", data);
    http.post('/appPrincipale/princ', data).then(function (response) {
        if (response.status === 204) {
            scope.message = "bloc was added";
        } else {
            scope.message = "failed to add a bloc";
        }
        scope.showMessage = true;
    });
}*/








function click(button, scope, http) {
    initView(scope);
   
    switch (button) {
        case "addPrinc":
            scope.showPrinc = true;
        break;
        case "addInfo":
            scope.showPrinc = false;
            scope.showAddInfo = true;
            break;
        case "addSchool":
            scope.showPrinc = false;
            scope.showAddSchool = true;
            break;
        case "addBloc":
            scope.showPrinc = false;
            scope.showAddBloc = true;
            break;
        case "addQuestion":
            scope.showPrinc = false;
            scope.showAddQuestion = true;
            break;
    }
}

function OK(action, scope, http) {
    initView(scope);
    switch (action) {
        case "addInfo":
            addInformation(scope, http);
            break;
        case "addSchool":
            addSchool(scope, http);
        break;
        
        
    }
}

var app = angular.module('myApp', []);
app.controller('myCtrl', function ($scope, $http) {
    console.log("myCtrl");
    
    //initData($scope, $http);
    initView($scope);


    $scope.doClick = function (button) {
        click(button, $scope, $http);
    };
    $scope.doOK = function (action) {
        OK(action, $scope, $http);

    };
    $scope.toggleEditMode = function () {
        $scope.editMode = true;
    };

    $scope.save = function () {
        $scope.editMode = false;
    };
    
    $scope.toggleDropdown = function (type) {
        console.log("toggleDropdown");
        dropdown(type, $scope);
    };
    $scope.blocs = [];

    /*$scope.blocs = [
        { 
            title: 'Bloc 1',
            isVisible: false,
            questions: [
                { id: 1, content: 'Question 1.1', isVisible: true },
                { id: 2, content: 'Question 1.2', isVisible: true }
            ]
        },
        { 
            title: 'Bloc 2',
            isVisible: false,
            questions: [
                { id: 3, content: 'Question 2.1', isVisible: true },
                { id: 4, content: 'Question 2.2', isVisible: true }
            ]
        },
        { 
            title: 'Bloc 3',
            isVisible: false,
            questions: [
                { id: 5, content: 'Question 3.1', isVisible: true },
                { id: 6, content: 'Question 3.2', isVisible: true }
            ]
        }
    ];*/

$scope.addBloc = function() {
    var content = prompt('Entrez la nouvelle question:');
        if (content) {
            $scope.blocs.push({ title: content, isVisible: false, questions: [] });
    
            
            var data = {
                action: "addBloc",
                blocName: content,
            };
            console.log(data);
    
            // Send the data to the servlet
            $http.post('/appPrincipale/princ', data).then(function(response) {
                if (response.status === 204) {
                    alert("bloc added successfully");
                } else {
                    alert("Failed to add the bloc");
                }
            }).catch(function(error) {
                console.error('Error:', error);
                alert("Failed to add the bloc");
            });
        }

    
};
    $scope.move = function (index, direction) {
        move(index, direction, $scope);
    };

    $scope.toggleDisplay = function(phrase) {
        phrase.display = !phrase.display;
    };

    $scope.deleteBloc = function(index) {
        if (confirm('Êtes-vous sûr de vouloir supprimer ce bloc?')) {
            
            var bloc = $scope.blocs[index];
            
            
            $scope.blocs.splice(index, 1);
    
            
            var data = {
                action: "deleteBloc",
                blocName: bloc.title,
                blocId: bloc.id 
            };

            console.log(data)
    
            
            $http.post('/appPrincipale/princ', data).then(function(response) {
                if (response.status === 204) {
                    alert("Bloc deleted successfully");
                } else {
                    alert("Failed to delete the bloc");
                }
            }).catch(function(error) {
                console.error('Error:', error);
                alert("Failed to delete the bloc");
            });
        }
    };
    // Ajouter une nouvelle question
    $scope.addQuestion = function(bloc) {
        var content = prompt('Entrez la nouvelle question:');
        if (content) {
            var newQuestion = { id: Date.now(), content: content, isVisible: true };
            bloc.questions.push(newQuestion);
    
            // Prepare the data to be sent to the servlet
            var data = {
                action: "addQuestion",
                blocName: bloc.title,
                questionId: newQuestion.id,
                questionContent: newQuestion.content
            };
            console.log(data);
    
            // Send the data to the servlet
            $http.post('/appPrincipale/princ', data).then(function(response) {
                if (response.status === 204) {
                    alert("Question added successfully");
                } else {
                    alert("Failed to add the question");
                }
            }).catch(function(error) {
                console.error('Error:', error);
                alert("Failed to add the question");
            });
        }
    };
    

    // Supprimer une question deleteQuestion(block, question.id)
    $scope.deleteQuestion = function(bloc, id) {

        if (confirm('Êtes-vous sûr de vouloir supprimer cette question?')) {
            // Find the index of the question to delete
            var questionIndex = bloc.questions.findIndex(question => question.id === id);
            var question = bloc.questions[questionIndex];
            var questionContent = question.content;
            console.log(questionContent);
            
            if (questionIndex !== -1) {
                // Remove the question from the array
                bloc.questions.splice(questionIndex, 1);
    
                // Prepare the data to be sent to the servlet
                var data = {
                    action: "deleteQuestion",
                    blocName: bloc.title,
                    questionId: questionIndex,
                    question : questionContent
                }

                console.log(data)
    
                // Send the data to the servlet
                $http.post('/appPrincipale/princ', data).then(function(response) {
                    if (response.status === 204) {
                        alert("Question deleted successfully");
                    } else {
                        alert("Failed to delete the question");
                    }
                }).catch(function(error) {
                    console.error('Error:', error);
                    alert("Failed to delete the question");
                });
            }
        }
    };
    
    
    

    // Masquer/Afficher une question
    $scope.toggleQuestionVisibility = function(question) {
        question.isVisible = !question.isVisible;
    };

    // Masquer/Afficher un bloc
    $scope.toggleBlockVisibility = function(block) {
        block.isVisible = !block.isVisible;
    };

    // Déplacer une question
    $scope.moveQuestion = function(block, question, direction) {
        var index = block.questions.indexOf(question);
        var newIndex = index + direction;

        if (newIndex >= 0 && newIndex < block.questions.length) {
            block.questions.splice(index, 1);
            block.questions.splice(newIndex, 0, question);
        }
    };

    $scope.editMode = false;
});