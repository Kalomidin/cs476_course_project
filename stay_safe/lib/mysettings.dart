import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import './homepage.dart';
import 'dart:convert';
import './const.dart';
import './review.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MySettings extends StatelessWidget {
  String title;
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text('\n  Sort by',
                  style: TextStyle(height: 1, fontSize: 20)),
            ),
            Expanded(
              child: new Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                  child: Divider(
                    color: Colors.black,
                    height: 36,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ToggleSwitch(
                  minWidth: 150.0,
                  minHeight: 70.0,
                  fontSize: 23.0,
                  initialLabelIndex: 0,
                  labels: ['Safety', 'Overall'],
                  activeBgColors: [Colors.amber, Colors.blue],
                  onToggle: (index) {
                    print('switched to: $index');
                  },
                ),
              ],
            )
          ],
        ));
  }
}
