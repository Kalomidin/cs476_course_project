//! Main function for the app
//!
//! authors @rooknpown

import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import './homepage.dart';
import 'dart:convert';
import './const.dart';
import 'login_page.dart';

// Your api key storage.
// import 'keys.dart';

void main() => runApp(MyApp());

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
      home: HomePage(),
      debugShowCheckedModeBanner: false,
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

  @override
  Widget build(BuildContext context) {
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
                )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Safety Level', style: TextStyle(height: 1, fontSize: 20)),
                RatingBar.builder(
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
                    
                  },
                ),
                Text('Overall Experience', style: TextStyle(height: 1, fontSize: 20)),
                RatingBar.builder(
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
                    print(rating);
                  },
                )
              ],
            ),
          ],
        ));
  }
}
*/
