import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/app_states.dart';
import 'package:doarun/states/group_states.dart';
import 'package:doarun/style/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnboardingStravaConnection extends StatelessWidget {
  final AppStates appStates = Get.find();
  final AccountStates accountStates = Get.find();
  final GroupStates groupStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/doarun.svg",
          height: 50,
        ),
        Expanded(child: Container()),
        SvgPicture.asset(
          "assets/road-loop.svg",
          height: 130,
        ),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            "You are joining the following running group",
            textAlign: TextAlign.center,
            style: textStyleH1Grey,
          ),
        ),
        Expanded(child: Container()),
        Text(
          groupStates.group.name +
              " - " +
              groupStates.group.targetKm.value.round().toString() + " km",
          style: textStyleH2,
        ),
        Expanded(child: Container()),
        GestureDetector(
          onTap: () => _stravaConnect(),
          child: SvgPicture.asset(
              "assets/strava-btn.svg",
              width: MediaQuery.of(context).size.width * 0.6
          ),
        )
      ],
    );
  }

  _stravaConnect() async {
    /*
    final response = await client
        .post(Uri.parse("https://www.strava.com/oauth/authorize"), headers: {
          "client_id": "",
    });
    print(response.body);*/
  }
}
