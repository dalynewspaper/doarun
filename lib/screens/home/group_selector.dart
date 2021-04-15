import 'package:doarun/style/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: DropdownButton<String>(
        value: "Grandpal",
        icon: const Icon(
          Icons.arrow_drop_down_sharp,
          color: Colors.black,
        ),
        underline: Container(),
        iconSize: 35,
        style: textStyleH2,
        onChanged: (String newValue) {},
        items: <String>['Grandpal', 'Group 2', 'Group 3']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
