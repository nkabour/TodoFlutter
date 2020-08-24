//i stands for impact and e stands for effort
//so lowi lowe is low effort low impact
enum Priorites {
  lowi_lowe, //fillins
  lowi_highe, //wasting time
  highi_lowe, //wins
  highi_highe, //major
  none,
}

class Todo {
  String label;
  Priorites priority;
  bool isDone;

  //shouldn't be static just to make it useful for this example
  static List<Todo> todolist = new List<Todo>();

  Todo({this.label = "", this.isDone = false, this.priority = Priorites.none});


  //should fetch from db and init from db...
  static Todo fetchByIndex(int index) {
    return index == -1 ? null : Todo.todolist[index];
  }

  static List<Todo> fetchAll() {
    return Todo.todolist;
  }
}

