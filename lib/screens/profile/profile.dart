import 'package:auto_size_text/auto_size_text.dart';
import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/group_states.dart';
import 'package:doarun/style/color.dart';
import 'package:doarun/style/text.dart';
import 'package:doarun/urls.dart';
import 'package:doarun/widgets_common/profile_picture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  final AccountStates accountStates = Get.find();
  final GroupStates groupStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(URL_HOME);
        return true;
      },
      child: Scaffold(
          appBar: getHomeAppBar(),
          body: Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
            child: Column(
              children: [
                ProfilePicture(
                    height: 75,
                    width: 75,
                    pictureUrl: accountStates.account.pictureUrl.value),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                  child: Center(
                      child: AutoSizeText(
                          accountStates.account.name.value.toUpperCase(),
                          style: textStyleUserName)),
                ),
                SizedBox(height: 50),
                Container(
                  color: mainColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 20.0, bottom: 20.0),
                    child: Row(
                      children: [
                        Text("My running groups".toUpperCase(),
                            style: textStyleGroupsTitle),
                        SizedBox(width: 20),
                        CircleAvatar(
                          backgroundColor: accentColor,
                          radius: 13,
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 19,
                              icon: Icon(Icons.add),
                              color: Colors.white,
                              onPressed: () {
                                Get.toNamed(URL_GROUP_CREATION);
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: groupStates.groupsOwned.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OutlinedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          onPressed: () {
                            groupStates.group.value =
                                groupStates.groupsOwned[index];
                            Get.toNamed(URL_GROUP_EDITION);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                AutoSizeText(
                                    groupStates.groupsOwned[index].name +
                                        " - " +
                                        groupStates.groupsOwned[index].targetKm
                                            .toString() +
                                        "km",
                                    style: textStyleGroups),
                                Spacer(),
                                AutoSizeText(
                                    groupStates.groupsOwned[index].icon.value)
                              ],
                            ),
                          ));
                    }),
                Spacer(),
                Center(
                    child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainColor),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 4.0, right: 10.0, bottom: 4.0),
                    child: FittedBox(
                      child: Text(
                        "Logout".toUpperCase(),
                        style: textStyleButton,
                      ),
                    ),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    "Version 0.1",
                    style: textStyleTradeMark,
                  )),
                ),
              ],
            ),
          )),
    );
  }

  AppBar getHomeAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      title: GestureDetector(
        onTap: () => Get.toNamed(URL_HOME),
        child: SvgPicture.asset(
          "assets/doarun.svg",
          fit: BoxFit.contain,
          height: 50,
        ),
      ),
    );
  }
}
