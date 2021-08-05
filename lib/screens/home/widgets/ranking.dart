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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';

import '../../../style/color.dart';

class Ranking extends StatelessWidget {
  final EntityGroup group;
  final AccountStates accountStates = Get.find();
  final GroupStates groupStates = Get.find();

  Ranking({@required this.group});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: groupStates.readAllAccounts(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData)
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 130,
                  color: mainColor,
                  padding: EdgeInsets.all(8.0),
                  child: Text("This week", style: textStyleTitle),
                ),
                Container(height: 10),
                groupStates.groupAccounts
                        .where((element) => element.weeklyDistance??0 > 0)
                        .isEmpty
                    ? _NobodyRan()
                    : Container(),
                _Board(
                    members: groupStates.groupAccounts,
                    targetKm: group.targetKm),
                groupStates.groupAccounts.length <= 1
                    ? Center(
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
                      ))
                    : Container(),
                SizedBox(height: 30),
                _AddMemberButton(groupName: groupStates.group.value.name),
              ],
            );
          else
            return DoarunLoading();
        });
  }
}

class _Board extends StatelessWidget {
  final RxList<EntityAccount> members;
  final double targetKm;

  _Board({@required this.members, @required this.targetKm});

  @override
  Widget build(BuildContext context) {
    bool isTargetLineDrawn = false;
    members.sort((a, b) => b.weeklyDistance.compareTo(a.weeklyDistance));
    return ListView.builder(
        shrinkWrap: true,
        itemCount: members.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (!isTargetLineDrawn && members[index].weeklyDistance!=null?members[index].weeklyDistance < targetKm:false) {
            isTargetLineDrawn = true;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(targetKm.toString() + "KM TARGET",
                          style: textStyleTitleH2.copyWith(color: accentColor)),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: accentColor,
                        height: 3,
                      ),
                    ],
                  ),
                ),
                _MemberRow(position: index + 1, account: members[index])
              ],
            );
          } else
            return _MemberRow(
              position: index + 1,
              account: members[index],
            );
        });
  }
}

class _MemberRow extends StatelessWidget {
  final int position;
  final EntityAccount account;

  _MemberRow({@required this.position, @required this.account});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
              width: 50,
              child:
                  Text((position).toString() + ".", style: textStyleH1Accent)),
          ProfilePicture(
              height: 50, width: 50, pictureUrl: account.pictureUrl.value),
          SizedBox(width: 30),
          SizedBox(
            width: 75,
            child: AutoSizeText(account.name.value,
                maxLines: 1, style: textStyleNames),
          ),
          Text(account.weeklyDistance??0.toStringAsFixed(3) + "km"),
        ],
      ),
    );
  }
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
                child: Icon(Icons.person_add, size: 30, color: Colors.white),
              )),
        ],
      ),
    );
  }
}

class _NobodyRan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
