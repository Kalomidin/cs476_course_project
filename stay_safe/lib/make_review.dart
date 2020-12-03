//! This file is used to `maker_review` for the specified place and it sends to `server` which saves those datas
//!
//! author @rooknpown @castlecowrice

import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import './const.dart';
import 'db/review_service.dart';

class MakeReview extends StatefulWidget {
  final PickResult selectedPlace;

  MakeReview({@required this.selectedPlace});

  @override
  _MakeReviewState createState() => _MakeReviewState();
}

class _MakeReviewState extends State<MakeReview> {
  final controllers = [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(),];

  double safety;
  double overall;
  List<String> content;

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=${photoReference}&key=AIzaSyDqOOHRnNiYaCweRNtiXVQswGAb1Pz88Yc";
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    lat = widget.selectedPlace.geometry.location.lat.toString();
    lng = widget.selectedPlace.geometry.location.lng.toString();
    return Scaffold(
        appBar: AppBar(
          title: Text("Make Review on: ${widget.selectedPlace.name}"),
        ),
        body: ListView(
          children: [
            Padding(
                padding: EdgeInsets.only(),
                child: SizedBox(
                  height: 200,
                  child: Image.network(
                      buildPhotoURL(widget.selectedPlace.photos[0].photoReference),
                      height: 200,
                      fit: BoxFit.fill),
                )),
            
            Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
              Text(
                'Ratings',
                style: TextStyle(height: 1, fontSize: 15)
              ),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
            ]),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text('Safety Level',
                      style: TextStyle(height: 1, fontSize: 20)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
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
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.help_center),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('What does safety level mean?'),
                                content: const Text('''
It refers to how safe the place is against the pandemic.\n
You can determine the level of safety using the criteria listed below.
'''),
                                actions: [
                                  FlatButton(
                                    child: Text('Got it!'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )
                    )
                  ]
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text('Overall Experience',
                      style: TextStyle(height: 1, fontSize: 20)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
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
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.help_center),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('What does overall experience mean?'),
                                content: const Text('''
It literally refers to your overall rating to the place, not limited to its safety.\n
Think of it as a rating you would made for a place when you use google maps.
'''),
                                actions: [
                                  FlatButton(
                                    child: Text('Got it!'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )
                    )
                  ]
                ),

                Row(children: <Widget>[
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: Divider(
                          color: Colors.black,
                          height: 36,
                        )),
                  ),
                  Text(
                    'Reviews',
                    style: TextStyle(height: 1, fontSize: 15)
                  ),
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Divider(
                          color: Colors.black,
                          height: 36,
                        )),
                  ),
                ]),

                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    '1. How many people are there?',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1, fontSize: 20),
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: controllers[0],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your Answer',
                    ),
                    maxLines: 1,
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    '2. How many people are wearing their masks?',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1, fontSize: 20),
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: controllers[1],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your Answer',
                    ),
                    maxLines: 1,
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    '3. Are hand sanitizers well equipped?',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1, fontSize: 20),
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: controllers[2],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your Answer',
                    ),
                    maxLines: 1,
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    '4. Are there any other policies for safety?\nFor example, some cafeterias do not allow people to sit face-to-face.',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1, fontSize: 20),
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: controllers[3],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your Answer',
                    ),
                    maxLines: null,
                  )
                ),
                /*
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
                */



                Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: RaisedButton(
                        color: Colors.lightBlue,
                        onPressed: () {
                          content = controllers.map((controller) => controller.text).toList();
                          //print(content[0]);
                          //print(content[0].runtimeType);
                          ReviewService().makeReview("swh", widget.selectedPlace.name, safety, overall, content);
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
                                      //Navigator.popUntil(context, ModalRoute.withName('/homepage'));
                                      Navigator.pushReplacementNamed(context, '/homepage');
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