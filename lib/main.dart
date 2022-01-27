import 'package:flutter/material.dart';
import 'package:todolist/Homepage/homepage.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'To-do List',
      home: SafeArea(child: HomePage()),
    ),
  );
}
