import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'todos.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  _TodoHomeState createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  List<TodoList> taskList = [];

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskStrings =
        taskList.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList('tasks', taskStrings);
  }

  Future<void> _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskStrings = prefs.getStringList('tasks') ?? [];
    setState(() {
      taskList = taskStrings
          .map((taskString) => TodoList.fromJson(jsonDecode(taskString)))
          .toList();
    });
  }

  void _addTask() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        taskList.add(
            TodoList(name: _textController.text, timeAdded: DateTime.now()));
      });
      _textController.clear();
      _saveTasks();
    }
  }

  void _deleteTask(int index) {
    setState(() {
      taskList.removeAt(index);
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          title: Text(
            "Local Tasks",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.green[50]),
          ),
          centerTitle: true,
          backgroundColor: Colors.green[500],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      cursorColor: Colors.green[800],
                      cursorWidth: 3.0,
                      cursorRadius: Radius.circular(10),
                      controller: _textController,
                      decoration: InputDecoration(
                          labelText: "Enter Task",
                          fillColor: Colors.white54,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                    )),
                    ElevatedButton(
                      onPressed: _addTask,
                      style: ElevatedButton.styleFrom(
                          elevation: 3,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(0),
                          backgroundColor: Colors.green[300]),
                      child: Text(
                        "+",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.green[800]),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    final task = taskList[index];
                    final DateTime time = task.timeAdded;
                    final String day = DateFormat('dd-MM-yyyy').format(time);
                    final String time0 = DateFormat('HH:mm').format(time);

                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.fromLTRB(20, 2, 20, 2),
                      elevation: 3,
                      color:
                          task.isComplete ? Colors.grey[200] : Colors.green[50],
                      child: ExpansionTile(
                        leading: Checkbox(
                            activeColor: Colors.grey,
                            value: task.isComplete,
                            onChanged: (bool? newValue) {
                              setState(() {
                                task.isComplete = newValue ?? false;
                              });
                              _saveTasks();
                            }),
                        title: Text(
                          task.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              decoration: task.isComplete
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        trailing: IconButton(
                          tooltip: ("Delete"),
                          icon: Icon(CupertinoIcons.delete, color: Colors.red),
                          onPressed: () => _deleteTask(index),
                        ),
                        children: [
                          ListTile(
                              title: Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Text(
                              textAlign: TextAlign.start,
                              "Task info: \nTime: \t$time0 \nDay: \t$day",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 13),
                            ),
                          )),
                          ListTile(
                            title: Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Status: ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: task.isComplete
                                            ? Colors.green[300]
                                            : Colors.red[100],
                                      ),
                                      padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                      child: Text(
                                          task.isComplete
                                              ? 'Complete'
                                              : 'Incomplete',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                            color: task.isComplete
                                                ? const Color.fromARGB(
                                                    255, 241, 255, 242)
                                                : Colors.red[600],
                                          )),
                                    )
                                  ],
                                )),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
