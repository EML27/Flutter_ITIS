import 'package:first_flutter_project/base/domain/entities.dart';
import 'package:first_flutter_project/base/navigation/routes.dart';
import 'package:first_flutter_project/base/screens/home.dart';
import 'package:first_flutter_project/base/screens/zero.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  Task? _selectedTask;
  List<Task> tasks = [
    Task("Нулевое задание", 0),
    Task("Первое задание. Чат", 1),
  ];

  @override
  Future<void> setNewRoutePath(AppRoutePath appRoutePath) async {
    int? id = appRoutePath.id;
    _selectedTask = (id != null) ? tasks[id] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
            key: ValueKey('Home'),
            child: HomePage(tasks: tasks, onTaskSelected: _handleTaskTapped)),
        if (_selectedTask != null)
          if (_selectedTask!.taskNumber == 0)
            MaterialPage(key: ValueKey('Zero'), child: ZeroScreen())
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedBook to null
        _selectedTask = null;
        notifyListeners();

        return true;
      },
    );
  }

  void _handleTaskTapped(Task task) {
    _selectedTask = task;
    notifyListeners();
  }

  AppRoutePath get currentConfiguration {
    int? num;
    if (_selectedTask != null) {
      num = _selectedTask!.taskNumber;
    }
    switch (num) {
      case 0:
        return AppRoutePath.zero();
      case 1:
        return AppRoutePath.chat();
    }
    return AppRoutePath.home();
  }
}
