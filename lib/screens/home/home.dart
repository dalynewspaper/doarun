import 'package:doarun/screens/home/group_selector.dart';
import 'package:doarun/screens/home/ranking.dart';
import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/group_states.dart';
import 'package:doarun/utils/database/api.dart';
import 'package:doarun/utils/dynamic_link.dart';
import 'package:doarun/widgets_common/profile_picture.dart';
import 'package:doarun/widgets_default/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'latest_run.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  final AccountStates accountStates = Get.find();
  final GroupStates groupStates = Get.find();
  Future _future;

  Future<bool> _futureFunction() async {
    final Map refreshTokenResponse = await API.extern.strava
        .getAccessToken(accountStates.account.refreshToken);
    accountStates.account.refreshToken = refreshTokenResponse["refresh_token"];
    final String accessToken = refreshTokenResponse["access_token"];
    await accountStates.getNewTotalDistance(accessToken);
    if (!kIsWeb) await dynamicLink.handleDynamicLinks();
    await accountStates.updateLatestRun(accessToken);
    groupStates.updateLatestRun(accountStates.account);
    return true;
  }

  @override
  void initState() {
    _future = _futureFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData)
            return WillPopScope(
              onWillPop: () async {
                return true;
              },
              child: Scaffold(
                  appBar: getHomeAppBar(),
                  body: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        GroupSelector(),
                        SizedBox(height: 30),
                        Obx(() => Ranking(group: groupStates.group.value)),
                        SizedBox(height: 35),
                        Obx(
                          () =>
                              groupStates.group.value.lastRunPolyline.isNotEmpty
                                  ? LatestRun(group: groupStates.group.value)
                                  : Container(),
                        )
                      ],
                    ),
                  )),
            );
          else
            return DoarunLoading();
        });
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
          pictureUrl: accountStates.account.pictureUrl.value,
        ),
        Container(width: 12),
      ],
    );
  }
}
