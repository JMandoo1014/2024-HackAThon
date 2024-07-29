class Todo {
  String task;
  bool completed;
  int priority;
  DateTime date;

  Todo({
    required this.task,
    this.completed = false,
    this.priority = 1,
    required this.date,
  });
}
