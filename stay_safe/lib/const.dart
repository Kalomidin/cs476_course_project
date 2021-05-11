//! This file stores constant values shared between files
//!
//! authors @rooknpown, @kalo, @castlecowrice

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

String lat = "36.37379078760264";
String lng = "127.35905994710093";

String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=${photoReference}&key=AIzaSyCzWl1iTZWgXLzzBSg6PIFalxYDjYBaN4U";
}

RatingBar fixedStar(double rating, Color color) {
  return RatingBar.builder(
          initialRating: rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          ignoreGestures: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemSize: 25.0,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: color,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
  );
}



