//! This is to show home for the user
//!
//! authors @rooknpown

import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './const.dart';
import './review2.dart';

class HomeScreen extends StatelessWidget {
  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=${photoReference}&key=AIzaSyDqOOHRnNiYaCweRNtiXVQswGAb1Pz88Yc";
  }

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> info = fetchAlbum();
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover places"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: info,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            List<Widget> widgetlist = new List<Widget>();
            print("snaplength:" + snapshot.data.length.toString());
            for (int i = 0; i < snapshot.data.length; i = i + 2) {
              widgetlist.add(new Text(snapshot.data[i + 0],
                  style: TextStyle(height: 1, fontSize: 25)));
              widgetlist.add(new Expanded(
                  child: Container(
                      child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 500.0),
                          child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AllReviews2(
                                                selectedPlace: [
                                                  snapshot.data[i + 0],
                                                  snapshot.data[i + 1]
                                                ])));
                              },
                              padding: EdgeInsets.all(0.0),
                              child: Image.network(
                                  buildPhotoURL(snapshot.data[i + 1])))))));
            }
            return new ListView(
              children: widgetlist,
            );
          } else if (snapshot.hasError) {
            return ListView(
              children: [
                Text("Searching for places... \n seems to be nothing found 😬. Please try to change your preferred location",
                    style: TextStyle(height: 1, fontSize: 25)),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

String searchNearBy() {
  print(lat + lng);
  return "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=100&type=restaurant&key=AIzaSyDqOOHRnNiYaCweRNtiXVQswGAb1Pz88Yc";
}

Future<List<dynamic>> fetchAlbum() async {
  final response = await http.get(searchNearBy());
  Map<String, dynamic> user = jsonDecode(response.body);
  var list = new List();
  for (int i = 0; i < user["results"].length; i++) {
    if (user["results"][i]["name"] != null &&
        user["results"][i]["photos"] != null) {
      list.add(user["results"][i]["name"]);
      list.add(user["results"][i]["photos"][0]["photo_reference"]);
    }
  }
  await Future.delayed(const Duration(seconds: 1), () {});
  print(user["results"][0]["name"]);
  return list;
}
