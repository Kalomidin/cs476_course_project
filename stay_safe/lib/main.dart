//! authors @rooknpown

import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import './homepage.dart';
import 'dart:convert';
<<<<<<< HEAD
import './const.dart';
import 'login_page.dart';
=======
import 'database.dart';
>>>>>>> ca3d988b4465aa9b9545ec05de30fd321285eac1

// Your api key storage.
// import 'keys.dart';

<<<<<<< HEAD
void main() => runApp(MyApp());
=======
final _db = openDB();
void main() async {
  runApp(MyApp());
  await closeDB(await _db);
}
String lat = "36.37379078760264";
String lng = "127.35905994710093";
>>>>>>> ca3d988b4465aa9b9545ec05de30fd321285eac1

class MyApp extends StatelessWidget {
  // Light Theme
  final ThemeData lightTheme = ThemeData.light().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.white,
    buttonTheme: ButtonThemeData(
      // Select here's button color
      buttonColor: Colors.black,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // Dark Theme
  final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.grey,
    buttonTheme: ButtonThemeData(
      // Select here's button color
      buttonColor: Colors.yellow,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map Place Picker Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/homepage": (_) => new HomePage(),
      },
    );
  }
}

/*
class MakeReview extends StatefulWidget {
  final PickResult selectedPlace;

  @override
  MakeReview({@required this.selectedPlace});

  _MakeReviewState createState() => _MakeReviewState();
}

class _MakeReviewState extends State<MakeReview> {

  int safety = 0;
  int overall = 0;

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=${photoReference}&key=AIzaSyDqOOHRnNiYaCweRNtiXVQswGAb1Pz88Yc";
  }

<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Make Review on: ${widget.selectedPlace.name}"),
=======
  SearchResult({@required this.selectedPlace});
  @override
  Widget build(BuildContext context) {
    lat = selectedPlace.geometry.location.lat.toString();
    lng = selectedPlace.geometry.location.lng.toString();
    return Scaffold(
        appBar: AppBar(
          title: Text(selectedPlace.name),
>>>>>>> ca3d988b4465aa9b9545ec05de30fd321285eac1
        ),
        body: ListView(
          children: [
            Padding(
<<<<<<< HEAD
                padding: EdgeInsets.only(),
                child: SizedBox(
                  height: 200,
                  child: Image.network(
                      buildPhotoURL(widget.selectedPlace.photos[0].photoReference),
                      height: 200,
                      fit: BoxFit.fill),
                )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Safety Level', style: TextStyle(height: 1, fontSize: 20)),
                RatingBar.builder(
                  initialRating: 0,
=======
                padding: EdgeInsets.only(right: 1.0),
                child: SizedBox(
                  height: 400,
                  child: Image.network(
                      buildPhotoURL(selectedPlace.photos[0].photoReference),
                      height: 400,
                      fit: BoxFit.fill),
                )),
            Text('Safety Level', style: TextStyle(height: 1, fontSize: 25)),
            Center(
                child: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemSize: 65.0,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            )),
            Text('Overall Experience',
                style: TextStyle(height: 1, fontSize: 25)),
            Center(
                child: RatingBar.builder(
              initialRating: selectedPlace.rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemSize: 65.0,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.lightBlue,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            )),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AllReviews(selectedPlace: selectedPlace)));
                },
                child: Text('SEE ALL REVIEWS'),
              ),
            )
          ],
        ));
  }
}

class AllReviews extends StatelessWidget {
  final PickResult selectedPlace;

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=${photoReference}&key=AIzaSyDqOOHRnNiYaCweRNtiXVQswGAb1Pz88Yc";
  }

  AllReviews({@required this.selectedPlace});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reviews: " + selectedPlace.name),
        ),
        body: ListView(
          children: [
            Padding(
                padding: EdgeInsets.only(right: 1.0),
                child: SizedBox(
                  height: 200,
                  child: Image.network(
                      buildPhotoURL(selectedPlace.photos[0].photoReference),
                      height: 200,
                      fit: BoxFit.fill),
                )),
            Padding(
              padding: EdgeInsets.only(top: 16.0, left: 20.0, right: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Safety Level',
                        style: TextStyle(height: 1, fontSize: 20)),
                    Text('Overall Experience',
                        style: TextStyle(height: 1, fontSize: 20)),
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: RatingBar.builder(
                  initialRating: 3,
>>>>>>> ca3d988b4465aa9b9545ec05de30fd321285eac1
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
<<<<<<< HEAD
                    
                  },
                ),
                Text('Overall Experience', style: TextStyle(height: 1, fontSize: 20)),
                RatingBar.builder(
                  initialRating: 0,
=======
                    print(rating);
                  },
                )),
                Center(
                    child: RatingBar.builder(
                  initialRating: selectedPlace.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.lightBlue,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )),
              ],
            ),
            Row(
              children: [
                Icon(Icons.account_box),
                Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                          'Anonymous                                          ',
                          style: TextStyle(height: 3, fontSize: 20)),
                    ),
                  ),
                  Text("People can't help taking off their masks while eating.",
                      style: TextStyle(height: 1, fontSize: 15))
                ])
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: RatingBar.builder(
                  initialRating: 2,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )),
                Center(
                    child: RatingBar.builder(
                  initialRating: selectedPlace.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.lightBlue,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )),
              ],
            ),
            Row(
              children: [
                Icon(Icons.account_box),
                Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                          'Will kenny                                           ',
                          style: TextStyle(height: 3, fontSize: 20)),
                    ),
                  ),
                  Text(
                      'Safe, since people are not allowed to sit face to face.',
                      style: TextStyle(height: 1, fontSize: 15))
                ])
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )),
                Center(
                    child: RatingBar.builder(
                  initialRating: selectedPlace.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.lightBlue,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )),
              ],
            ),
            Row(
              children: [
                Icon(Icons.account_box),
                Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                          '    Harry Kim                                           ',
                          style: TextStyle(height: 3, fontSize: 20)),
                    ),
                  ),
                  Text('This place is very clean and neat!',
                      style: TextStyle(height: 1, fontSize: 15))
                ])
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: RatingBar.builder(
                  initialRating: 4,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )),
                Center(
                    child: RatingBar.builder(
                  initialRating: selectedPlace.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.lightBlue,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )),
              ],
            ),
          ],
        ));
  }
}

class AllReviews2 extends StatelessWidget {
  final List<String> selectedPlace;

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=${photoReference}&key=AIzaSyDqOOHRnNiYaCweRNtiXVQswGAb1Pz88Yc";
  }

  AllReviews2({@required this.selectedPlace});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reviews: " + selectedPlace[0]),
        ),
        body: ListView(
          children: [
            Padding(
                padding: EdgeInsets.only(right: 1.0),
                child: SizedBox(
                  height: 200,
                  child: Image.network(buildPhotoURL(selectedPlace[1]),
                      height: 200, fit: BoxFit.fill),
                )),
            Padding(
              padding: EdgeInsets.only(top: 16.0, left: 20.0, right: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Safety Level',
                        style: TextStyle(height: 1, fontSize: 20)),
                    Text('Overall Experience',
                        style: TextStyle(height: 1, fontSize: 20)),
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )),
                Center(
                    child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.lightBlue,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )),
              ],
            ),
            Row(
              children: [
                Icon(Icons.account_box),
                Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                          'Anonymous                                          ',
                          style: TextStyle(height: 3, fontSize: 20)),
                    ),
                  ),
                  Text("People can't help taking off their masks while eating.",
                      style: TextStyle(height: 1, fontSize: 15))
                ])
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: RatingBar.builder(
                  initialRating: 2,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )),
                Center(
                    child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.lightBlue,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )),
              ],
            ),
            Row(
              children: [
                Icon(Icons.account_box),
                Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                          'Will kenny                                           ',
                          style: TextStyle(height: 3, fontSize: 20)),
                    ),
                  ),
                  Text(
                      'Safe, since people are not allowed to sit face to face.',
                      style: TextStyle(height: 1, fontSize: 15))
                ])
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )),
                Center(
                    child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.lightBlue,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )),
              ],
            ),
            Row(
              children: [
                Icon(Icons.account_box),
                Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                          '    Harry Kim                                           ',
                          style: TextStyle(height: 3, fontSize: 20)),
                    ),
                  ),
                  Text('This place is very clean and neat!',
                      style: TextStyle(height: 1, fontSize: 15))
                ])
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: RatingBar.builder(
                  initialRating: 4,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )),
                Center(
                    child: RatingBar.builder(
                  initialRating: 3,
>>>>>>> ca3d988b4465aa9b9545ec05de30fd321285eac1
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.lightBlue,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
<<<<<<< HEAD
                )
=======
                )),
>>>>>>> ca3d988b4465aa9b9545ec05de30fd321285eac1
              ],
            ),
          ],
        ));
  }
}
<<<<<<< HEAD
*/
=======

