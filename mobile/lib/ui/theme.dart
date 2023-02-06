import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = Provider(
  (ref) {
    return ThemeData(
      primarySwatch: Colors.pink,
    );
  },
);
