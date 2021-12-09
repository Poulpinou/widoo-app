import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widoo_app/config/AppConfig.dart';
import 'package:widoo_app/repository/ActivityRepository.dart';
import 'package:widoo_app/theme/AppThemes.dart';
import 'package:widoo_app/view/page/MainPage.dart';

class WidooApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => ActivityRepository()),
        ],
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          title: AppConfig.instance.title,
          theme: AppThemes.dark,
          home: MainPage(),
        ));
  }
}
