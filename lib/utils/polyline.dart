import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<LatLng> convertToLatLng(List<PointLatLng> points) {
  List<LatLng> result = <LatLng>[];
  for (int i = 0; i < points.length; i++)
    result.add(LatLng(points[i].latitude, points[i].longitude));
  return result;
}
