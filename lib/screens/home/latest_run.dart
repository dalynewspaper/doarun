import 'package:doarun/states/group_states.dart';
import 'package:doarun/style/color.dart';
import 'package:doarun/style/text.dart';
import 'package:doarun/utils/polyline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LatestRun extends StatelessWidget {
  final GroupStates groupStates = Get.find();
  final Set<Polyline> polylines = {};

  @override
  Widget build(BuildContext context) {
    PolylineId id = PolylineId("poly");
    polylines.add(Polyline(
        width: 3,
        color: mainColor,
        polylineId: id,
        points: convertToLatLng(
            decodePoly(groupStates.group.value.lastRunPolyline))));
    return groupStates.group.value.lastRunPolyline.isNotEmpty
        ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                color: mainColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 5.0, 15.0, 5.0),
                  child:
                      Text("Latest runs".toUpperCase(), style: textStyleTitle),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    groupStates.group.value.lastRunner +
                        "put in " +
                        (groupStates.group.value.lastRunDistance / 1000)
                            .toString() +
                        "km",
                    style: textStyleH2.copyWith(color: mainColor),
                  ),
                  SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      gestureRecognizers: Set()
                        ..add(Factory<PanGestureRecognizer>(
                            () => PanGestureRecognizer())),
                      initialCameraPosition: CameraPosition(
                          target: polylines.first.points.first, zoom: 20.0),
                      mapType: MapType.hybrid,
                      polylines: polylines,
                      onMapCreated: (GoogleMapController controller) {},
                    ),
                  ),
                ],
              ),
            )
          ])
        : Container();
  }
}
