import 'package:flutter/material.dart';

const _primaryColor = Color.fromRGBO(34, 255, 202, 1);
const _backgroundColor = Color.fromRGBO(29, 28, 23, 1);
const _cardBackgroundColor = Color.fromRGBO(23, 22, 18, 1);

ThemeData get theme => ThemeData.dark().copyWith(
      colorScheme: const ColorScheme.dark(
        background: _backgroundColor,
        primary: _primaryColor,
      ),
      scaffoldBackgroundColor: _backgroundColor,
      primaryColor: _primaryColor,
      iconTheme: const IconThemeData(color: _primaryColor),
      inputDecorationTheme:
          const InputDecorationTheme(border: InputBorder.none),
      dividerTheme: const DividerThemeData(
        color: _primaryColor,
        thickness: 2,
        space: 2,
      ),
      snackBarTheme: const SnackBarThemeData(backgroundColor: _primaryColor),
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
        color: _cardBackgroundColor,
        margin: const EdgeInsets.all(8),
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 2.5,
            color: _primaryColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          color: _primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(color: _primaryColor),
        bodyMedium: TextStyle(color: _primaryColor),
      ),
    );
