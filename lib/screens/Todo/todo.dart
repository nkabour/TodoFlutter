
import 'package:flutter/material.dart';
import 'package:to_do_app/app.dart';
import '../../classes/Todo.dart';

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
  final List<Todo> todos;

  TodoList({this.todos});

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<TodoList> {
   
  List<Todo> todolist; 

  @override void initState() {
    
    super.initState();
    setState(() => todolist = widget.todos); 
  }

  @override
  Widget build(BuildContext context) {
    double _swipeStartX;
    String _swipeDirection;

    return todolist.isEmpty
        ? FittedBox(
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
                  Text("No Todos", style: Theme.of(context).textTheme.caption),

                  //add loader widget here.
                ],
              ),
            ),
          )
        : ListView.builder(
            itemCount: todolist.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onHorizontalDragStart: (e) =>
                      _swipeStartX = e.globalPosition.dx,
                  onHorizontalDragUpdate: (e) => _swipeDirection =
                      e.globalPosition.dx > _swipeStartX ? "Right" : "Left",
                  onHorizontalDragEnd: (e) async {
                    if (_swipeDirection == "Right")
                      setState(() => todolist.removeAt(index));
                    else {
                      _onEdit(context, index);
                    }
                  },
                  onTap: () {
                    setState(
                        () => todolist[index].isDone = !todolist[index].isDone);
                  },
                  child: TodoItem(todoitem: todolist[index]));
            });
  }

  _onEdit(BuildContext context, int index) {
    return Navigator.pushNamed<dynamic>(context, EditScreen,
        arguments: {"id": index});
  }
}

class TodoWidget extends StatelessWidget {
  
  final List<Todo> todolist = Todo.fetchAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ToDos')),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Align(
          child: TodoList(todos: todolist),
          alignment: Alignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed<dynamic>(context, AddScreen);
        },
        child: Icon(Icons.add),
        tooltip: "Add",
      ),
    );
  }
}
