import 'package:auto_size_text/auto_size_text.dart';
import 'package:doarun/style/color.dart';
import 'package:doarun/style/text.dart';
import 'package:doarun/widgets/profile_picture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../style/color.dart';

class Ranking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _makeHeaderRanking(context),
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
                  Container(width: 50, child: AutoSizeText(members[index], maxLines: 1, style: textStyleNames)),
                  Container(width: 75, child: Text("12.5 km")),
                ],
              ),
            ],
          );
        });
  }
}

_makeTitle() {
  return Container(
    color: mainColor,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 25.0, 15.0),
      child: Text("This week", style: textStyleTitle),
    ),
  );
}

_makeHeaderRanking(context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        _makeTitle(),
        Positioned(
            right: 40,
            child: Text("Total distance", style: textStyleDistance)
        )
      ],
    ),
  );
}

class _AddMemberButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(Icons.person_add, size: 40, color: Colors.white),
              )
          ),
        ],
      ),
    );
  }
}
