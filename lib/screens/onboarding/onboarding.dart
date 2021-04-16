import 'package:doarun/screens/onboarding/strava_connection/onboarding_strava_connection.dart';
import 'package:doarun/states/account_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/onboarding_auth.dart';
import 'group_creation/dart/onboarding_group_creation.dart';

class Onboarding extends StatelessWidget {
  final AccountStates accountStates = Get.find();
  final List<Widget> onboardingSteps = [
    OnboardingAuth(),
    //OnboardingGroupCreation()
    OnboardingStravaConnection()
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
          child: Obx(() =>
              onboardingSteps[accountStates.account.onboardingStep.value]),
        ),
      ),
    );
  }

  Future<bool> _previousOnboardingStep() async {
    return true;
  }
}
