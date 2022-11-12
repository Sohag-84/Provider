// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/res/components/round_button.dart';
import 'package:flutter_mvvm/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: "Enter eamil",
                prefixIcon: Icon(Icons.mail_lock_outlined),
              ),
            ),
            SizedBox(height: 15),
            ValueListenableBuilder(
              valueListenable: _obscurePassword,
              builder: (context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword.value,
                  textInputAction: TextInputAction.done,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    prefixIcon: Icon(Icons.lock_clock_outlined),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _obscurePassword.value = !_obscurePassword.value;
                      },
                      icon: Icon(
                        _obscurePassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            RoundButton(
              onPressed: () {
                if (_emailController.text.isEmpty) {
                  Utils.flushbarErrorMessage(context, "Please enter email");
                } else if (_passwordController.text.isEmpty) {
                  Utils.flushbarErrorMessage(context, "Please enter password");
                } else if (_passwordController.text.length < 6) {
                  Utils.flushbarErrorMessage(
                      context, "Password must be 6 character");
                } else {
                  Utils.snackbar(context, "Successfully login");
                }
              },
              title: "Login",
            ),
          ],
        ),
      ),
    );
  }
}
