import 'package:doarun/screens/home/widgets/group_selector.dart';
import 'package:doarun/screens/home/widgets/latest_run.dart';
import 'package:doarun/screens/home/widgets/ranking.dart';
import 'package:doarun/states/group_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeMobileLayout extends StatelessWidget {
  final GroupStates groupStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        GroupSelector(),
        SizedBox(height: 30),
        Obx(() => Ranking(group: groupStates.group.value)),
        SizedBox(height: 35),
        Obx(
          () => groupStates.group.value.lastRun.polyline.isNotEmpty
              ? LatestRun(group: groupStates.group.value)
              : Container(),
        )
      ],
    );
  }
}
