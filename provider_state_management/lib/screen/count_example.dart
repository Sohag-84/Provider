// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_management/provider/count_provider.dart';

class CountExampleScreen extends StatefulWidget {
  const CountExampleScreen({Key? key}) : super(key: key);

  @override
  State<CountExampleScreen> createState() => _CountExampleScreenState();
}

class _CountExampleScreenState extends State<CountExampleScreen> {
  @override
  void initState() {
    super.initState();
    final countProvider = Provider.of<CountProvider>(context, listen: false);
    Timer.periodic(
      Duration(seconds: 0),
      (timer) {
        countProvider.setCount();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final countProvider = Provider.of<CountProvider>(context, listen: false);
    print("Build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter App"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => countProvider.setCount(),
        child: Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Consumer<CountProvider>(
              builder: (context, value, child) {
                print("build only this widget");
                return Text(
                  value.count.toString(),
                  style: TextStyle(fontSize: 35),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
