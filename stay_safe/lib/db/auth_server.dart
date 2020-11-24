import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class AuthService {
   final dio = Dio(BaseOptions(baseUrl: 'http://143.248.243.134:3000/'));

  login(name, password) async {
    try {
      return await dio.post(
        '',
        data: {
          "name": name,
          "password": password, 
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch(e) {
      print("Error while `post`: $e");
      return Fluttertoast.showToast(
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
