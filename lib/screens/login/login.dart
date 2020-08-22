import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<LoginWidget> {
//this will be used to collect the form data
  final loginCredential = <String, dynamic>{
    "email": "",
    "password": "",
  };

//key that holds the form's state key
//why are we using global key instead of Unique key?
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //all components that we are gonna use inside the FormWidget
    TextFormField email = TextFormField(
      initialValue: loginCredential["email"],
      decoration: InputDecoration(hintText: "Email", labelText: "Email"),
      onChanged: (String stringVal) =>
          setState(() => loginCredential["email"] = stringVal),
      validator: (String stringVal) {
        if (stringVal.isEmpty) {
          return "Ooops you forgot your email!...";
        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(stringVal)) {
          return "something's missing in your email!";
        }

        //another condition to check if the email is not in the db...
        //Oops you your email doesn't exist Forgot passowrd or Sign Up.
        return null;
      },
      onSaved: (String stringVal) {
        //do-somthing before submitting.
      },
    );
    TextFormField password = TextFormField(
      initialValue: loginCredential["password"],
      decoration: InputDecoration(
          hintText: "Password", labelText: "Password"),
      onChanged: (stringVal) =>
          setState(() => loginCredential["password"] = stringVal),
      obscureText: true,
   
      validator: (String stringVal) {
        if (stringVal.isEmpty) {
          return "Ooops enter your password!";
        }

        //another condition to check if the email is not in the db...
        //Oops you your email doesn't exist Forgot passowrd or Sign Up.
        return null;
      },
      onSaved: (String stringVal) {
        //do-somthing before submitting.
      },
    );
    RaisedButton loginbutton = RaisedButton(
      child: Text("Login"),
      onPressed: () {
        if(_key.currentState.validate()){
          _key.currentState.save(); 
          print("Login...");
          //change route here... 
        }
      },
    );
    FlatButton forgotPassword = FlatButton(
      child: Text("Forgot your password?"),
      onPressed: () => print("forgot password"),
    );

    SizedBox divider = SizedBox(height: 20);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        autovalidate: true,
        key: _key,
        child: Container(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: [
              email,
              divider,
              password,
              divider,
              loginbutton,
              divider,
              forgotPassword,
            ],
          ),
        ),
      ),
    );
  }
}
