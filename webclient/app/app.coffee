'use strict';
#TODO einen weg finden module dependencies programatisch zu erweitern.
app = angular.module 'interactiveLecture', ['interactiveLecture.codeArea',"ui.router","interactiveLecture.courses","interactiveLecture.chapters","interactiveLecture.exercise","interactiveLecture.lectures"]
