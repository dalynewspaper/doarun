import 'package:auto_size_text/auto_size_text.dart';
import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/group_states.dart';
import 'package:doarun/style/color.dart';
import 'package:doarun/style/input.dart';
import 'package:doarun/style/text.dart';
import 'package:doarun/utils/database/entities/account/entity_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditGroup extends StatelessWidget {
  final GroupStates groupStates = Get.find();
  final AccountStates accountStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: () async {
              await groupStates.updateGroup();
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: mainColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.0, color: mainColor)),
              child: Center(
                  child: Text(
                groupStates.group.value.icon.value,
                style: TextStyle(fontSize: 30),
              )),
            ),
            SizedBox(height: 35),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Running group name",
                style: textStyleButton,
              ),
            ),
            Container(height: 20),
            StandardInput(
                errorStr: null,
                textInputType: TextInputType.name,
                value: groupStates.group.value.name.value,
                onChanged: (String value) {
                  groupStates.group.value.name.value = value;
                },
                hintText: "Group name"),
            SizedBox(height: 35),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Running goal",
                style: textStyleButton,
              ),
            ),
            Container(height: 20),
            StandardInput(
                errorStr: null,
                textInputType: TextInputType.number,
                value: groupStates.group.value.targetKm.value.toString(),
                onChanged: (String value) {
                  if (value.isNotEmpty)
                    try {
                      groupStates.group.value.targetKm.value =
                          double.parse(value);
                    } catch (e) {
                      if (!Get.isSnackbarOpen)
                        Get.snackbar(
                            "Format error", "Please use only numbers and '.'");
                    }
                },
                hintText: "Group name"),
            SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  void showPopUpComingSoon(BuildContext context, EntityAccount account) async {
    await Get.dialog(AlertDialog(
      title: AutoSizeText(
        "Are you sure to remove " +
            account.name.value +
            " from the running group ?",
        style: textStyleH1,
        textAlign: TextAlign.center,
      ),
      content: Row(
        children: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("No"),
          ),
          Spacer(),
          OutlinedButton(
            onPressed: () {
              groupStates.groupAccounts.removeWhere(
                  (EntityAccount element) => element.uid == account.uid);
              groupStates.group.value.accounts
                  .removeWhere((element) => element == account.uid);
              Navigator.pop(context);
            },
            child: Text("Yes"),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
    ));
  }
}
