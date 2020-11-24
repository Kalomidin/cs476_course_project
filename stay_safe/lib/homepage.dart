//! This file to show home page of the app
//!
//! authors @rooknpown,

import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './search.dart';
import './review2.dart';
import './make_review.dart';
import './const.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  static final kInitialPosition = LatLng(36.37379078760264, 127.35905994710093);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  PickResult selectedPlace;
  
  Future<List<dynamic>> info = fetchAlbum();
  
  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=${photoReference}&key=AIzaSyDqOOHRnNiYaCweRNtiXVQswGAb1Pz88Yc";
  }

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
                  Navigator.pushReplacementNamed(
            context, '/homepage');
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
                              title: Text('Find Safety'),
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
      )
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