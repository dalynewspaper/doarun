import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/app_states.dart';
import 'package:doarun/style/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingGroupCreation extends StatelessWidget {
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
        Container(
          height: 250,
          child: Lottie.asset('assets/run-man-run.json',
              fit: BoxFit.contain, repeat: true),
        ),
        Expanded(child: Container()),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "My running group will be called...",
            style: textStyleButtonStandard,
          ),
        ),
        TextField()
      ],
    );
  }
}
