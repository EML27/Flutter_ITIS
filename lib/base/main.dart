import 'package:flutter/material.dart';
import 'domain/entities.dart';
import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Task? _selectedTask;
  List<Task> tasks = [Task("Нулевое задание")];

  void initState() {
    super.initState();
  }

  void handleTaskTap(Task task) {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Navigator(
          pages: [
            MaterialPage(
                key: ValueKey('Home'),
                child: HomePage(tasks: tasks, onTaskSelected: handleTaskTap))
          ],
          onPopPage: (route, result) => route.didPop(result),
        ));
  }
}
