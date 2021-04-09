import 'package:doarun/states/onboarding_states.dart';
import 'package:doarun/style/color.dart';
import 'package:doarun/style/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingAuth extends StatelessWidget {
  final OnboardingStates onboardingStates = Get.find();

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
          "Description",
          style: textStyleH2,
        ),
        Expanded(child: Container()),
        Container(
          height: 250,
          child: Lottie.asset('assets/run-man-run.json',
              fit: BoxFit.contain, repeat: true),
        ),
        SvgPicture.asset("assets/ground.svg"),
        Expanded(child: Container()),
        TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0))),
                backgroundColor: MaterialStateProperty.all<Color>(mainColor)),
            onPressed: () => onSignIn(),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 50.0, right: 50, top: 10, bottom: 10),
              child: Text("Sign-in with google", style: textStyleButton),
            ))
      ],
    );
  }

  void onSignIn() {
    onboardingStates.onboardingStep.value += 1;
  }
}
