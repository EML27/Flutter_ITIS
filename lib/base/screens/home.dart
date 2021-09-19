import 'package:first_flutter_project/base/domain/entities.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Task> tasks;
  final ValueChanged<Task> onTaskSelected;

  HomePage({required this.tasks, required this.onTaskSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          for (var task in tasks)
            ListTile(
              title: Text(task.name),
              onTap: () => onTaskSelected(task),
            )
        ],
      ),
    );
  }
}
