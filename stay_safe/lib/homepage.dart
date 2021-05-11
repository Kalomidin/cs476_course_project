//! This file to show home page of the app
//!
//! authors @rooknpown,

import 'package:example/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_webservice/places.dart';
import 'dart:convert';
import './search.dart';
import './review.dart';
import './make_review.dart';
import './const.dart';
import './settingspage.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({Key key, this.username}) : super(key: key);

  static final kInitialPosition = LatLng(36.37379078760264, 127.35905994710093);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PickResult selectedPlace;

  Future<List<dynamic>> info = fetchAlbum();

  @override
  Widget build(BuildContext context) {
    if (widget.username == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Stay Safe"),
        ),
        body: LoginPage(),
      );
    }
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
                  Navigator.of(context).pop();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage(username: widget.username)));
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
                              apiKey: "AIzaSyCzWl1iTZWgXLzzBSg6PIFalxYDjYBaN4U",
                              initialPosition: HomePage.kInitialPosition,
                              useCurrentLocation: true,
                              selectInitialPosition: true,

                              //usePlaceDetailSearch: true,
                              onPlacePicked: (result) {
                                selectedPlace = result;
                                print(result.adrAddress);
                      
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
                                // print(
                                //     "state: $state, isSearchBarFocused: $isSearchBarFocused" +
                                //         selectedPlace.name);
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
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AllReviews(
                                                            selectedPlaceName: selectedPlace.name, 
                                                            selectedPlacePicture: selectedPlace.photos[0].photoReference,
                                                            username: widget.username,
                                                          ),
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
                        print("Initial positions are: ${HomePage.kInitialPosition}");
                        return Scaffold(
                            appBar: AppBar(
                              title: Text('Add Review'),
                              automaticallyImplyLeading: false,
                            ),
                            body: PlacePicker(
                              apiKey: "AIzaSyCzWl1iTZWgXLzzBSg6PIFalxYDjYBaN4U",
                              initialPosition: HomePage.kInitialPosition,
                              useCurrentLocation: true,
                              selectInitialPosition: true,

                              //usePlaceDetailSearch: true,
                              onPlacePicked: (result) {
                                selectedPlace = result;
                                print("Selected place is following: ${selectedPlace.name} ${selectedPlace.openingHours}");
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                              // forceSearchOnZoomChanged: true,
                              // automaticallyImplyAppBarLeading: false,
                              // autocompleteLanguage: "ko",
                              // region: 'au',
                              // selectInitialPosition: true,
                              selectedPlaceWidgetBuilder: (_, selectedPlace,
                                  state, isSearchBarFocused) {
                                print("Picked the place waiting for press");
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
                                                  print(selectedPlace.name);
                                                  print(selectedPlace.rating);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          MakeReview(
                                                              selectedPlace:
                                                                  selectedPlace,
                                                              username: widget
                                                                  .username),
                                                    ),
                                                  );
                                                  //Navigator.of(context).pop();
                                                },
                                              ),
                                      );
                              },
                              pinBuilder: (context, state) {
                                if (state == PinState.Idle) {
                                  return Icon(Icons.favorite_border);
                                } else {
                                  return Icon(Icons.favorite);
                                }
                              },
                            ));
                      },
                    ),
                  );
                },
              ),
              IconButton(
                  icon: Icon(Icons.account_box),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Settings(userinfo: widget.username),
                        ));
                  }),
            ],
          ),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: info,
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              List<Widget> widgetlist = new List<Widget>();
              print("snaplength:" + snapshot.data.length.toString());
              for (int i = 0; i < snapshot.data.length; i = i + 2) {
                widgetlist.add(
                  new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                );
                widgetlist.add(
                  new Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Text(snapshot.data[i + 0],
                              style: TextStyle(height: 1, fontSize: 25)),
                        ]),
                  ),
                );
                widgetlist.add(
                  new Padding(
                    padding: EdgeInsets.only(
                        top: 16.0, left: 20.0, right: 20.0, bottom: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('   Safety Level',
                              style: TextStyle(height: 1, fontSize: 20)),
                          Text('Overall Experience',
                              style: TextStyle(height: 1, fontSize: 20)),
                        ]),
                  ),
                );
                widgetlist.add(
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(child: fixedStar(5.0 - i / 2, Colors.amber)),
                      Center(child: fixedStar(3, Colors.lightBlue)),
                    ],
                  ),
                );
                widgetlist.add(new Container(
                    child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 200.0),
                        child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllReviews(
                                                selectedPlaceName: snapshot.data[i + 0],
                                                selectedPlacePicture : snapshot.data[i + 1],
                                                username: widget.username,
                                              )));
                            },
                            padding: EdgeInsets.all(0.0),
                            child: Image.network(
                                buildPhotoURL(snapshot.data[i + 1]))))));
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
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}

String searchNearBy() {
  print(lat + lng);
  return "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=500&type=restaurant&key=AIzaSyCzWl1iTZWgXLzzBSg6PIFalxYDjYBaN4U";
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

/*
Future<List<dynamic>> fetchAlbum() async {
  String username = "swh";
  final response = await ReviewService().getReviewsByUsername(username);
  // TODO: Add OVerall Return future
  print("[All Reviews]Received response is: ${response} for place: $place");
  return response.data['reviews'];
}
*/
