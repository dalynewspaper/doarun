import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/app_states.dart';
import 'package:doarun/style/color.dart';
import 'package:doarun/style/text.dart';
import 'package:doarun/utils/auth.dart';
import 'package:doarun/utils/local_storage/consts.dart';
import 'package:doarun/utils/local_storage/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingAuth extends StatelessWidget {
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
            onPressed: () async {
              await _signIn(await authService.googleSignIn());
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 50.0, right: 50, top: 10, bottom: 10),
              child: Text("Sign-in with google", style: textStyleStandardWhite),
            ))
      ],
    );
  }

  Future<void> _signIn(User firebaseUser) async {
    if (firebaseUser == null)
      Get.snackbar("Error", "something went wrong");
    else {
      appStates.loading.value = true;
      if (await accountStates.doesAccountExists(firebaseUser.uid)) {
        await accountStates.readAccount(firebaseUser.uid);
      } else {
        accountStates.account.uid = authService.auth.currentUser.uid;
        accountStates.account.name.value = firebaseUser.displayName;
        accountStates.account.pictureUrl.value = firebaseUser.photoURL;
        await accountStates.createAccount();
        accountStates.account.onboardingStep.value += 1;
        accountStates.updateAccount();
      }
      localStorage.setStringData(
          SHARED_PREF_KEY_ACCOUNT_ID, accountStates.account.uid);
      appStates.loading.value = false;
    }
  }
}
