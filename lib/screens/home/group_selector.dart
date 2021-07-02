import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/group_states.dart';
import 'package:doarun/style/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupSelector extends StatelessWidget {
  final GroupStates groupStates = Get.find();
  final AccountStates accountStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        children: [
          Container(width: 0),
          Obx(() => DropdownButton<String>(
                value: groupStates.group.value.name.value,
                icon: const Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Colors.black,
                ),
                underline: Container(),
                iconSize: 35,
                style: textStyleH2,
                onChanged: (String newValue) async {
                  groupStates.group.value = groupStates.groupsOwned
                      .where((element) => element.name.value == newValue)
                      .first;
                  groupStates.updateLatestRun(accountStates.account);
                },
                items: groupStates.groupsOwned
                    .map((e) => e.name.value)
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
        ],
      ),
    );
  }
}
