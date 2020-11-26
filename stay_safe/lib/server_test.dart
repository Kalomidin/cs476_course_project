//import 'db/auth_server.dart';
import 'package:dio/dio.dart';
void main() async {
  final dio = new Dio();
  final base = 'http://localhost:8081';
    Response response = await dio.post(
      base + '/makereview',
      data: {
        'username': 'woohyun',
        'place': 'KAIMARU',
        'safety': 10.0, 
        'overall': 9.0, 
        'content': 'good!',
      },
      options: Options(contentType: Headers.formUrlEncodedContentType));
    print("Response received is: $response");

      response = await dio.post(
      base + '/addcomment',
      data: {
        'username': 'woohyun',
        'place': 'KAIMARU',
        'commenter': 'juho',
        'content': 'agree!'
      },
      options: Options(contentType: Headers.formUrlEncodedContentType));
    print("Response received is: $response");


    response = await dio.post(
      base + '/getreviews',
      data: {
        'place': 'KAIMARU'
      },
      options: Options(contentType: Headers.formUrlEncodedContentType));
    print("Response received is: $response");

}