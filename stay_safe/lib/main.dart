import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

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
                onPressed: () {},
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
                              title: Text('Search Places. Add Review'),
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
              IconButton(
                icon: Icon(Icons.account_box),
                onPressed: () {},
              ),
            ],
          ),
        ));
  }
}

class SearchResult extends StatelessWidget {
  final PickResult selectedPlace;

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=${photoReference}&key=AIzaSyDqOOHRnNiYaCweRNtiXVQswGAb1Pz88Yc";
  }

  SearchResult({@required this.selectedPlace});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(selectedPlace.name),
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
            Text('Safety Level', style: TextStyle(height: 1, fontSize: 25)),
            Center(
                child: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
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
            Text('Overall Experience',
                style: TextStyle(height: 1, fontSize: 25)),
            Center(
                child: RatingBar.builder(
              initialRating: selectedPlace.rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
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
                              AllReviews(selectedPlace: selectedPlace)));
                },
                child: Text('SEE ALL REVIEWS'),
              ),
            )
          ],
        ));
  }
}

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
            )
          ],
        ));
  }
}


class MakeReview extends StatelessWidget {
  final PickResult selectedPlace;
  final myController = TextEditingController();
  double safety;
  double overall;
  String content;

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=${photoReference}&key=AIzaSyDqOOHRnNiYaCweRNtiXVQswGAb1Pz88Yc";
  }

  MakeReview({@required this.selectedPlace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Make Review on: ${selectedPlace.name}"),
        ),
        body: ListView(
          children: [
            Padding(
                padding: EdgeInsets.only(),
                child: SizedBox(
                  height: 200,
                  child: Image.network(
                      buildPhotoURL(selectedPlace.photos[0].photoReference),
                      height: 200,
                      fit: BoxFit.fill),
                )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding (
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text('Safety Level', style: TextStyle(height: 1, fontSize: 20)),
                ),
                Padding (
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: RatingBar.builder(
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
                      safety = rating;
                    },
                  ),
                ),
                Padding (
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text('Overall Experience', style: TextStyle(height: 1, fontSize: 20)),
                ),
                Padding (
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: RatingBar.builder(
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
                      overall = rating;
                    },
                  )
                ),
                Padding (
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextField (
                    controller: myController,
                    decoration: InputDecoration(
    	                border: OutlineInputBorder(),
    	                labelText: 'Write your comment here',
                    )
                  )
                ),
                Padding (
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: RaisedButton (
                    onPressed: () {
                      content = myController.text;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Submission Successful'),
                            content: const Text('Thanks for your support!'),
                            actions: [
                              FlatButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  //Navigator.of(context).pop();
                                  Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Icon(Icons.publish)
                  )
                )
              ],
            ),
          ],
        ));
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