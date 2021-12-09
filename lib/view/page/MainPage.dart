import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widoo_app/bloc/ActivityBloc.dart';
import 'package:widoo_app/config/AppConfig.dart';
import 'package:widoo_app/repository/ActivityRepository.dart';
import 'package:widoo_app/view/page/ActivityHistoryPage.dart';
import 'package:widoo_app/view/page/CurrentActivityPage.dart';
import 'package:widoo_app/view/page/NewActivityPage.dart';

class MainPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MainPage());
  }

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<_MainPageScreenInfo> _screenInfos = [
    _MainPageScreenInfo(
      title: 'Activité',
      screen: CurrentActivityPage(),
      navigationBarItem: BottomNavigationBarItem(
        icon: Icon(Icons.view_array_rounded),
        label: "Activité",
      ),
    ),
    _MainPageScreenInfo(
      title: 'Nouvelle',
      screen: NewActivityPage(),
      navigationBarItem: BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: "Nouvelle",
      ),
    ),
    _MainPageScreenInfo(
      title: 'Terminées',
      screen: ActivityHistoryPage(),
      navigationBarItem: BottomNavigationBarItem(
        icon: Icon(Icons.check),
        label: "Terminées",
      ),
    ),
  ];

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          AppConfig.instance.title,
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return BlocProvider<ActivityBloc>(
      create: (context) =>
          ActivityBloc(activityRepository: context.read<ActivityRepository>()),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: _screenInfos.elementAt(_selectedIndex).screen,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: _screenInfos.map((info) => info.navigationBarItem).toList(),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class _MainPageScreenInfo {
  final String title;
  final Widget screen;
  final BottomNavigationBarItem navigationBarItem;

  const _MainPageScreenInfo({
    required this.title,
    required this.screen,
    required this.navigationBarItem,
  });
}
