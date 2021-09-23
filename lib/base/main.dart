import 'package:first_flutter_project/base/navigation/AppRouteInformationParser.dart';
import 'package:first_flutter_project/base/navigation/AppRouterDelegate.dart';
import 'package:flutter/material.dart';
import 'domain/entities.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppRouterDelegate _appRouterDelegate = AppRouterDelegate();
  AppRouteInformationParser _appRouteInformationParser =
      AppRouteInformationParser();

  void initState() {
    super.initState();
  }

  void handleTaskTap(Task task) {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Le App',
        routeInformationParser: _appRouteInformationParser,
        routerDelegate: _appRouterDelegate);
  }
}
