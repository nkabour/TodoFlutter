import 'package:flutter/material.dart';
import "../../classes/Todo.dart";
import "package:to_do_app/app.dart";

class AddTodo extends StatefulWidget {


  final int index; 
  AddTodo({this.index = -1});

  @override
  _Add createState() => _Add();
  
}

class _Add extends State<AddTodo> {
//this will be used to collect the form data
Todo todoval = new Todo(); 

  bool editView = false; 
//key that holds the form's state key
//why are we using global key instead of Unique key?
  final GlobalKey<FormState> _key = GlobalKey();

  @override void initState() {
    
    super.initState();
    int index = widget.index; 
    Todo todo = Todo.fetchByIndex(index); 

    if(todo != null) {
    
      setState(() {
        todoval = todo; 
        editView = true; 

      });

    }
    

  }

  @override
  Widget build(BuildContext context) {
    //all components that we are gonna use inside the FormWidget
   
  
    TextFormField label = TextFormField(
      initialValue: todoval.label,
      decoration: InputDecoration(hintText: "What to do?", labelText: "What to do?" ),
      onChanged: (String stringVal) =>
          setState(() => todoval.label = stringVal),
      validator: (String stringVal) {
        if (stringVal.isEmpty) {
          return "Ooops you forgot what to do!...";
        } 
        //another condition to check if the email is not in the db...
        //Oops you your email doesn't exist Forgot passowrd or Sign Up.
        return null;
      },
      onSaved: (String stringVal) {
        //do-somthing before submitting.
      },
    );
    FormField dropdown = FormField<Priorites>(
      builder: (FormFieldState<Priorites> state){
        return DropdownButton<Priorites>(
          value: todoval.priority,
          items:  _buildDropDownItem(todoval),
          onChanged: (Priorites p) => setState(() => todoval.priority = p ),
          isExpanded: true,

        );

      },
      onSaved: (Priorites p) {},
     );
    RaisedButton addButton = RaisedButton(
      child: editView? Text("Save") : Text("Add"),
      onPressed: () {
        if(_key.currentState.validate()){
          _key.currentState.save(); 
          int index = widget.index; 
          if(editView) {
            Todo.todolist.removeAt(index); 
            
            Todo.todolist.insert(index, todoval); 
          }
          else Todo.todolist.add(todoval); 
          Navigator.pushNamed<dynamic>(context, TodoScreen);

        }
      },
    );
  
    SizedBox divider = SizedBox(height: 20);

    return Scaffold(
      appBar: AppBar(
        title: Text('What todo?'),
      ),
      backgroundColor: Colors.white,
      body: Form(
        autovalidate: true,
        key: _key,
        child: Container(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: [
              label,
              divider,
              dropdown,
              divider,
              addButton,
            
            ],
          ),
        ),
      ),
    );
  }


_buildDropDownItem (Todo todo) {
    
    List<DropdownMenuItem<Priorites>> items = List<DropdownMenuItem<Priorites>>(); 
    Priorites.values.forEach((element) {
      
    Icon icon ; 
    Text text; 
     
    switch(element){
        case Priorites.lowi_lowe:
          icon = Icon(Icons.local_florist, size: 30, color: Colors.purple[900]);
          text = Text("Low Impact, Low effort");
          break; 
        case Priorites.lowi_highe:
          icon = Icon(Icons.hourglass_empty, size: 30, color: Colors.red[700]);
          text = Text("Low Impact, High effort");
          break; 
        case Priorites.highi_lowe:
          icon = Icon(Icons.flight, size: 30, color: Colors.blue[700]);
          text = Text("High Impact, Low effort");
          break; 
        case Priorites.highi_highe:
         icon =  Icon(Icons.lightbulb_outline, size: 30, color: Colors.yellow[700]);
         text = Text("High Impact, High effort");
         break; 
        case Priorites.none: 
          icon = Icon(Icons.remove_circle, size: 30, color: Colors.black38);
          text = Text("None");
          break; 

  }
     items.add(DropdownMenuItem<Priorites>(
       
       child: Row(children: [icon, SizedBox(width: 3), text],), 
       value: element, 
     ));

    });
    
    return items;
     
  }
}

