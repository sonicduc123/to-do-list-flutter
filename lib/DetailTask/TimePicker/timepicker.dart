import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({Key? key, required this.timeController}) : super(key: key);

  final TextEditingController timeController;
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void dispose() {
    widget.timeController.dispose();
    super.dispose();
  }

  initState() {
    super.initState();
    setState(() {
      widget.timeController.text = '11:59 PM';
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
        widget.timeController.text = picked_s.format(context);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Time'),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.timeController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  _selectTime(context);
                },
                icon: Icon(
                  Icons.access_alarm,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
