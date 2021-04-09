import 'package:doarun/style/color.dart';
import 'package:doarun/style/text.dart';
import 'package:doarun/widgets/profile_picture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ranking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("This week", style: textStyleH1),
        Container(height: 10),
        _Board(members: ["Brian", "JisJoe", "Cédric", "Jeffson", "Mark"]),
        Container(height: 30),
        _AddMemberButton(),
      ],
    );
  }
}

class _Board extends StatelessWidget {
  final List members;

  _Board({@required this.members});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: members.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 25,
                      child: Text((index + 1).toString() + ".",
                          style: textStyleH1Accent)),
                  ProfilePicture(height: 50, width: 50),
                  Container(width: 50, child: Text(members[index])),
                  Container(width: 75, child: Text("12.5 km")),
                ],
              ),
            ],
          );
        });
  }
}

class _AddMemberButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Text("Add members", style: textStyleH2),
          Container(width: 10),
          Icon(Icons.person_add, color: mainColor),
        ],
      ),
    );
  }
}
