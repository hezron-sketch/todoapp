// import 'dart:convert';

class TodoList {
  String name;
  DateTime timeAdded;
  bool isComplete;

  TodoList({
    required this.name,
    required this.timeAdded,
    this.isComplete = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'timeAdded': timeAdded.toIso8601String(),
      'isComplete': isComplete,
    };
  }

  factory TodoList.fromJson(Map<String, dynamic> json) {
    return TodoList(
      name: json['name'],
      timeAdded: DateTime.parse(json['timeAdded']),
      isComplete: json['isComplete'],
    );
  }

  @override
  String toString() {
    return 'Task (name: $name, Time added: $timeAdded, Task status: $isComplete)';
  }
}
