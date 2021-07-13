import 'package:doarun/screens/home/layouts/mobile.dart';
import 'package:doarun/screens/home/layouts/web.dart';
import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/group_states.dart';
import 'package:doarun/style/color.dart';
import 'package:doarun/utils/database/api.dart';
import 'package:doarun/utils/dynamic_link.dart';
import 'package:doarun/widgets_common/profile_picture.dart';
import 'package:doarun/widgets_default/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
                  body: !kIsWeb ||
                          MediaQuery.of(context).size.width <
                              MediaQuery.of(context).size.height
                      ? HomeMobileLayout()
                      : HomeWebLayout(),
                ));
          else
            return DoarunLoading();
        });
  }

  AppBar getHomeAppBar() {
    return AppBar(
      backgroundColor: mainColor,
      elevation: 0.0,
      toolbarHeight: 75,
      leading: Container(),
      actions: [
        Container(width: 12),
        SvgPicture.asset(
          "assets/doarun-long.svg",
          fit: BoxFit.contain,
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
