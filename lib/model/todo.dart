class ToDo {
  String? id;
  String? todoText;
  bool isDone = false;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '1',
        todoText: 'Buy groceries',
        isDone: true,
      ),
      ToDo(
        id: '2',
        todoText: 'Go to gym',
        isDone: true,
      ),
      ToDo(
        id: '3',
        todoText: 'Call mom',
        isDone: false,
      ),
      ToDo(
        id: '4',
        todoText: 'Finish Assignment',
        isDone: false,
      ),
      ToDo(
        id: '5',
        todoText: 'start a new project',
        isDone: false,
      ),
      ToDo(
        id: '6',
        todoText: 'go to the beach',
        isDone: false,
      ),
    ];
  }
}
