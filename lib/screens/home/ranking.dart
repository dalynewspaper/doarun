import 'package:auto_size_text/auto_size_text.dart';
import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/group_states.dart';
import 'package:doarun/style/color.dart';
import 'package:doarun/style/text.dart';
import 'package:doarun/utils/database/entities/account/entity_account.dart';
import 'package:doarun/utils/database/entities/group/entity_group.dart';
import 'package:doarun/widgets/loading.dart';
import 'package:doarun/widgets/profile_picture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../style/color.dart';

class Ranking extends StatefulWidget {
  final EntityGroup group;

  Ranking({@required this.group});

  @override
  _Ranking createState() => _Ranking(group: group);
}

class _Ranking extends State<Ranking> {
  final AccountStates accountStates = Get.find();
  final GroupStates groupStates = Get.find();
  final EntityGroup group;
  Future futureGroupUsers;

  _Ranking({@required this.group});

  @override
  initState() {
    futureGroupUsers = groupStates.readAllAccounts(group.name.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureGroupUsers,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData)
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _makeHeaderRanking(context),
                Container(height: 10),
                isNobody(groupStates.groupAccounts) ? _getNobodyRan() : Container(),
                _Board(members: groupStates.groupAccounts),
                groupStates.groupAccounts.length <= 1 ? _getInvite() : Container(),
                Container(height: 30),
                _AddMemberButton(),
              ],
            );
          else
            return Loading();
        });
  }

  bool isNobody(List<EntityAccount> members) {
    bool ret = true;
    members.forEach((EntityAccount element) {
      if (element.totalDistance > 0) {
        ret = false;
        return;
      }
    });
    return ret;
  }

  _getNobodyRan() {
    return Center(
      child: Column(children: [
        Text(
          "😴",
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(height: 5),
        Text("Nobody has ran this week!", style: textStyleInfos),
        SizedBox(height: 30)
      ]),
    );
  }

  Column _getInvite() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          Container(
              width: 200,
              height: 200,
              child: Image.asset("assets/invite.png")),
          Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Looks like you are on your own in here. Invite some friends to join you !",
                  style: textStyleKMNumber,
                  textAlign: TextAlign.center,
                ),
              ))
        ]);
  }


}

class _Board extends StatelessWidget {
  final List<EntityAccount> members;

  _Board({@required this.members});

  @override
  Widget build(BuildContext context) {
    members.sort((a, b) => b.totalDistance.compareTo(a.totalDistance));
    return ListView.builder(
        shrinkWrap: true,
        itemCount: members.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              _getList(index),
            ],
          );
        });
  }

  Row _getList(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            width: 25,
            child:
                Text((index + 1).toString() + ".", style: textStyleH1Accent)),
        ProfilePicture(
            height: 50, width: 50, pictureUrl: members[index].pictureUrl.value),
        Container(
            width: 50,
            child: AutoSizeText(members[index].name.value,
                maxLines: 1, style: textStyleNames)),
        Container(
            width: 75,
            child: Text(members[index].totalDistance.toString() + "km")),
      ],
    );
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
            right: 40, child: Text("Total distance", style: textStyleDistance))
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
                  color: accentColor, borderRadius: BorderRadius.circular(40)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(Icons.person_add, size: 40, color: Colors.white),
              )),
        ],
      ),
    );
  }
}
