import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/app_states.dart';
import 'package:doarun/style/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnboardingStravaConnection extends StatelessWidget {
  final AppStates appStates = Get.find();
  final AccountStates accountStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/doarun.svg",
          height: 50,
        ),
        Container(height: 70),
        SvgPicture.asset(
          "assets/road-loop.svg",
          height: 130,
        ),
        Container(height: 100),
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
          "...",
          style: textStyleH2,
        ),
        Expanded(child: Container()),
        TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.orange)),
            onPressed: () => _stravaConnect(),
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0, top: 10.0, right: 40.0, bottom: 10.0),
              child: Text("Connect with Strava",
                  maxLines: 1, style: textStyleBoldWhite),
            )
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
