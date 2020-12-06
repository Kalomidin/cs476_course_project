import "package:mongo_dart/mongo_dart.dart";
import "package:sevr/sevr.dart";
import "dart:io" show Platform;

void main() async {
  ReviewServer().run();
}

class ReviewServer {

  static final ReviewServer _instance = ReviewServer._internal();

  factory ReviewServer() {
    return _instance;
  }

  static final portEnv = Platform.environment['PORT'];
  final port = portEnv == null ? 8081 : int.parse(portEnv);
  final serv = Sevr();
  final helper = ReviewServerHelper();
  final corsPaths = ['/'];

  ReviewServer._internal() {
  
    void setCors(ServRequest req, ServResponse res) {
      res.response.headers.add('Access-Control-Allow-Origin', '*');
      res.response.headers.add('Access-Control-Allow-Methods', 'GET, POST, DELETE');
      res.response.headers
          .add('Access-Control-Allow-Headers', 'Origin, Content-Type');
    }

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
        //final x = req.body['content'];
        //print(x[0]);
        //print(x[0].runtimeType);
        print("Reached herehere");
        await helper.makeReview(
          req.body['username'], 
          req.body['place'], 
          req.body['safety'], 
          req.body['overall'], 
          //List<String>.from(req.body['content'].map((x) => x.toString()).toList()),
          req.body['content'],
          req.body['date'],
        );
        return res.status(200);
      }
    ]);

    serv.post('/averagesafety', [
      setCors,
      (ServRequest req, ServResponse res) async {
        final safety = await helper.averageSafety(
          req.body['place'], 
        );
        return res.status(200).json({'safety': safety});
      }
    ]);

    serv.post('/averageoverall', [
      setCors,
      (ServRequest req, ServResponse res) async {
        final overall = await helper.averageOverall(
          req.body['place'], 
        );
        return res.status(200).json({'overall': overall});
      }
    ]);

    serv.post('/getreviewsbyplace', [
      setCors,
      (ServRequest req, ServResponse res) async {
        final reviews = await (await helper.getReviewsByPlace(
          req.body['place'], 
        )).toList();
        return res.status(200).json({'reviews': reviews});
      }
    ]);

    serv.post('/getreviewsbyusername', [
      setCors,
      (ServRequest req, ServResponse res) async {
        final reviews = await (await helper.getReviewsByUsername(
          req.body['username'], 
        )).toList();
        return res.status(200).json({'reviews': reviews});
      }
    ]);

    serv.post('/getcomments', [
      setCors,
      (ServRequest req, ServResponse res) async {
        final comments = await helper.getComments(
          req.body['username'],
          req.body['place'], 
        );
        return res.status(200).json({'comments': comments});
      }
    ]);

    serv.post('/addcomment', [
      setCors,
      (ServRequest req, ServResponse res) async {
        await helper.addComment(
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
        await helper.upvote(
          req.body['username'],
          req.body['place'],
        );
        return res.status(200);
      }
    ]);

    serv.post('/downvote', [
      setCors,
      (ServRequest req, ServResponse res) async {
        await helper.downvote(
          req.body['username'],
          req.body['place'],
        );
        return res.status(200);
      }
    ]);

    //get request
  serv.get('/test', [
    (ServRequest req, ServResponse res) {
      return res.status(200).json({'status': 'ok'});
    }
  ]);
  }

  run() async {
    await helper.openDB();
    // Listen for connections
    await serv.listen(port, callback: () {
      print('Server listening on port: $port');
    }, address: "0.0.0.0");
    await helper.closeDB();
  }
}

class ReviewServerHelper {

  Db db;

  Future openDB() async {
    db = await Db.create("mongodb+srv://kalomidin:123kalom@cluster0.2rm32.mongodb.net/dbname?retryWrites=true&w=majority");
    await db.open();
  }

  Future makeReview(String username, String place, double safety, double overall, String content, String date) async {
    print("Calling Make Review in db");
    //final db = await _db;
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
      "comments": <Map<String, dynamic>>[],
      "date": date,
    };
    print("Hey there, data is being inserted");
    await uc.insert(data);
    print("Hey there, data uc has been inserted");
    await pc.insert(data);
    print("Hey there, data pc has been inserted");
  }

  Future<double> averageSafety(String place) async {
    //final db = await _db;
    final pc = db.collection(place);
    final sum = await pc.find({"place": place}).fold(0.0, (sum, review) => sum + review["safety"]);
    final length = await pc.find({"place": place}).length;
    return sum / length;
  }

  Future<double> averageOverall(String place) async {
    //final db = await _db;
    final pc = db.collection(place);
    final sum = await pc.find({"place": place}).fold(0.0, (sum, review) => sum + review["overall"]);
    final length = await pc.find({"place": place}).length;
    return sum / length;
  }

  Future<Stream<Map<String, dynamic>>> getReviewsByPlace(String place) async {
    //final db = await _db;
    final pc = db.collection(place);
    return pc.find(where.eq("place", place).sortBy("date", descending: true));
  }

  Future<Stream<Map<String, dynamic>>> getReviewsByUsername(String username) async {
    //final db = await _db;
    final uc = db.collection(username);
    return uc.find(where.eq("username", username).sortBy("date", descending: true));
  }

  Future<List<Map<String, dynamic>>> getComments(String username, String place) async {
    //final db = await _db;
    final uc = db.collection(username);
    return ((await uc.findOne({"username": username, "place": place}))["comments"] as List).cast<Map<String, dynamic>>();
  }

  Future addComment(String username, String place, String commenter, String content) async {
    //final db = await _db;
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
    //final db = await _db;
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
    //final db = await _db;
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
    // mongo "mongodb+srv://cluster0.r7txg.mongodb.net/cs473" --username admin
    // vcxz4321
    // use cs473
    // db.dropDatabase()
    // exit

    //final db = await _db;
    await db.close();
  }
}
