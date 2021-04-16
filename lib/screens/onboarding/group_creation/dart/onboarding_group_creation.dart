import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/app_states.dart';
import 'package:doarun/states/group_states.dart';
import 'package:doarun/states/onboarding_states.dart';
import 'package:doarun/style/color.dart';
import 'package:doarun/style/input.dart';
import 'package:doarun/style/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingGroupCreation extends StatelessWidget {
  final AppStates appStates = Get.find();
  final AccountStates accountStates = Get.find();
  final GroupStates groupStates = Get.find();
  final OnboardingStates onboardingStates = Get.find();

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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "My running group will be called...",
            style: textStyleButtonBlack,
          ),
        ),
        Container(height: 20),
        Obx(() => StandardInput(
            errorStr: onboardingStates.isGroupNameFieldValid.value ? null : "",
            textInputType: TextInputType.name,
            onChanged: (String value) {
              onboardingStates.isGroupNameFieldValid.value = value.isNotEmpty;
              groupStates.group.name = value.trim();
            },
            hintText: "group name")),
        Container(height: 30),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Each week, our target will be to run...",
            style: textStyleButtonBlack,
          ),
        ),
        Container(height: 20),
        Obx(() => StandardInput(
            textInputType: TextInputType.number,
            errorStr: !onboardingStates.isKmTargetFieldValid.value ? "" : null,
            onChanged: (String value) {
              if (value.isNotEmpty)
                try {
                  groupStates.group.targetKm.value = double.parse(value);
                  onboardingStates.isKmTargetFieldValid.value = true;
                } catch (e) {
                  if (!Get.isSnackbarOpen)
                    Get.snackbar(
                        "Format error", "Please use only numbers and '.'");
                  onboardingStates.isKmTargetFieldValid.value = false;
                  print(e);
                }
            },
            hintText: "Type distance in km")),
        Container(height: 50),
        TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                backgroundColor: MaterialStateProperty.all<Color>(mainColor)),
            onPressed: () async {
              if (groupStates.group.name.isEmpty ||
                  groupStates.group.targetKm < 0.1) {
                if (!Get.isSnackbarOpen)
                  Get.snackbar("error", "Missing fields");
                onboardingStates.isGroupNameFieldValid.value =
                    groupStates.group.name.isNotEmpty;
                onboardingStates.isKmTargetFieldValid.value =
                    groupStates.group.targetKm.value > 0.1;
                print("1");
              } else if (await groupStates
                  .doesGroupExists(groupStates.group.name)) {
                print("2");
                if (!Get.isSnackbarOpen)
                  Get.snackbar("Sorry :(", "This group name is already taken!");
              } else {
                print("3");
                groupStates.group.accounts.add(accountStates.account.uid);
                await groupStates.createGroup();
                accountStates.account.onboardingStep.value += 1;
                accountStates.updateAccount();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Create running group".toUpperCase(),
                  maxLines: 1, style: textStyleStandardWhite),
            ))
      ],
    );
  }
}
