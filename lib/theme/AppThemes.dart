import 'package:flutter/material.dart';

import 'DarkTheme.dart';

class AppThemes {
  static final ThemeData dark = DarkTheme().data;
}

abstract class CustomTheme {
  ThemeData get data;
}
