import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/group_states.dart';
import 'package:doarun/style/color.dart';
import 'package:doarun/style/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GroupSelector extends StatelessWidget {
  final GroupStates groupStates = Get.find();
  final AccountStates accountStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 5),
              Obx(() => DropdownButton<String>(
                    value: groupStates.group.value.name,
                    icon: const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.black,
                    ),
                    underline: Container(),
                    iconSize: 35,
                    style: textStyleH2,
                    onChanged: (String newValue) async {
                      groupStates.group.value = groupStates.groupsOwned
                          .where((element) => element.name == newValue)
                          .first;
                      groupStates.updateLatestRun(accountStates.account);
                    },
                    items: groupStates.groupsOwned
                        .map((e) => e.name)
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              Spacer(),
              Text(groupStates.group.value.targetKm.toString() + " KM",
                  style: textStyleKMNumber),
              Container(width: 10),
              SvgPicture.asset(
                "assets/target.svg",
                height: 30,
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 3,
            color: accentColor,
          ),
        ],
      ),
    );
  }
}
