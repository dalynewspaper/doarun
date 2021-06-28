import 'package:doarun/states/group_states.dart';
import 'package:doarun/style/color.dart';
import 'package:doarun/style/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LatestRun extends StatelessWidget {
  final GroupStates groupStates = Get.find();

  @override
  Widget build(BuildContext context) {
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
                ],
              ),
            )
          ])
        : Container();
  }
}
