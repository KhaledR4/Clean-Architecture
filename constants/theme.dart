import 'package:flutter/material.dart';

const darkBackgroundColor = Color.fromRGBO(34, 34, 63, 1);
const darkCardColor = Color.fromRGBO(28, 39, 85, 1);
const darkButtonTextColor = Colors.white;
const darkButtonBackPressedColor = Color.fromRGBO(6, 60, 254, 1);
const darkButtonBackColor = Color.fromRGBO(71, 111, 254, 1);
const buttonColor = Color.fromRGBO(54, 88, 215, 1);
const focussedInputColor = Colors.white;
const enabledInputColor = Colors.grey;

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  backgroundColor: darkBackgroundColor,
  cardColor: darkCardColor,

  // Containers
  cardTheme: CardTheme(
    color: darkCardColor, // Background color
    elevation: 4, // Elevation (shadow)
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
    ),
  ),


  // Text
  textTheme: const TextTheme(
    labelSmall: TextStyle(fontSize: 9),
  ),

  // Input
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: focussedInputColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: enabledInputColor),
    ),
  ),

  // Buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 16),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(fontSize: 16), 
        ),
        elevation: MaterialStateProperty.all<double>(4),
        shadowColor: MaterialStateProperty.all<Color>(
          Colors.black.withOpacity(0.3),
        ),
         backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return darkButtonBackPressedColor;
            }
            return darkButtonBackColor; 
          },
        ),
        foregroundColor: MaterialStateProperty.all<Color>(darkButtonTextColor),
      ),
  )

);
