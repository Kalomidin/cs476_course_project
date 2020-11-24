//! authors @rooknpown

import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './home.dart';
import './search.dart';
import './review.dart';
import './make_review.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  static final kInitialPosition = LatLng(36.37379078760264, 127.35905994710093);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PickResult selectedPlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stay Safe"),
        ),
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                            appBar: AppBar(
                              title: Text('Search Places. Find Safety'),
                              automaticallyImplyLeading: false,
                            ),
                            body: PlacePicker(
                              apiKey: "AIzaSyDqOOHRnNiYaCweRNtiXVQswGAb1Pz88Yc",
                              initialPosition: HomePage.kInitialPosition,
                              useCurrentLocation: true,
                              selectInitialPosition: true,

                              //usePlaceDetailSearch: true,
                              onPlacePicked: (result) {
                                selectedPlace = result;
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                              //forceSearchOnZoomChanged: true,
                              //automaticallyImplyAppBarLeading: false,
                              //autocompleteLanguage: "ko",
                              //region: 'au',
                              //selectInitialPosition: true,
                              selectedPlaceWidgetBuilder: (_, selectedPlace,
                                  state, isSearchBarFocused) {
                                print(
                                    "state: $state, isSearchBarFocused: $isSearchBarFocused" +
                                        selectedPlace.name);
                                return isSearchBarFocused
                                    ? Container()
                                    : FloatingCard(
                                        bottomPosition:
                                            0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                                        leftPosition: 0.0,
                                        rightPosition: 0.0,
                                        width: 500,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: state == SearchingState.Searching
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : RaisedButton(
                                                child: Text("Pick Here"),
                                                onPressed: () {
                                                  // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                                                  //            this will override default 'Select here' Button.
                                                  print(
                                                      "do something with [selectedPlace] data");
                                                  print(selectedPlace.placeId);
                                                  print(selectedPlace.rating);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SearchResult(
                                                              selectedPlace:
                                                                  selectedPlace),
                                                    ),
                                                  );
                                                  //Navigator.of(context).pop();
                                                },
                                              ),
                                      );
                              },
                              // pinBuilder: (context, state) {
                              //   if (state == PinState.Idle) {
                              //     return Icon(Icons.favorite_border);
                              //   } else {
                              //     return Icon(Icons.favorite);
                              //   }
                              // },
                            ));
                      },
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                            appBar: AppBar(
                              title: Text('Add Review'),
                              automaticallyImplyLeading: false,
                            ),
                            body: PlacePicker(
                              apiKey: "AIzaSyDqOOHRnNiYaCweRNtiXVQswGAb1Pz88Yc",
                              initialPosition: HomePage.kInitialPosition,
                              useCurrentLocation: true,
                              selectInitialPosition: true,

                              //usePlaceDetailSearch: true,
                              onPlacePicked: (result) {
                                selectedPlace = result;
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                              //forceSearchOnZoomChanged: true,
                              //automaticallyImplyAppBarLeading: false,
                              //autocompleteLanguage: "ko",
                              //region: 'au',
                              //selectInitialPosition: true,
                              selectedPlaceWidgetBuilder: (_, selectedPlace,
                                  state, isSearchBarFocused) {
                                print(
                                    "state: $state, isSearchBarFocused: $isSearchBarFocused");
                                return isSearchBarFocused
                                    ? Container()
                                    : FloatingCard(
                                        bottomPosition:
                                            0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                                        leftPosition: 0.0,
                                        rightPosition: 0.0,
                                        width: 500,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: state == SearchingState.Searching
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : RaisedButton(
                                                child: Text("Pick Here"),
                                                onPressed: () {
                                                  // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                                                  //            this will override default 'Select here' Button.
                                                  print(
                                                      "do something with [selectedPlace] data");
                                                  print(selectedPlace.placeId);
                                                  print(selectedPlace.rating);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          MakeReview(
                                                              selectedPlace:
                                                                  selectedPlace),
                                                    ),
                                                  );
                                                  //Navigator.of(context).pop();
                                                },
                                              ),
                                      );
                              },
                              // pinBuilder: (context, state) {
                              //   if (state == PinState.Idle) {
                              //     return Icon(Icons.favorite_border);
                              //   } else {
                              //     return Icon(Icons.favorite);
                              //   }
                              // },
                            ));
                      },
                    ),
                  );
                },
              ),
              // IconButton(
              //   icon: Icon(Icons.account_box),
              //   onPressed: () {},
              // ),
            ],
          ),
        ),
        body: new Image.network(
          "https://s3-alpha-sig.figma.com/img/1706/4c0e/56adf1329a844173a7b98575ec9d39ac?Expires=1607299200&Signature=GXhxZ-kWs6ClBSTzAZSiS2Pvkiuh3wnR52hyr9hGDRcO7VDN6MM5DIeZi68WrWfGLm7TJ2VTxzPbS0a2XMBJ39kyP1mZ4d-Z7TYk90f2VwBh1NLM-8BUzx8JUwsw0rTzIVS2egnK4N57oyIpXzMwzQ~-XhM-YjFv4A1ab8WlMtLU0JTXL60I~g0VDVBBQThgMGjyFJOLMqvoVHpAlrrv7t5BYvBoWIGTrZazzzZd24YNe0C4AfKEIebzs5fpzZOxN53y9hR616mcuZoFGIv4vlW0bZM2L9u27uVPm-Lnw0Dq4AwHiHZNkWgUyNp1w8VZev95gg3Cs5xsgsdh9rXOFQ__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA",
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ));
  }
}