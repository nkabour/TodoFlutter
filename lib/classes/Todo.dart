//i stands for impact and e stands for effort
//so lowi lowe is low effort low impact


enum Priorites {
  lowi_lowe, //fillins
  lowi_highe, //wasting time
  highi_lowe, //wins
  highi_highe, //major
  none, //none
}

class Todo {
  String label;
  int id; 
  Priorites priority;
  bool isDone;


  //shouldn't be static just to make it useful for this example
  static List<Todo> todolist = new List<Todo>();
  

  Todo({this.label = "", this.isDone = false, this.priority = Priorites.none});



  //the following methods helps in serilizing and deserilizing the objects
  static Todo fromMap(Map map){

    Map<int, Priorites> priorityMap = {
      0: Priorites.none,
      1: Priorites.lowi_lowe,
      2: Priorites.lowi_highe, 
      3: Priorites.highi_highe,
      4: Priorites.highi_lowe,  
    }; 

    Todo todo = new Todo(); 
    todo.label = map["label"]; 
    todo.id = map["_id"]; 
    todo.priority = priorityMap[map["priority"]]; 
    print(map["isDone"]);
    todo.isDone = map["isDone"] == 0 ? false : true;

    return todo; 

  }

  Map toMap() {

     Map<String, dynamic> map = Map<String, dynamic>(); 

     Map<Priorites, int> priorityMap = {
      Priorites.none : 0,
      Priorites.lowi_lowe : 1,
      Priorites.lowi_highe: 2, 
      Priorites.highi_highe: 3,
      Priorites.highi_lowe: 4,  
    }; 

    
     map["label"] = label; 
     map["_id"] = id; 
     map["priority"] = priorityMap[priority]; 
     map["isDone"] = isDone; 

    return map;
  }


}

