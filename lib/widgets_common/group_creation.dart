import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/group_states.dart';
import 'package:doarun/states/onboarding_states.dart';
import 'package:doarun/style/color.dart';
import 'package:doarun/style/text.dart';
import 'package:doarun/urls.dart';
import 'package:doarun/utils/database/entities/group/entity_group.dart';
import 'package:doarun/widgets_default/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class GroupCreation extends StatelessWidget {
  final AccountStates accountStates = Get.find();
  final GroupStates groupStates = Get.find();
  final OnboardingStates onboardingStates = Get.find();
  final bool isOnboarding;

  GroupCreation({@required this.isOnboarding});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SvgPicture.asset(
          "assets/doarun.svg",
          height: 50,
        ),
        Lottie.asset('assets/run-man-run.json', repeat: true, height: 200),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "My running group will be called...",
            style: textStyleButton,
          ),
        ),
        Container(height: 20),
        DoarunTextField(
            initialValue: groupStates.groupTmp.name,
            errorStr: onboardingStates.isGroupNameFieldValid.value ? null : "",
            textInputType: TextInputType.name,
            onChanged: (String value) {
              onboardingStates.isGroupNameFieldValid.value = value.isNotEmpty;
              groupStates.groupTmp.name = value.trim();
            },
            hintText: "Group Name"),
        Container(height: 30),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Each week, our target will be to run...",
            style: textStyleButton,
          ),
        ),
        Container(height: 20),
        DoarunTextField(
            initialValue: groupStates.groupTmp.targetKm.toString(),
            textInputType: TextInputType.number,
            errorStr: !onboardingStates.isKmTargetFieldValid.value ? "" : null,
            onChanged: (String value) {
              if (value.isNotEmpty)
                try {
                  groupStates.groupTmp.targetKm = double.parse(value);
                  onboardingStates.isKmTargetFieldValid.value = true;
                } catch (e) {
                  if (!Get.isSnackbarOpen)
                    Get.snackbar(
                        "Format error", "Please use only numbers and '.'");
                  onboardingStates.isKmTargetFieldValid.value = false;
                  print(e);
                }
            },
            hintText: "Type distance in km"),
        SizedBox(height: 50),
        TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                backgroundColor: MaterialStateProperty.all<Color>(mainColor)),
            onPressed: () async {
              await _createGroup();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
              child: Text("Create running group".toUpperCase(),
                  maxLines: 1, style: textStyleBoldWhite),
            ))
      ],
    );
  }

  Future<void> _createGroup() async {
    // checking fields
    if (groupStates.groupTmp.name.isEmpty ||
        groupStates.groupTmp.targetKm < 0.1) {
      if (!Get.isSnackbarOpen) Get.snackbar("error", "Missing fields");
      onboardingStates.isGroupNameFieldValid.value =
          groupStates.groupTmp.name.isNotEmpty;
      onboardingStates.isKmTargetFieldValid.value =
          groupStates.groupTmp.targetKm > 0.1;
      // checking if the name is already taken
    } else if (await groupStates.doesGroupExists(groupStates.groupTmp.name)) {
      if (!Get.isSnackbarOpen)
        Get.snackbar("Sorry :(", "This group name is already taken!");
      // group creation
    } else {
      groupStates.groupTmp.accounts.add(accountStates.account.uid);
      groupStates.groupTmp.owner = accountStates.account.uid;
      await groupStates.createGroup(groupStates.groupTmp);
      groupStates.group.value = groupStates.groupTmp;
      groupStates.groupTmp = EntityGroup();
      if (isOnboarding) accountStates.account.onboardingStep.value += 1;
      accountStates.updateAccount();
      if (!isOnboarding) {
        Get.toNamed(URL_PROFILE);
      }
    }
  }
}
