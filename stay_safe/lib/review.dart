//! This file is used to show Reviews for the given place
//!
//! authors @rooknpown

import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import './homepage.dart';
import 'dart:convert'; 
import 'package:example/db/review_service.dart';
import 'const.dart';

class AllReviews extends StatelessWidget {
  final String selectedPlaceName;
  final String selectedPlacePicture;
  AllReviews(
      {@required this.selectedPlaceName, @required this.selectedPlacePicture});

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> infos = getPlaceInfos(selectedPlaceName);
    return Scaffold(
        appBar: AppBar(
          title: Text("Reviews: $selectedPlaceName"),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: infos,
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData && snapshot.data.length != 0) {
              List<Widget> widgetlist = new List<Widget>();
              print("snaplength:" + snapshot.data.length.toString());
              print("snapshot: $snapshot");
              widgetlist.add(
                new SizedBox(
                      height: 200,
                      child: Image.network(buildPhotoURL(selectedPlacePicture),
                          height: 200, fit: BoxFit.fill),
                    )
              );
              widgetlist.add(
                new Padding(
                  padding: EdgeInsets.only(
                      top: 16.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        
                      ]),
                ),
              );
              widgetlist.add(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Safety Level',
                            style: TextStyle(height: 1, fontSize: 20)),
                        Center(child: fixedStar(snapshot.data[0]['safety'], Colors.amber)),
                        Text('${snapshot.data[0]["safety"]}',
                            style: TextStyle(height: 1, fontSize: 15)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Overall Experience',
                            style: TextStyle(height: 1, fontSize: 20)),
                        Center(child: fixedStar(snapshot.data[0]['overall'], Colors.lightBlue)),
                        Text('${snapshot.data[0]["overall"]}',
                            style: TextStyle(height: 1, fontSize: 15)),
                      ],
                    ),
                  ],
                ),
              );

              widgetlist.add(
                new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              );

              for (int i = 0; i < snapshot.data.length; i = i + 1) {
                /*
                widgetlist.add(
                  new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                );
                */
                widgetlist.add(
                  Card(
                    margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    child: InkWell(
                      onTap: () {
                        
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: CircleAvatar(
                                //TODO: fill this with default profile image
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${snapshot.data[i]['username']}",
                                    style: TextStyle(height: 1, fontSize: 20, fontWeight: FontWeight.bold)),
                                  Text(
                                    "${snapshot.data[i]['content']}",
                                    style: TextStyle(height: 1, fontSize: 15))
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon (
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Text (
                                        "${snapshot.data[i]['safety']}",
                                        style: TextStyle(height: 1, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon (
                                        Icons.star,
                                        color: Colors.lightBlue,
                                      ),
                                      Text (
                                        "${snapshot.data[i]['overall']}",
                                        style: TextStyle(height: 1, fontSize: 12),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
                /*
                widgetlist.add(
                  Row(
                    children: [
                      Icon(Icons.account_box),
                      Column(children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                                '${snapshot.data[i]['username']}                               ',
                                style: TextStyle(height: 3, fontSize: 20)),
                          ),
                        ),
                        Text(
                            "${snapshot.data[i]['content']}                         ",
                            style: TextStyle(height: 1, fontSize: 15))
                      ])
                    ],
                  ),
                );
                widgetlist.add(
                  new Padding(
                    padding: EdgeInsets.only(
                        top: 16.0, left: 20.0, right: 20.0, bottom: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Safety',
                              style: TextStyle(height: 1, fontSize: 20)),
                          Text('Overall',
                              style: TextStyle(height: 1, fontSize: 20)),
                        ]),
                  ),
                );
                widgetlist.add(
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(child: fixedStar(snapshot.data[i]['safety'], Colors.amber)),
                      Center(child: fixedStar(snapshot.data[i]['overall'], Colors.lightBlue)),
                    ],
                  ),
                );
                */
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
            } else if (snapshot.data.length == 0) {
              return ListView(
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 1.0),
                      child: SizedBox(
                        height: 200,
                        child: Image.network(
                            buildPhotoURL(selectedPlacePicture),
                            height: 200,
                            fit: BoxFit.fill),
                      )),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 16.0, left: 20.0, right: 20.0),
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
                      Center(child: fixedStar(3, Colors.amber)),
                      Center(child: fixedStar(3, Colors.lightBlue)),
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
                        Text(
                            "People can't help taking off their masks while eating.",
                            style: TextStyle(height: 1, fontSize: 15))
                      ])
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(child: fixedStar(2, Colors.amber)),
                      Center(child: fixedStar(3, Colors.lightBlue)),
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
                      Center(child: fixedStar(3, Colors.amber)),
                      Center(child: fixedStar(3, Colors.lightBlue)),
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
                      Center(child: fixedStar(4, Colors.amber)),
                      Center(child: fixedStar(3, Colors.lightBlue)),
                    ],
                  ),
                ],
              );
              // return ListView(
              //   children: [
              //     Text(
              //         "No Reviews available...",
              //         style: TextStyle(height: 1, fontSize: 25)),
              //   ],
              // );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}

Future<List<dynamic>> getPlaceInfos(String place) async {
  final response = await ReviewService().getReviewsByPlace(place);
  // TODO: Add OVerall Return future
  final overall = await ReviewService().averageOverall(place);
  print("[All Reviews]Received response is: ${response} for place: $place");
  return response.data['reviews'];
}
