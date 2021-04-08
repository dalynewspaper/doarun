import 'package:doarun/screens/home/home.dart';
import 'package:doarun/screens/onboarding/onboarding.dart';
import 'package:doarun/states/app_states.dart';
import 'package:doarun/states/onboarding_states.dart';
import 'package:doarun/utils/svg_loader.dart';
import 'package:doarun/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Redirections extends StatefulWidget {
  @override
  _Redirections createState() => _Redirections();
}

class _Redirections extends State<Redirections> {
  final AppStates appStates = Get.find();
  final OnboardingStates onboardingStates = Get.find();
  Future<bool> _future;

  Future<bool> loader() async {
    if (!appStates.loaded) await appStates.initApp();
    await assetsLoader.loadSVGs();
    return true;
  }

  @override
  void initState() {
    _future = loader();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData)
            return Obx(() => _RedirectionFlow(
                onboardingStep: onboardingStates.onboardingStep.value));
          else
            return Loading();
        });
  }
}

class _RedirectionFlow extends StatelessWidget {
  final int onboardingStep;

  _RedirectionFlow({@required this.onboardingStep});

  @override
  Widget build(BuildContext context) {
    switch (onboardingStep) {
      case (ID_ONBOARDING_STEP_AUTH):
        return Onboarding();
      default:
        return Home();
    }
  }
}
