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
  final String username;

  SearchResult({@required this.selectedPlace, @required this.username});
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
            Center(child: fixedStar(3, Colors.amber)),
            Text('Overall Experience in Google Map',
                style: TextStyle(height: 1, fontSize: 25)),
            Center(child: fixedStar(selectedPlace.rating, Colors.lightBlue)),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AllReviews(
                                selectedPlaceName: selectedPlace.name, 
                                selectedPlacePicture: selectedPlace.photos[0].photoReference,
                                username: username,
                              )
                      )
                  );
                },
                child: Text('SEE ALL REVIEWS'),
              ),
            )
          ],
        ));
  }
}