class MakeReview extends StatelessWidget {
  final PickResult selectedPlace;
  final myController = TextEditingController();
  double safety;
  double overall;
  String content;

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=${photoReference}&key=AIzaSyDqOOHRnNiYaCweRNtiXVQswGAb1Pz88Yc";
  }

  MakeReview({@required this.selectedPlace});

  @override
  Widget build(BuildContext context) {
    lat = selectedPlace.geometry.location.lat.toString();
    lng = selectedPlace.geometry.location.lng.toString();
    return Scaffold(
        appBar: AppBar(
          title: Text("Make Review on: ${selectedPlace.name}"),
        ),
        body: ListView(
          children: [
            Padding(
                padding: EdgeInsets.only(),
                child: SizedBox(
                  height: 200,
                  child: Image.network(
                      buildPhotoURL(selectedPlace.photos[0].photoReference),
                      height: 200,
                      fit: BoxFit.fill),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text('Safety Level',
                      style: TextStyle(height: 1, fontSize: 20)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemSize: 25.0,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      safety = rating;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text('Overall Experience',
                      style: TextStyle(height: 1, fontSize: 20)),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemSize: 25.0,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.lightBlue,
                      ),
                      onRatingUpdate: (rating) {
                        overall = rating;
                      },
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: TextField(
                        controller: myController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Write your comment here',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.help_center),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('How should I make a review?'),
                                    content: const Text('''
You can determine the level of safety using these criteria:\n\
1. The number of people in the place (crowdiness) \n
2. Percentage of people (especially staffs) wearing masks \n 
3. Whether hand sanitizers are well equipped or not \n
4. Other policies enforced in that place (e.g. In cafeteria, people are not allowed to sit face-to-face.) 
'''),
                                    actions: [
                                      FlatButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          //Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        maxLines: null)),
                Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: RaisedButton(
                        color: Colors.lightBlue,
                        onPressed: () {
                          content = myController.text;
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Submission Successful'),
                                content: const Text('Thanks for your support!'),
                                actions: [
                                  FlatButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      //Navigator.of(context).pop();
                                      Navigator.popUntil(
                                          context,
                                          ModalRoute.withName(
                                              Navigator.defaultRouteName));
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(Icons.publish, color: Colors.white)))
              ],
            ),
          ],
        ));
  }
}
>>>>>>> ca3d988b4465aa9b9545ec05de30fd321285eac1
