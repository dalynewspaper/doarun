import 'package:doarun/screens/home/group_selector.dart';
import 'package:doarun/screens/home/ranking.dart';
import 'package:doarun/widgets/profile_picture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'latest_run.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          appBar: getHomeAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                GroupSelector(),
                Container(height: 15),
                Ranking(),
                Container(height: 35),
                LatestRun(),
              ],
            ),
          )),
    );
  }

  AppBar getHomeAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: [
        Container(width: 12),
        Container(
          height: 50,
          width: 50,
          child: SvgPicture.asset(
            "assets/doarun.svg",
            fit: BoxFit.contain,
          ),
        ),
        Expanded(child: Container()),
        ProfilePicture(
          height: 50,
          width: 50,
        ),
        Container(width: 12),
      ],
    );
  }
}
