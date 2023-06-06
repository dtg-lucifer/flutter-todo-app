class Todo {
  String? id;
  String todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> todoList() {
    return [
      Todo(id: "01", todoText: "Check Email"),
      Todo(id: "02", todoText: "Check PR"),
      Todo(id: "03", todoText: "Eat come fruits", isDone: true),
      Todo(id: "04", todoText: "Stand up meeting"),
      Todo(id: "05", todoText: "Take a nap"),
      Todo(id: "06", todoText: "Work on mobile apps", isDone: true),
      Todo(id: "07", todoText: "Go on a date", isDone: true),
    ];
  }
}
