import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/app_states.dart';
import 'package:doarun/style/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingStravaConnection extends StatelessWidget {
  final AppStates appStates = Get.find();
  final AccountStates accountStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/doarun.svg",
          height: 100,
        ),
        Expanded(child: Container()),
        Text(
          "You are joining the following running group",
          style: textStyleH2,
        ),
        Expanded(child: Container()),
        Text(
          "...",
          style: textStyleH2,
        ),
        Expanded(child: Container()),
        GestureDetector(
          onTap: () => _stravaConnect(),
          child: Container(
            width: 150,
            height: 60,
            decoration: BoxDecoration(color: Colors.orange),
            child: Text("Connect with Strava"),
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
