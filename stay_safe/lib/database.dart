//import 'dart:convert';
import "package:mongo_dart/mongo_dart.dart";

void main() async {
  final db = await openDB();
  //final reviews = db.collection("reviews");
  await makeReview(db, "Woohyun", "KAIMARU", 5, 4.5, "Safe, since people are not allowed to sit face to face.");
  await makeReview(db, "Anonymous", "KAIMARU", 2.5, 3.5, "People can't help taking off their masks while eating.");

  double safety = await averageSafety(db, "KAIMARU");
  double overall = await averageOverall(db, "KAIMARU");
  print("safety: $safety, overall: $overall");

  await addComment(db, "Woohyun", "KAIMARU", "Alice", "I agree!");
  await addComment(db, "Woohyun", "KAIMARU", "Bob", "Well..");
  await addComment(db, "Anonymous", "KAIMARU", "Juho", "Then we can't go anywhere.");

  await upvote(db, "Woohyun", "KAIMARU");
  await downvote(db, "Woohyun", "KAIMARU");
  await downvote(db, "Anonymous", "KAIMARU");

  print(await getComments(db, "Woohyun", "KAIMARU"));
  print(await getComments(db, "Anonymous", "KAIMARU"));

  await for (var review in getReviews(db, "KAIMARU")) {
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

Future makeReview(Db db, String username, String place, double safety, double overall, String content) async {
  final uc = db.collection(username);
  final pc = db.collection(place);
  final data = {
    "username": username,
    "place": place,
    "safety": safety,
    "overall": overall,
    "content": content,
    "likes": 0,
    "dislikes": 0,
    "comments": <Map<String, dynamic>>[]
  };

  await uc.insert(data);
  await pc.insert(data);
}

Future<double> averageSafety(Db db, String place) async {
  final pc = db.collection(place);
  final sum = await pc.find({"place": place}).fold(0.0, (sum, review) => sum + review["safety"]);
  final length = await pc.find({"place": place}).length;
  return sum / length;
}

Future<double> averageOverall(Db db, String place) async {
  final pc = db.collection(place);
  final sum = await pc.find({"place": place}).fold(0.0, (sum, review) => sum + review["overall"]);
  final length = await pc.find({"place": place}).length;
  return sum / length;
}

Stream<Map<String, dynamic>> getReviews(Db db, String place) {
  final pc = db.collection(place);
  return pc.find({"place": place});
}

Future<List<Map<String, dynamic>>> getComments(Db db, String username, String place) async {
  final uc = db.collection(username);
  return ((await uc.findOne({"username": username, "place": place}))["comments"] as List).cast<Map<String, dynamic>>();
}

Future addComment(Db db, String username, String place, String commenter, String content) async {
  final uc = db.collection(username);
  final pc = db.collection(place);
  await uc.update({"username": username, "place": place}, modify.addToSet("comments", {
    "username": commenter,
    "content": content
  }));
  await pc.update({"username": username, "place": place}, modify.addToSet("comments", {
    "username": commenter,
    "content": content
  }));
}

Future upvote(Db db, String username, String place) async {
  final uc = db.collection(username);
  var review = await uc.findOne({"username": username, "place": place});
  review["likes"]++;
  await uc.save(review);

  final pc = db.collection(place);
  review = await pc.findOne({"username": username, "place": place});
  review["likes"]++;
  await pc.save(review);
}

Future downvote(Db db, String username, String place) async {
  final uc = db.collection(username);
  var review = await uc.findOne({"username": username, "place": place});
  review["dislikes"]++;
  await uc.save(review);

  final pc = db.collection(place);
  review = await pc.findOne({"username": username, "place": place});
  review["dislikes"]++;
  await pc.save(review);
}

Future closeDB(Db db) async {
  //await db.collection("reviews").remove({"place": "KAIMARU"}); // for testing
  
  // mongo "mongodb+srv://cluster0.r7txg.mongodb.net/cs473" --username admin
  // vcxz4321
  // use cs473
  // db.dropDatabase()
  // exit

  await db.close();
}
