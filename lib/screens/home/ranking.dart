import 'package:auto_size_text/auto_size_text.dart';
import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/group_states.dart';
import 'package:doarun/style/color.dart';
import 'package:doarun/style/text.dart';
import 'package:doarun/utils/database/entities/account/entity_account.dart';
import 'package:doarun/utils/database/entities/group/entity_group.dart';
import 'package:doarun/utils/dynamic_link.dart';
import 'package:doarun/widgets_common/profile_picture.dart';
import 'package:doarun/widgets_default/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';

import '../../style/color.dart';

class Ranking extends StatelessWidget {
  final AccountStates accountStates = Get.find();
  final GroupStates groupStates = Get.find();
  final EntityGroup group;

  Ranking({@required this.group});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: groupStates.readAllAccounts(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData)
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _makeHeaderRanking(context),
                Container(height: 10),
                isNobody(groupStates.groupAccounts)
                    ? _getNobodyRan()
                    : Container(),
                _Board(members: groupStates.groupAccounts),
                groupStates.groupAccounts.length <= 1
                    ? _getInvite()
                    : Container(),
                SizedBox(height: 30),
                _AddMemberButton(groupName: groupStates.group.value.name),
              ],
            );
          else
            return DoarunLoading();
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

  Widget _getInvite() {
    return Center(
        child: Column(
      children: [
        SizedBox(height: 30),
        Lottie.asset("assets/runner.json",
            fit: BoxFit.contain, repeat: true, height: 200),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Looks like you are on your own in here. Invite some friends to join you !",
            style: textStyleKMNumber,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ));
  }
}

class _Board extends StatelessWidget {
  final RxList<EntityAccount> members;

  _Board({@required this.members});

  @override
  Widget build(BuildContext context) {
    members.sort((a, b) => b.totalDistance.compareTo(a.totalDistance));
    return ListView.builder(
        shrinkWrap: true,
        itemCount: members.length,
        itemBuilder: (context, index) {
          return _getList(index);
        });
  }

  Widget _getList(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              width: 25,
              child:
                  Text((index + 1).toString() + ".", style: textStyleH1Accent)),
          ProfilePicture(
              height: 50,
              width: 50,
              pictureUrl: members[index].pictureUrl.value),
          Container(
              width: 50,
              child: AutoSizeText(members[index].name.value,
                  maxLines: 1, style: textStyleNames)),
          Container(
              width: 75,
              child:
                  Text(members[index].totalDistance.toStringAsFixed(3) + "km")),
        ],
      ),
    );
  }
}

_makeTitle() {
  return Container(
    color: mainColor,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 5.0, 15.0, 5.0),
      child: Text("This week", style: textStyleTitle),
    ),
  );
}

_makeHeaderRanking(context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 25.0),
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
  final String groupName;

  _AddMemberButton({@required this.groupName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Share.share(await dynamicLink.createInvitationLink(groupName));
      },
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
