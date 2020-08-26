//validate user auth and redirect to either
//login or todo page

import "dart:async";
import "package:flutter/material.dart";
import "../../app.dart";



//can be connected to db connection
//to check if data exists or not for offline mode
//also can use to check authinitcation, and connection .

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenWidget createState() => _SplashScreenWidget();
}

class _SplashScreenWidget extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.pushNamed<dynamic>(context, TodoScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Align(
                child: FittedBox(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 100),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/sleek.png",
                          fit: BoxFit.contain,
                        ),
                        Text("Jumpin!",
                            style: Theme.of(context).textTheme.headline5),
                        Text("Personal Journal",
                            style: Theme.of(context).textTheme.headline5),
                        //add loader widget here.
                      ],
                    ),
                  ),
                ),
                alignment: Alignment.center)));
  }
}
