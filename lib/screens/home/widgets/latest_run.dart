import 'package:doarun/style/color.dart';
import 'package:doarun/style/text.dart';
import 'package:doarun/utils/database/entities/group/entity_group.dart';
import 'package:doarun/utils/polyline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LatestRun extends StatelessWidget {
  final EntityGroup group;

  final PolylinePoints polylinePoints = PolylinePoints();
  final Set<Polyline> polylines = {};

  LatestRun({@required this.group});

  @override
  Widget build(BuildContext context) {
    final PolylineId id = PolylineId("poly");
    polylines.add(Polyline(
        width: 3,
        color: mainColor,
        polylineId: id,
        points: convertToLatLng(
            polylinePoints.decodePolyline(group.lastRun.polyline))));
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: 150,
        color: mainColor,
        padding: EdgeInsets.all(8.0),
        child: Text("Latest runs".toUpperCase(), style: textStyleTitle),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              group.lastRun.ownerName +
                  " put in " +
                  group.lastRun.distance.toString() +
                  "km",
              style: textStyleH2.copyWith(color: mainColor),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: kIsWeb ? 500 : MediaQuery.of(context).size.width,
              height: kIsWeb ? 500 : MediaQuery.of(context).size.width,
              child: GoogleMap(
                  gestureRecognizers: Set()
                    ..add(Factory<PanGestureRecognizer>(
                        () => PanGestureRecognizer())),
                  initialCameraPosition: CameraPosition(
                      target: _getAverageLatLng(polylines.first.points),
                      zoom: 15.0),
                  mapType: MapType.terrain,
                  polylines: polylines,
                  compassEnabled: false,
                  tiltGesturesEnabled: false),
            ),
          ],
        ),
      )
    ]);
  }

  LatLng _getAverageLatLng(List<LatLng> points) {
    final List<double> lats = [];
    points.forEach((element) {
      lats.add(element.latitude);
    });
    final List<double> lons = [];
    points.forEach((element) {
      lons.add(element.longitude);
    });
    return LatLng(lats.reduce((a, b) => a + b) / lats.length,
        lons.reduce((a, b) => a + b) / lons.length);
  }
}
