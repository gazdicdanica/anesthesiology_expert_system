import 'package:flutter/material.dart';

const textColor = Color.fromARGB(255, 72, 75, 73);
const seedColor = Color.fromARGB(255, 64, 123, 255);
const logoutColor = Color.fromARGB(255, 203, 218, 251);
const snackBarColor = Color.fromARGB(255, 40,78,162);

final theme = ThemeData.light().copyWith(
  colorScheme:
      ColorScheme.fromSeed(seedColor: seedColor),
  textTheme: ThemeData.light().textTheme.copyWith(
        titleMedium: const TextStyle(
          fontSize: 25,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 5,
      padding: const EdgeInsets.all(15),
      backgroundColor: seedColor,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    )
  ),


);
