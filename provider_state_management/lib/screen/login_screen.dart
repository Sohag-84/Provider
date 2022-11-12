// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_management/provider/auth_provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("build");
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Log in"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            Consumer<AuthProvider>(builder: (context, value, child) {
              return TextFormField(
                controller: _passwordController,
                obscureText: value.obscure,
                decoration: InputDecoration(
                    hintText: "Password",
                    suffix: IconButton(
                      onPressed: () {
                        if (value.obscure == true) {
                          value.setObscure(false);
                        } else {
                          value.setObscure(true);
                        }
                      },
                      icon: Icon(
                        value.obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility,
                      ),
                    )),
              );
            }),
            SizedBox(height: 23),
            GestureDetector(
              onTap: () {
                authProvider.login(
                    _emailController.text, _passwordController.text);
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepOrange,
                ),
                child: Center(
                  child: authProvider.loading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
