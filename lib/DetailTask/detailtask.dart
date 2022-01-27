import 'package:flutter/material.dart';
import 'package:todolist/DetailTask/TimePicker/timepicker.dart';
import 'package:todolist/data-access/taskDAO.dart';
import 'package:todolist/model/task.dart';

import 'DatePicker/datepicker.dart';

class DetailTask extends StatefulWidget {
  const DetailTask({Key? key, required this.taskID}) : super(key: key);

  final int taskID;

  @override
  _DetailTaskState createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: 'Back',
              );
            },
          ),
          title: Text('Detail Task'),
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.delete))],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title'),
                SizedBox(height: 10),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter your task',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30),
                DatePicker(
                  dateController: dateController,
                ),
                SizedBox(height: 30),
                TimePicker(
                  timeController: timeController,
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (titleController.text != '') {}
                          Task task = Task(
                            widget.taskID,
                            titleController.text,
                            dateController.text,
                            timeController.text,
                          );
                          TaskDAO taskDAO = new TaskDAO();
                          taskDAO.insert(task);
                          Navigator.pop(
                            context,
                            task,
                          );
                        },
                        child: Text('Add')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
