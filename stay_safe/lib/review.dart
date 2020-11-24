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
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
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
                  initialRating: selectedPlace.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
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
                  initialRating: selectedPlace.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
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
                  initialRating: selectedPlace.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
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
                  initialRating: selectedPlace.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
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
          ],
        ));
  }
}