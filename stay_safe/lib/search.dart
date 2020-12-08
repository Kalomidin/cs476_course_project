//! This file is used to search and find place for the given specific inputted place
//!
//! author @kalo, @rooknpown

import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import './homepage.dart';
import 'dart:convert';
import './const.dart';
import './review.dart';

class SearchResult extends StatelessWidget {
  final PickResult selectedPlace;
  String title;

  SearchResult({@required this.selectedPlace});
  @override
  Widget build(BuildContext context) {
    lat = selectedPlace.geometry.location.lat.toString();
    lng = selectedPlace.geometry.location.lng.toString();
    if (selectedPlace == Null) {
      title = selectedPlace.name;
    } else {
      title = "Loading name...";
    }
    
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(
          children: [
            Padding(
                padding: EdgeInsets.only(right: 1.0),
                child: SizedBox(
                  height: 400,
                  child: Image.network(
                      buildPhotoURL(selectedPlace.photos[0].photoReference),
                      height: 400,
                      fit: BoxFit.fill),
                )),
            // TODO: Add setting safety
            Text('Safety Level', style: TextStyle(height: 1, fontSize: 25)),
            Center(
                child: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              ignoreGestures: true,
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
            Text('Overall Experience in Google Map',
                style: TextStyle(height: 1, fontSize: 25)),
            Center(
                child: RatingBar.builder(
              initialRating: selectedPlace.rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              ignoreGestures: true,
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
                              AllReviews(selectedPlaceName: selectedPlace.name, selectedPlacePicture: selectedPlace.photos[0].photoReference,)));
                },
                child: Text('SEE ALL REVIEWS'),
              ),
            )
          ],
        ));
  }
}
