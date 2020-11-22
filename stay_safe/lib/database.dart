import 'dart:convert';
import "package:mongo_dart/mongo_dart.dart";

void main() async {
  /*
  final db = await Db.create("mongodb+srv://admin:vcxz4321@cluster0.r7txg.mongodb.net/cs473?retryWrites=true&w=majority");
  await db.open();

  final reviews = db.collection("reviews");
  await reviews.insert({
    "place": "KAIMARU",
    "picture": "TODO",
    "safety": 10,
    "overall": 10,
    "username": "Woohyun",
    "content": "",
    "likes": 0,
    "dislikes": 0,
    "comments": []
  });
  print(await reviews.find().toList());

  await db.close();
  */
  final db = await openDB();
  final reviews = db.collection("reviews");
  await makeReview(reviews, "Woohyun", "KAIMARU", [], 10, 9, "Safe, since people are not allowed to sit face to face.");
  await makeReview(reviews, "Anonymous", "KAIMARU", [], 5, 7, "People can't help taking off their masks while eating.");

  double safety = await averageSafety(reviews, "KAIMARU");
  double overall = await averageOverall(reviews, "KAIMARU");
  print("safety: $safety, overall: $overall");

  await addComment(reviews, "Woohyun", "KAIMARU", "Alice", "I agree!");
  await addComment(reviews, "Woohyun", "KAIMARU", "Bob", "Well..");
  await addComment(reviews, "Anonymous", "KAIMARU", "Juho", "Then we can't go anywhere.");

  await upvote(reviews, "Woohyun", "KAIMARU");
  await downvote(reviews, "Woohyun", "KAIMARU");
  await downvote(reviews, "Anonymous", "KAIMARU");

  print(await getComments(reviews, "Woohyun", "KAIMARU"));
  print(await getComments(reviews, "Anonymous", "KAIMARU"));

  await for (var review in getReviews(reviews, "KAIMARU")) {
    print(review);
  }

  await closeDB(db);
}

// Usage: await openDB()
Future<Db> openDB() async {
  final db = await Db.create("mongodb+srv://admin:vcxz4321@cluster0.r7txg.mongodb.net/cs473?retryWrites=true&w=majority");
  await db.open();

  return db;
}

Future makeReview(DbCollection reviews, String username, String place, List<int> imageByte, int safety, int overall, String content) async {
  //final reviews = db.collection("reviews");
  final picture = base64Encode(imageByte);
  await reviews.insert({
    "username": username,
    "place": place,
    "picture": picture,
    "safety": safety,
    "overall": overall,
    "content": content,
    "likes": 0,
    "dislikes": 0,
    "comments": <Map<String, dynamic>>[]
  });
}

Future<double> averageSafety(DbCollection reviews, String place) async {
  //final reviews = db.collection("reviews");
  final sum = await reviews.find({"place": place}).fold(0.0, (sum, review) => sum + review["safety"]);
  final length = await reviews.find({"place": place}).length;
  return sum / length / 2;
}

Future<double> averageOverall(DbCollection reviews, String place) async {
  //final reviews = db.collection("reviews");
  final sum = await reviews.find({"place": place}).fold(0.0, (sum, review) => sum + review["overall"]);
  final length = await reviews.find({"place": place}).length;
  return sum / length / 2;
}

Stream<Map<String, dynamic>> getReviews(DbCollection reviews, String place) {
  //final reviews = db.collection("reviews");
  return reviews.find({"place": place});
}

Future<List<Map<String, dynamic>>> getComments(DbCollection reviews, String username, String place) async {
  //final reviews = db.collection("reviews");
  return ((await reviews.findOne({"username": username, "place": place}))["comments"] as List).cast<Map<String, dynamic>>();
  // return reviews.find({"username": username, "place": place})
  //.fold([], (list, review) => list + review["comments"]);
}

Future addComment(DbCollection reviews, String username, String place, String commenter, String content) async {
  //final reviews = db.collection("reviews");
  await reviews.update({"username": username, "place": place}, modify.addToSet("comments", {
    "username": commenter,
    "content": content
  }));
}

Future upvote(DbCollection reviews, String username, String place) async {
  var review = await reviews.findOne({"username": username, "place": place});
  review["likes"]++;
  await reviews.save(review);
}

Future downvote(DbCollection reviews, String username, String place) async {
  var review = await reviews.findOne({"username": username, "place": place});
  review["dislikes"]++;
  await reviews.save(review);
}

Future closeDB(Db db) async {
  await db.collection("reviews").remove({"place": "KAIMARU"}); // for testing
  await db.close();
}
