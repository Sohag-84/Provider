// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_management/provider/multi_provider.dart';

class MultiProviderScreen extends StatefulWidget {
  const MultiProviderScreen({Key? key}) : super(key: key);

  @override
  State<MultiProviderScreen> createState() => _MultiProviderScreenState();
}

class _MultiProviderScreenState extends State<MultiProviderScreen> {
  @override
  Widget build(BuildContext context) {
    print("build");
    // final provider = Provider.of<MultiPoviderClass>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi provider"),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<MultiPoviderClass>(
            builder: (context, value, child) {
              print("only column widget is build");
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Slider(
                    value: value.value,
                    min: 0,
                    max: 1,
                    onChanged: (val) {
                      print(value.value);
                      value.setValue(val);
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.green.withOpacity(value.value),
                          height: 50,
                          child: Center(child: Text("Container-1")),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          color: Colors.red.withOpacity(value.value),
                          height: 50,
                          child: Center(child: Text("Container-2")),
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
          )),
    );
  }
}
