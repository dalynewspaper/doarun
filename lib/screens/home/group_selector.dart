import 'package:doarun/states/group_states.dart';
import 'package:doarun/style/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GroupSelector extends StatelessWidget {
  final GroupStates groupStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/grandpal-logo.svg",
            height: 30,
          ),
          Container(width: 10),
          Obx(() => DropdownButton<String>(
                value: groupStates.group.value.name.value,
                icon: const Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Colors.black,
                ),
                underline: Container(),
                iconSize: 35,
                style: textStyleH2,
                onChanged: (String newValue) {
                  groupStates.readGroup(newValue);
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
