import 'package:doarun/screens/home/home.dart';
import 'package:doarun/screens/onboarding/onboarding.dart';
import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/app_states.dart';
import 'package:doarun/utils/svg_loader.dart';
import 'package:doarun/widgets_default/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wizard extends StatefulWidget {
  @override
  _Wizard createState() => _Wizard();
}

class _Wizard extends State<Wizard> {
  final AppStates appStates = Get.find();
  final AccountStates accountStates = Get.find();
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
                  isAppLoading: appStates.loading.value,
                  onboardingStep: accountStates.account.onboardingStep.value,
                ));
          else
            return DoarunLoading();
        });
  }
}

class _RedirectionFlow extends StatelessWidget {
  final bool isAppLoading;
  final int onboardingStep;

  _RedirectionFlow(
      {@required this.isAppLoading, @required this.onboardingStep});

  @override
  Widget build(BuildContext context) {
    if (isAppLoading)
      return DoarunLoading();
    else if (onboardingStep == null ||
        onboardingStep <= ID_ONBOARDING_STEP_STRAVA)
      return Onboarding();
    else
      return Home();
  }
}
