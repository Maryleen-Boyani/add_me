class Todo {
  String id;
  String todoText;
  bool isDone;

  Todo({required this.id, required this.todoText, required this.isDone});

  static List<Todo> todoList() {
    return [
      Todo(id: '1', todoText: 'Living Hope', isDone: true),
      Todo(id: '2', todoText: 'A thousand storms', isDone: false),
      Todo(id: '3', todoText: 'Unto God', isDone: true),
      Todo(id: '4', todoText: 'Promise of Grace', isDone: false),
      Todo(id: '5', todoText: 'In This Hour', isDone: false),
      Todo(id: '6', todoText: 'Bwana ni mchungaji', isDone: false),
      Todo(id: '7', todoText: 'I Need Thee Precious Jesus', isDone: false),
      Todo(id: '8', todoText: 'Dereva', isDone: false),
    ];
  }
}
