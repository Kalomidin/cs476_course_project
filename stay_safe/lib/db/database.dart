//import 'dart:convert';
import "package:mongo_dart/mongo_dart.dart";
import "package:sevr/sevr.dart";

void setCors(ServRequest req, ServResponse res) {
  res.response.headers.add('Access-Control-Allow-Origin', '*');
  res.response.headers.add('Access-Control-Allow-Methods', 'GET, POST, DELETE');
  res.response.headers
      .add('Access-Control-Allow-Headers', 'Origin, Content-Type');
}

final _db = openDB();

void main() async {
  //final reviews = db.collection("reviews");

  const port = 8081;
  final serv = Sevr();

  final corsPaths = ['/'];
  for (var route in corsPaths) {
    serv.options(route, [
      (req, res) {
        setCors(req, res);
        return res.status(200);
      }
    ]);
  }

  serv.post('/makereview', [
    setCors,
    (ServRequest req, ServResponse res) async {
      await makeReview(
        req.body['username'], 
        req.body['place'], 
        req.body['safety'], 
        req.body['overall'], 
        req.body['content']
      );
      return res.status(200);
    }
  ]);

  serv.post('/averagesafety', [
    setCors,
    (ServRequest req, ServResponse res) async {
      final safety = await averageSafety(
        req.body['place'], 
      );
      return res.status(200).json({'safety': safety});
    }
  ]);

  serv.post('/averageoverall', [
    setCors,
    (ServRequest req, ServResponse res) async {
      final overall = await averageOverall(
        req.body['place'], 
      );
      return res.status(200).json({'overall': overall});
    }
  ]);

  serv.post('/getreviews', [
    setCors,
    (ServRequest req, ServResponse res) async {
      final reviews = await (await getReviews(
        req.body['place'], 
      )).toList();
      return res.status(200).json({'reviews': reviews});
    }
  ]);

  serv.post('/getcomments', [
    setCors,
    (ServRequest req, ServResponse res) async {
      final comments = await getComments(
        req.body['username'],
        req.body['place'], 
      );
      return res.status(200).json({'comments': comments});
    }
  ]);

  serv.post('/addcomment', [
    setCors,
    (ServRequest req, ServResponse res) async {
      await addComment(
        req.body['username'],
        req.body['place'],
        req.body['commenter'],
        req.body['content']
      );
      return res.status(200);
    }
  ]);

  serv.post('/upvote', [
    setCors,
    (ServRequest req, ServResponse res) async {
      await upvote(
        req.body['username'],
        req.body['place'],
      );
      return res.status(200);
    }
  ]);

  serv.post('/downvote', [
    setCors,
    (ServRequest req, ServResponse res) async {
      await downvote(
        req.body['username'],
        req.body['place'],
      );
      return res.status(200);
    }
  ]);

  // Listen for connections
  serv.listen(port, callback: () {
    print('Server listening on port: $port');
  });


  /*
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
  */
  
}

// Usage: await openDB()
Future<Db> openDB() async {
  final db = await Db.create("mongodb+srv://admin:vcxz4321@cluster0.r7txg.mongodb.net/cs473?retryWrites=true&w=majority");
  await db.open();
  
  return db;
}

Future makeReview(String username, String place, double safety, double overall, String content) async {
  final db = await _db;
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

Future<double> averageSafety(String place) async {
  final db = await _db;
  final pc = db.collection(place);
  final sum = await pc.find({"place": place}).fold(0.0, (sum, review) => sum + review["safety"]);
  final length = await pc.find({"place": place}).length;
  return sum / length;
}

Future<double> averageOverall(String place) async {
  final db = await _db;
  final pc = db.collection(place);
  final sum = await pc.find({"place": place}).fold(0.0, (sum, review) => sum + review["overall"]);
  final length = await pc.find({"place": place}).length;
  return sum / length;
}

Future<Stream<Map<String, dynamic>>> getReviews(String place) async {
  final db = await _db;
  final pc = db.collection(place);
  return pc.find({"place": place});
}

Future<List<Map<String, dynamic>>> getComments(String username, String place) async {
  final db = await _db;
  final uc = db.collection(username);
  return ((await uc.findOne({"username": username, "place": place}))["comments"] as List).cast<Map<String, dynamic>>();
}

Future addComment(String username, String place, String commenter, String content) async {
  final db = await _db;
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

Future upvote(String username, String place) async {
  final db = await _db;
  final uc = db.collection(username);
  var review = await uc.findOne({"username": username, "place": place});
  review["likes"]++;
  await uc.save(review);

  final pc = db.collection(place);
  review = await pc.findOne({"username": username, "place": place});
  review["likes"]++;
  await pc.save(review);
}

Future downvote(String username, String place) async {
  final db = await _db;
  final uc = db.collection(username);
  var review = await uc.findOne({"username": username, "place": place});
  review["dislikes"]++;
  await uc.save(review);

  final pc = db.collection(place);
  review = await pc.findOne({"username": username, "place": place});
  review["dislikes"]++;
  await pc.save(review);
}

Future closeDB() async {
  //await db.collection("reviews").remove({"place": "KAIMARU"}); // for testing
  
  // mongo "mongodb+srv://cluster0.r7txg.mongodb.net/cs473" --username admin
  // vcxz4321
  // use cs473
  // db.dropDatabase()
  // exit

  final db = await _db;
  await db.close();
}