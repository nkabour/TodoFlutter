import 'package:flutter/material.dart';

const int SmallFont = 12;
const int MediumFont = 16;
const int LargeFont = 18;

const Color PrimaryColor = Color.fromRGBO(90, 109, 216, 1);
const Color SeconderyColor = Color.fromRGBO(115, 131, 222, 1);


TextTheme todoTxtTheme = TextTheme(
    headline5: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    caption: TextStyle(color: Colors.black38));

AppBarTheme todoAppBarTheme = AppBarTheme(
    centerTitle: true,
    elevation: 0.0,
    );


InputDecorationTheme  todoInputDecorator = InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            fillColor: Colors.grey[200],
            filled: true,

        );


ButtonThemeData todoButtonTheme = ButtonThemeData(
          buttonColor: Colors.indigo,
          splashColor: Colors.indigo[600],
          textTheme: ButtonTextTheme.primary,
        );