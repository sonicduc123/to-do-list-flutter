class Task {
  final int id;
  final String title;
  final String date;
  final String time;

  Task(this.id, this.title, this.date, this.time);

  Map<String, dynamic> toMap() {
    return {
      'taskID': id,
      'taskTitle': title,
      'taskDate': date,
      'taskTime': time
    };
  }
}
