// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';

class NotifyListenerScreen extends StatelessWidget {
  NotifyListenerScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final ValueNotifier<bool> toggle = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Notify listener"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counter.value++;
          print(_counter.value.toString());
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: toggle,
              builder: (context, value, child) {
                return TextFormField(
                  obscureText: toggle.value,
                  decoration: InputDecoration(
                    hintText: "password",
                    suffix: IconButton(
                      onPressed: () {
                        toggle.value = !toggle.value;
                      },
                      icon: Icon(
                        toggle.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility,
                      ),
                    ),
                  ),
                );
              },
            ),
            Center(
              child: ValueListenableBuilder(
                valueListenable: _counter,
                builder: (BuildContext context, value, Widget? child) {
                  return Text(
                    _counter.value.toString(),
                    style: TextStyle(fontSize: 30),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
