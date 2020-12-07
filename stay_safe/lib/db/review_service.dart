//import 'dart:convert';
import 'package:dio/dio.dart';

class ReviewService {

  static final ReviewService _instance = ReviewService._internal();

  factory ReviewService() {
    return _instance;
  }

  ReviewService._internal();

  final dio = new Dio();
  final base = 'https://cs476-stay-safe-dart-server.herokuapp.com'; //'http://10.0.2.2:8081'; //

  makeReview(String username, String place, double safety, double overall, String content, String date) async {
    print("Message will be send");
    var sending_data = {
          "username": username,
          "place": place,
          "safety": safety,
          "overall": overall,
          "content": content,
          "date": date,
    };
    Response response = await dio.post(
        base + '/makereview',
        data: sending_data,
        options: Options(contentType: Headers.formUrlEncodedContentType));
    print("Received response is: $response");
    return response;
  }

  averageSafety(String place) async {
    Response response = await dio.post(
        base + '/averagesafety',
        data: {
          "place": place,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
    return response;
  }

  averageOverall(String place) async {
    Response response = await dio.post(
        base + '/averageoverall',
        data: {
          "place": place,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
    return response;
  }

  getReviewsByPlace(String place) async {
    Response response = await dio.post(
        base + '/getreviewsbyplace',
        data: {
          "place": place,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
    return response;
  }

  getReviewsByUsername(String username) async {
    Response response = await dio.post(
        base + '/getreviewsbyusername',
        data: {
          "username": username,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
    return response;
  }

  getComments(String username, String place) async {
    Response response = await dio.post(
        base + '/getcomments',
        data: {
          "username": username,
          "place": place,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
    return response;
  }

  addComment(String username, String place, String commenter, String content) async {
    Response response = await dio.post(
        base + '/addcomment',
        data: {
          "username": username,
          "place": place,
          "commenter": commenter,
          "content": content,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
    return response;
  }

  upvote(String username, String place) async {
    Response response = await dio.post(
        base + '/upvote',
        data: {
          "username": username,
          "place": place,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
    return response;
  }

  downvote(String username, String place) async {
    Response response = await dio.post(
        base + '/downvote',
        data: {
          "username": username,
          "place": place,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
    print("Received response is: $response");
    return response;
  }

  login(String username, String password) async {
    Response response = await dio.post(
        base + '/login',
        data: {
          "username": username,
          "password": password,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
    print("Received response is: $response");
    return response;
  }

    signup(String username, String password) async {
    Response response = await dio.post(
        base + '/signup',
        data: {
          "username": username,
          "password": password,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
    print("Received response is: $response");
    return response;
  }
}
