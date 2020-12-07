import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import './homepage.dart';
import 'dart:convert';
import './const.dart';
import './review.dart';
import './myreviews.dart';
import './mysettings.dart';

class Settings extends StatelessWidget {
  final String userinfo;
  String title;
  Settings({@required this.userinfo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Profile"),
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 20.0),
              child: Divider(
                color: Colors.black,
                height: 36,
              )
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MyReviews(userinfo: "selectedPlace"),
                    ));
              },
              child: Text(
                "Reviews",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 20.0),
              child: Divider(
                color: Colors.black,
                height: 36,
              )
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MySettings(),
                    ));
              },
              child: Text(
                "Settings",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 20.0),
              child: Divider(
                color: Colors.black,
                height: 36,
              )
            ),
          ],
        ));
  }
}
