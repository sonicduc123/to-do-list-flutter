import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/DetailTask/detailtask.dart';
import 'package:todolist/Homepage/Filter/filter.dart';
import 'package:todolist/Homepage/TaskCard/taskcard.dart';
import 'package:todolist/data-access/taskDAO.dart';
import 'package:todolist/model/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> listTask = [];
  List<Task> listTaskCurrent = [];
  TextEditingController searchController = new TextEditingController();

  String dropdownValue = 'All';

  void filterListTask() {
    if (dropdownValue == 'All') {
      listTaskCurrent = [];
      listTask.forEach((task) {
        listTaskCurrent.add(task);
      });
    } else if (dropdownValue == 'Today') {
      listTaskCurrent = [];

      String toDay = DateTime.now().toString().substring(0, 10);
      listTask.forEach((task) {
        if (task.date == toDay) {
          listTaskCurrent.add(task);
        }
      });
    } else if (dropdownValue == 'Upcoming') {
      listTaskCurrent = [];

      listTask.forEach((task) {
        DateTime date = DateTime.parse(task.date);
        DateTime toDay = DateTime.now();
        if (date.isAfter(toDay)) {
          listTaskCurrent.add(task);
        }
      });
    }
  }

  // void checkboxCallback(bool _isCheck, int index) {
  //   setState(() {
  //     listCheckValue[index] = _isCheck;
  //     //filterListTask();
  //   });
  // }

  void dropdownCallback(String _dropdownValue) {
    setState(() {
      dropdownValue = _dropdownValue;
      filterListTask();
    });
  }

  @override
  void initState() {
    TaskDAO taskDAO = new TaskDAO();
    taskDAO.getTasks().then(
          (value) => setState(() {
            value.forEach(
              (element) {
                listTask.add(element);
                listTaskCurrent.add(element);
              },
            );
          }),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget searchBar = CupertinoSearchTextField(
      controller: searchController,
      onChanged: (value) {
        if (value == '') {
          setState(() {
            filterListTask();
          });
        }
      },
      onSubmitted: (value) {
        setState(() {
          List<Task> result = [];
          filterListTask();
          listTaskCurrent.forEach((task) {
            if (task.title.contains(value)) {
              result.add(task);
            }
          });
          listTaskCurrent = [];
          result.forEach((task) {
            listTaskCurrent.add(task);
          });
        });
      },
      placeholder: 'Search task',
    );

    Widget listTaskCard = Expanded(
      child: ListView(
        children: List.generate(
          listTaskCurrent.length,
          (index) => TaskCard(task: listTaskCurrent[index]),
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              searchBar,
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Filter(callback: dropdownCallback),
                  ElevatedButton(onPressed: () {}, child: Text('Done')),
                ],
              ),
              SizedBox(height: 10),
              listTaskCard,
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: 'Add a task',
          onPressed: () async {
            var task = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailTask(
                  taskID: listTask[listTask.length].id + 1,
                ),
              ),
            );
            if (task != null) {
              setState(() {
                listTask.add(task);
                filterListTask();
              });
            }
          },
        ),
      ),
    );
  }
}
