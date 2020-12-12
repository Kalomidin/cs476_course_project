//! This file is used to show Reviews for the given place
//!
//! authors @rooknpown @castlecowrice

import 'package:flutter/material.dart';
import 'package:example/db/review_service.dart';
import 'const.dart';
import 'package:timeago/timeago.dart' as timeago;

class AllReviews extends StatefulWidget {
  final String selectedPlaceName;
  final String selectedPlacePicture;
  final String username;
  AllReviews(
      {@required this.selectedPlaceName, @required this.selectedPlacePicture, @required this.username});

  @override
  _AllReviewsState createState() => _AllReviewsState();
}

class _AllReviewsState extends State<AllReviews> {
  int open = -1;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> infos = getPlaceInfos(widget.selectedPlaceName);
    return Scaffold(
        appBar: AppBar(
          title: Text("Reviews: ${widget.selectedPlaceName}"),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: infos,
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData && snapshot.data.length != 0) {
              List<Widget> widgetlist = new List<Widget>();
              print("snaplength:" + snapshot.data.length.toString());
              print("snapshot: $snapshot");
              widgetlist.add(
                new SizedBox(
                      height: 200,
                      child: Image.network(buildPhotoURL(widget.selectedPlacePicture),
                          height: 200, fit: BoxFit.fill),
                    )
              );
              widgetlist.add(
                new Padding(
                  padding: EdgeInsets.only(
                      top: 16.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        
                      ]),
                ),
              );
              widgetlist.add(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Safety Level',
                            style: TextStyle(height: 1, fontSize: 20)),
                        Center(child: fixedStar(snapshot.data[0]['safety'], Colors.amber)),
                        Text('${snapshot.data[0]["safety"]}',
                            style: TextStyle(height: 1, fontSize: 15)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Overall Experience',
                            style: TextStyle(height: 1, fontSize: 20)),
                        Center(child: fixedStar(snapshot.data[0]['overall'], Colors.lightBlue)),
                        Text('${snapshot.data[0]["overall"]}',
                            style: TextStyle(height: 1, fontSize: 15)),
                      ],
                    ),
                  ],
                ),
              );

              widgetlist.add(
                new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              );

              for (int i = 0; i < snapshot.data.length; i = i + 1) {
                /*
                widgetlist.add(
                  new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                );
                */
                widgetlist.add(
                  Card(
                    margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if(open == i) {
                            open = -1;
                          }
                          else {
                            open = i;
                          }
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: CircleAvatar(
                                //TODO: fill this with default profile image
                              ),
                            ),
                            Expanded(
                              flex: 11,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${snapshot.data[i]['username']}",
                                        style: TextStyle(height: 1, fontSize: 20, fontWeight: FontWeight.bold)
                                      ),
                                      Text(
                                        "${timeago.format(DateTime.parse(snapshot.data[i]['date']))}"
                                      )
                                    ]
                                  ),
                                  Text(
                                    "${snapshot.data[i]['content']}",
                                    style: TextStyle(height: 1, fontSize: 15))
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon (
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Text (
                                        "${snapshot.data[i]['safety']}",
                                        style: TextStyle(height: 1, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon (
                                        Icons.star,
                                        color: Colors.lightBlue,
                                      ),
                                      Text (
                                        "${snapshot.data[i]['overall']}",
                                        style: TextStyle(height: 1, fontSize: 12),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
                String reviewer = snapshot.data[i]['username'];
                widgetlist.add(
                  open == i ?
                  FutureBuilder<List<dynamic>>(
                    future: getComments(reviewer, widget.selectedPlaceName),
                    builder:
                      (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData) {
                          return Column (
                            children: snapshot.data.map<Widget>( (comment) => 
                            
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.0+12.0, 8.0+12.0, 16.0+12.0, 8.0+12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: CircleAvatar(
                                      //TODO: fill this with default profile image
                                    ),
                                  ),
                                  Expanded(
                                    flex: 12,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${comment['username']}",
                                          style: TextStyle(height: 1, fontSize: 20, fontWeight: FontWeight.bold)),
                                        Text(
                                          "${comment['content']}",
                                          style: TextStyle(height: 1, fontSize: 15))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(),
                                  )
                                ],
                              )
                            )
                            ).toList()
                            +
                            <Widget> [
                              Padding(
                                padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                                child: TextFormField(
                                  controller: controller,
                                  decoration: new InputDecoration(
                                    labelText: "Comment",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(10.0),
                                      borderSide: new BorderSide(
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.send),
                                      onPressed: () async {
                                        
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Center(child: CircularProgressIndicator());
                                          },
                                        );
                                        String content = controller.text;
                                        final tmp = ReviewService().addComment (
                                          reviewer,
                                          widget.selectedPlaceName,
                                          widget.username,
                                          content,
                                        );
                                        setState(() {
                                          controller.clear();
                                        });
                                        await tmp;
                                        Navigator.pop(context);
                                      },
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                  validator: (text) {
                                    if(text.length == 0) {
                                      return "Comment can't be empty.";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              )
                            ]
                          );
                        }
                        else {
                          return Center(
                            child: CircularProgressIndicator()
                          );
                        }
                      }
                  )
                  :
                  Container()
                );
                /*
                widgetlist.add(
                  Row(
                    children: [
                      Icon(Icons.account_box),
                      Column(children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                                '${snapshot.data[i]['username']}                               ',
                                style: TextStyle(height: 3, fontSize: 20)),
                          ),
                        ),
                        Text(
                            "${snapshot.data[i]['content']}                         ",
                            style: TextStyle(height: 1, fontSize: 15))
                      ])
                    ],
                  ),
                );
                widgetlist.add(
                  new Padding(
                    padding: EdgeInsets.only(
                        top: 16.0, left: 20.0, right: 20.0, bottom: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Safety',
                              style: TextStyle(height: 1, fontSize: 20)),
                          Text('Overall',
                              style: TextStyle(height: 1, fontSize: 20)),
                        ]),
                  ),
                );
                widgetlist.add(
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(child: fixedStar(snapshot.data[i]['safety'], Colors.amber)),
                      Center(child: fixedStar(snapshot.data[i]['overall'], Colors.lightBlue)),
                    ],
                  ),
                );
                */
              }
              return ListView(
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
            } else if (snapshot.data.length == 0) {
              return ListView(
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 1.0),
                      child: SizedBox(
                        height: 200,
                        child: Image.network(
                            buildPhotoURL(widget.selectedPlacePicture),
                            height: 200,
                            fit: BoxFit.fill),
                      )),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 16.0, left: 20.0, right: 20.0),
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
                      Center(child: fixedStar(3, Colors.amber)),
                      Center(child: fixedStar(3, Colors.lightBlue)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.account_box),
                      Column(children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                                'Anonymous                                          ',
                                style: TextStyle(height: 3, fontSize: 20)),
                          ),
                        ),
                        Text(
                            "People can't help taking off their masks while eating.",
                            style: TextStyle(height: 1, fontSize: 15))
                      ])
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(child: fixedStar(2, Colors.amber)),
                      Center(child: fixedStar(3, Colors.lightBlue)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.account_box),
                      Column(children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                                'Will kenny                                           ',
                                style: TextStyle(height: 3, fontSize: 20)),
                          ),
                        ),
                        Text(
                            'Safe, since people are not allowed to sit face to face.',
                            style: TextStyle(height: 1, fontSize: 15))
                      ])
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(child: fixedStar(3, Colors.amber)),
                      Center(child: fixedStar(3, Colors.lightBlue)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.account_box),
                      Column(children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                                '    Harry Kim                                           ',
                                style: TextStyle(height: 3, fontSize: 20)),
                          ),
                        ),
                        Text('This place is very clean and neat!',
                            style: TextStyle(height: 1, fontSize: 15))
                      ])
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(child: fixedStar(4, Colors.amber)),
                      Center(child: fixedStar(3, Colors.lightBlue)),
                    ],
                  ),
                ],
              );
              // return ListView(
              //   children: [
              //     Text(
              //         "No Reviews available...",
              //         style: TextStyle(height: 1, fontSize: 25)),
              //   ],
              // );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }

  Future<List<dynamic>> getComments(String username, String place) async {
    final response = await ReviewService().getComments(username, place);
    print("Comments: $response for $username, $place");
    return response.data['comments'];
  }

  Future<List<dynamic>> getPlaceInfos(String place) async {
    final response = await ReviewService().getReviewsByPlace(place);
    // TODO: Add OVerall Return future
    final overall = await ReviewService().averageOverall(place);
    print("[All Reviews]Received response is: ${response} for place: $place");
    return response.data['reviews'];
  }

}

