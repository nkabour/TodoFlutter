
import 'package:flutter/material.dart';
import 'package:to_do_app/app.dart';
import '../../classes/Todo.dart';
import 'package:to_do_app/database_helper.dart';

class TodoItem extends StatelessWidget {

  TodoItem({this.todoitem});
  final Todo todoitem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12))),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          _getIcon(todoitem.priority),
          SizedBox(width: 10),
          Expanded(child: Text(todoitem.label)),
          Icon(Icons.check_circle,
              color: todoitem.isDone ? Colors.green : Colors.black26)
        ],
      ),
    );
  }

  _getIcon(Priorites priorty) {
    switch (priorty) {
      case Priorites.lowi_lowe:
        return Icon(Icons.local_florist, size: 30, color: Colors.purple[900]);

      case Priorites.lowi_highe:
        return Icon(Icons.hourglass_empty, size: 30, color: Colors.red[700]);
      case Priorites.highi_lowe:
        return Icon(Icons.flight, size: 30, color: Colors.blue[700]);
      case Priorites.highi_highe:
        return Icon(Icons.lightbulb_outline,
            size: 30, color: Colors.yellow[700]);
      case Priorites.none:
        return Icon(Icons.remove_circle, size: 30, color: Colors.black38);
    }
  }
}

class TodoList extends StatefulWidget {

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<TodoList> {
   
  List<Todo> todolist; 

  Future todolistFuture; 

  @override void initState() {
    
    super.initState();
    todolistFuture = getTodos(); 
    
  }

  getTodos() async {

    return await DBHelper.instance.queryAllRows(DBHelper.tableTodos);
  }

  double _swipeStartX;
  String _swipeDirection;
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(title: Text('ToDos')),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Align(
          child:FutureBuilder(
                    future: todolistFuture,
                    builder: _futureBuilder,
                    ),
          alignment: Alignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed<dynamic>(context, AddScreen, arguments: {"id": todolist.length});
        },
        child: Icon(Icons.add),
        tooltip: "Add",
      ),
    );
 
  }


  _onEdit(BuildContext context, Todo todo) {
    return Navigator.pushNamed<dynamic>(context, EditScreen,
        arguments: {"todo": todo});
  }

  _emptyTodoList(){
    return FittedBox(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/meditate.png",
                    fit: BoxFit.contain,
                  ),
                  Text("No Todos", style: Theme.of(context).textTheme.caption.copyWith(
                    color: Colors.black,
                  )),

                  //add loader widget here.
                ],
              ),
            ),
          );
  }


  _todoListBuilder(BuildContext context) {

    return  ListView.builder(
            itemCount: todolist.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onHorizontalDragStart: (e) =>
                      _swipeStartX = e.globalPosition.dx,
                  onHorizontalDragUpdate: (e) => _swipeDirection =
                      e.globalPosition.dx > _swipeStartX ? "Right" : "Left",
                  onHorizontalDragEnd: (e) async {
                    if (_swipeDirection == "Right")
                      setState(() {
                        DBHelper.instance.delete(DBHelper.tableTodos, todolist[index].id);
                        todolist.removeAt(index);
                      });
                    
                    else {
                      _onEdit(context, todolist[index]);
                    }
                  },
                  onTap: () {
                    setState(() {
                           
                           todolist[index].isDone = !todolist[index].isDone;
                           DBHelper.instance.update(DBHelper.tableTodos, todolist[index].toMap());
                    
                        });
                  
                   
                  },
                  child: TodoItem(todoitem: todolist[index]));
            });
  }

  Widget _futureBuilder (context, snap) {
   

        if(snap.hasError){

          print(snap.error);
          return Text("Shoot couldn't connect to db");  
        }
        else if(!snap.hasData){
            
            return CircularProgressIndicator();

        }
        else if(snap.hasData){
          todolist = snap.data;
          return todolist.isEmpty ? _emptyTodoList() : _todoListBuilder(context);

        }

        return Text("Shoot something's wrong!"); 
  
      
  }

}

