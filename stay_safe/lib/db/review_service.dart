//import 'dart:convert';
import 'package:dio/dio.dart';

class ReviewService {

  static final ReviewService _instance = ReviewService._internal();

  factory ReviewService() {
    return _instance;
  }

  ReviewService._internal();

  final dio = new Dio();
  final base = 'http://localhost:8081';

  makeReview(String username, String place, double safety, double overall, List<String> content) async {
    Response response = await dio.post(
        base + '/makereview',
        data: {
          "username": username,
          "place": place,
          "safety": safety,
          "overall": overall,
          "content": content,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
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

  getReviews(String place) async {
    Response response = await dio.post(
        base + '/getreviews',
        data: {
          "place": place,
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
    return response;
  }
}