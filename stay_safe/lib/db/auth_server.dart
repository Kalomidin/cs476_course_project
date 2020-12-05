//! This file autheticates `login/signup` from server side
//!
//! author @kalo

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class AuthService {
   final dio = new Dio();

  login(name, password) async {
    try {
      Response response = await dio.post(
        'https://stay-safe-cs476-npm-server.herokuapp.com/authenticate',
        data: {
          "name": name,
          "password": password, 
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
      print("Response received is: $response");
      return response;
    } on DioError catch(e) {
      print("Error while `post`: ${e.response.data['msg']}");
      Fluttertoast.showToast(
        msg: e.response.data['msg'],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0

      );
    } 
  }

  addUser(name, password) async {
    try {
      Response response = await dio.post(
        'https://stay-safe-cs476.herokuapp.com/adduser',
        data: {
          "name": name,
          "password": password, 
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
      print("Response received is: $response");
      return response;
    } on DioError catch(e) {
      print("Error while `post`: ${e.response.data['msg']}");
      Fluttertoast.showToast(
        msg: e.response.data['msg'],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0

      );
    } 
  }
}
