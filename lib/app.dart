import 'package:flutter/material.dart';
import 'package:to_do_app/screens/Todo/todo.dart';
import 'package:to_do_app/screens/add/add.dart';
import 'screens/onload/onload.dart'; 
import 'package:to_do_app/classes/Todo.dart';
import "style.dart"; 


const LaunchScreen = '/'; 
const TodoScreen = '/todos'; 
const EditScreen = '/edit-todo';
const AddScreen = '/add-todo';

class App extends StatelessWidget {

  @override 
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Jumpin',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: todoTxtTheme,
        appBarTheme: todoAppBarTheme,
        inputDecorationTheme: todoInputDecorator,
        buttonTheme: todoButtonTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: _routes(),
    );
  }
  

  RouteFactory _routes(){

    return (settings) {

      final Map<String, dynamic> arguments = settings.arguments; 
      Widget screen; 
      switch(settings.name){
        case LaunchScreen: 
              screen = SplashScreen(); 
              break; 
        case TodoScreen:
              screen = TodoWidget(); 
              break; 
        case AddScreen: 
              screen = AddTodo(); 
              break; 
        case EditScreen: 
              screen = AddTodo(index: arguments["id"]); 
              break; 
        default: 
              return null; 

      }

      return MaterialPageRoute(builder: (BuildContext context) => screen);

    };

  }
  
}


