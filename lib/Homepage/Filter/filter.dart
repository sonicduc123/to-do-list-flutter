import 'package:flutter/material.dart';

typedef DropdownCallback = void Function(String dropdownValue);

/// This is the stateful widget that the main application instantiates.
class Filter extends StatefulWidget {
  const Filter({Key? key, required this.callback}) : super(key: key);

  final DropdownCallback callback;
  @override
  State<Filter> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<Filter> {
  String dropdownValue = 'All';

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down_rounded),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
          widget.callback(newValue!);
        },
        items: <String>['All', 'Today', 'Upcoming']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
