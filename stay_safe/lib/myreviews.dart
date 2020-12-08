import 'package:example/db/review_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import './homepage.dart';
import 'dart:convert';
import './const.dart';
import './review.dart';
import './review2.dart';

class MyReviews extends StatelessWidget {
  final String userinfo;
  String title;
  MyReviews({@required this.userinfo});

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> infos = getUserInfos(userinfo);
    return Scaffold(
        appBar: AppBar(
          title: Text("My Reviews"),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: infos,
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              List<Widget> widgetlist = new List<Widget>();
              print("snaplength:" + snapshot.data.length.toString());
              print("snapshot: $snapshot");
              for (int i = 0; i < snapshot.data.length; i = i + 1) {
                widgetlist.add(
                  new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                );
                widgetlist.add(
                  new Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 20.0),
                              child: Divider(
                                color: Colors.black,
                                height: 36,
                              )),
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllReviews(
                                      selectedPlaceName: snapshot.data[i]
                                          ['place'],
                                      selectedPlacePicture: snapshot.data[i]
                                          ['picture'],
                                    ),
                                  ));
                            },
                            child: Text(
                              snapshot.data[i]['place'],
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ]),
                  ),
                );
                widgetlist.add(
                  new Padding(
                    padding: EdgeInsets.only(
                        top: 16.0, left: 20.0, right: 20.0, bottom: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('   Safety Level',
                              style: TextStyle(height: 1, fontSize: 20)),
                          Text('Overall Experience',
                              style: TextStyle(height: 1, fontSize: 20)),
                        ]),
                  ),
                );
                widgetlist.add(
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                          child: RatingBar.builder(
                        initialRating: snapshot.data[i]['safety'],
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        ignoreGestures: true,
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
                        initialRating: snapshot.data[i]['overall'],
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        ignoreGestures: true,
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
                );
                widgetlist.add(new Container(
                    child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 200.0),
                        child: FlatButton(
                            onPressed: () {},
                            padding: EdgeInsets.all(0.0),
                            child: Image.network(
                                buildPhotoURL(snapshot.data[i]['picture']))))));

                widgetlist.add(
                  new Row(
                    children: [
                      Icon(Icons.account_box),
                      Column(children: [
                        Text("   ${snapshot.data[i]['content']}              ",
                            style: TextStyle(height: 1, fontSize: 20))
                      ])
                    ],
                  ),
                );
              }
              return new ListView(
                children: widgetlist,
              );
            } else if (snapshot.hasError) {
              return ListView(
                children: [
                  Text(
                      "Searching for places... \n seems to be nothing found 😬. Please try to change your preferred location",
                      style: TextStyle(height: 1, fontSize: 25)),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}

Future<List<dynamic>> getUserInfos(String username) async {
  final response = await ReviewService().getReviewsByUsername(username);
  print(
      "[My Reviews]Received response is: ${response} for username: $username");
  return response.data['reviews'];
}

String buildPhotoURL(String photoReference) {
  return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=${photoReference}&key=AIzaSyDqOOHRnNiYaCweRNtiXVQswGAb1Pz88Yc";
}
