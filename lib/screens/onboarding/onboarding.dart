import 'package:doarun/states/onboarding_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/onboarding_auth.dart';

class Onboarding extends StatelessWidget {
  final OnboardingStates onboardingStates = Get.find();
  final List<Widget> onboardingSteps = [
    OnboardingAuth(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return (await _previousOnboardingStep());
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child:
              Obx(() => onboardingSteps[onboardingStates.onboardingStep.value]),
        ),
      ),
    );
  }

  Future<bool> _previousOnboardingStep() async {
    return true;
  }
}
