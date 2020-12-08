//! This file stores constant values shared between files
//!
//! authors @rooknpown, @kalo, @castlecowrice

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

String lat = "36.37379078760264";
String lng = "127.35905994710093";

String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=${photoReference}&key=AIzaSyDqOOHRnNiYaCweRNtiXVQswGAb1Pz88Yc";
}





