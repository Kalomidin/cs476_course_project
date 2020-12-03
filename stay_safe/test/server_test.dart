import '../lib/db/review_service.dart';
void main() async {

  final service = ReviewService();
  var response;
  response = await service.makeReview('woohyun', 'kaimaru', 10.0, 9.0, ['about 100', 'most of them', 'yes', 'same as the example']);
  print("response is: $response");
  response = await service.addComment('woohyun', 'kaimaru', 'juho', 'agree!');
  print("response is: $response");
  response = await service.upvote('woohyun', 'kaimaru');
  print("response is: $response");
  response = await service.getReviews('kaimaru');
  print("response is: $response");
  print(response.data is Map<String, dynamic>);

  /*
  final dio = new Dio();
  final base = 'http://localhost:8081';
    Response response = await dio.post(
      base + '/makereview',
      data: {
        'username': 'woohyun',
        'place': 'KAIMARU',
        'safety': 10.0, 
        'overall': 9.0, 
        'content': ['a', 'b', 'c', 'd']
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
  */
}