//! This file includes login/signup futures of the application
//! 
//! authors @kalo

import 'package:example/db/review_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './homepage.dart';


class LoginPage extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  var token;

  final emailFieldController = TextEditingController();
  var passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
          controller:  emailFieldController,
    );

    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
          controller:  passwordFieldController,
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          print("Pressed Login: ${passwordField.controller.text}, ${emailField.controller.text}");
          // TODO: Make Some DB Calculations
          ReviewService().login(emailField.controller.text, passwordField.controller.text).then((val) {
            try {
              if (val.data['success']) {
                token = val.data['token'];
                Fluttertoast.showToast(msg: 'Autheticated');
                 Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(username: emailField.controller.text)));
              } else {
                Fluttertoast.showToast(msg: 'Authetication failed. Username or Password is wrong');
              }
            } catch (e) {
              Fluttertoast.showToast(msg: 'Authetication failed.\n Please retry');
              print("Failure happened: received val: $val\ Error: $e");
            }
          });
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final signupButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          print("Pressed Signup: ${passwordField.controller.text}, ${emailField.controller.text}");
          // TODO: Make Some DB Calculations
          ReviewService().signup(emailField.controller.text, passwordField.controller.text).then((val) {
            try {
              if (val.data['success']) {
                print("Success happened");
                token = val.data['token'];
                Fluttertoast.showToast(msg: 'Successfully Signed Up');
                passwordFieldController = TextEditingController();
                Navigator.pushReplacementNamed(
            context, '/signin');
              } else {
                Fluttertoast.showToast(msg: 'Failed to signup\n Username already exists or password does not contain string');
                print("Failure happened: ${val.data['success']}");
              }
            } catch (e) {
              Fluttertoast.showToast(msg: 'Failed to signup\n Please retry');
              print("Failure happened: received val: $val\ Error: $e");
            }
          });
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 15.0,
                ),
                signupButon,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
        )
    );
  }
}