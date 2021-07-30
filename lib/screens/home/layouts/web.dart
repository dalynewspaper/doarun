import 'package:doarun/screens/home/widgets/group_selector.dart';
import 'package:doarun/screens/home/widgets/latest_run.dart';
import 'package:doarun/screens/home/widgets/ranking.dart';
import 'package:doarun/states/group_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeWebLayout extends StatelessWidget {
  final GroupStates groupStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          GroupSelector(),
          SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Obx(() => Ranking(group: groupStates.group.value))),
              Expanded(
                child: Obx(
                  () => groupStates.group.value.lastRun.polyline.isNotEmpty
                      ? LatestRun(group: groupStates.group.value)
                      : Container(),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
