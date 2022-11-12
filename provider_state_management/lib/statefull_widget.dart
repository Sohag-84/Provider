// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';

class StateFullWidget extends StatefulWidget {
  const StateFullWidget({Key? key}) : super(key: key);

  @override
  State<StateFullWidget> createState() => _StateFullWidgetState();
}

class _StateFullWidgetState extends State<StateFullWidget> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    print("Build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Statefull widget"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          count++;
          print(count++);
          setState(
            () {},
          );
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              count.toString(),
              style: TextStyle(fontSize: 30),
            ),
          )
        ],
      ),
    );
  }
}
