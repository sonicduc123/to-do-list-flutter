import 'package:flutter/material.dart';
import 'package:todolist/model/task.dart';

typedef CheckboxCallback = void Function(bool checkboxValue, int index);

/// This is the stateful widget that the main application instantiates.
class TaskCard extends StatefulWidget {
  const TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = false;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Card(
          child: CheckboxListTile(
            title: Text(widget.task.title),
            subtitle: Row(
              children: [
                Text(widget.task.date),
                SizedBox(width: 20),
                Text(widget.task.time),
              ],
            ),
            value: isSelected == true,
            onChanged: (bool? newValue) {
              setState(() {
                isSelected = newValue!;
              });
            },
            // secondary: IconButton(
            //   onPressed: () {
            //     // Navigator.push(context,
            //     //     MaterialPageRoute(builder: (context) => DetailTask()));
            //   },
            //   icon: Icon(Icons.edit),
            // ),
          ),
        );
      },
    );
  }
}
