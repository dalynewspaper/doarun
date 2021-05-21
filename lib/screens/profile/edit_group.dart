import 'package:auto_size_text/auto_size_text.dart';
import 'package:doarun/states/account_states.dart';
import 'package:doarun/states/group_states.dart';
import 'package:doarun/style/color.dart';
import 'package:doarun/style/input.dart';
import 'package:doarun/style/text.dart';
import 'package:doarun/utils/database/entities/account/entity_account.dart';
import 'package:doarun/widgets/loading.dart';
import 'package:doarun/widgets/profile_picture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditGroup();
}

class _EditGroup extends State<EditGroup> {
  final GroupStates groupStates = Get.find();
  final AccountStates accountStates = Get.find();
  Future _futureMembers;

  @override
  void initState() {
    _futureMembers = groupStates.readAllAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: () async {
              await groupStates.updateGroup();
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: mainColor,
            ),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2.0, color: mainColor)),
            child: Center(
                child: Text(
              groupStates.group.value.icon.value,
              style: TextStyle(fontSize: 30),
            )),
          ),
          SizedBox(height: 35),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              child: StandardInput(
                  errorStr: null,
                  textInputType: TextInputType.name,
                  value: groupStates.group.value.name.value,
                  onChanged: (String value) {
                    groupStates.group.value.name.value = value;
                  },
                  hintText: "Group name",
                  isCenter: true
              ),
            ),
          ),
          SizedBox(height: 45),
          Container(
            color: mainColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 20.0, bottom: 20.0),
              child: Text(
                "Running goal",
                style: textStyleGroupsTitle,
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: StandardInput(
                errorStr: null,
                textInputType: TextInputType.number,
                value: groupStates.group.value.targetKm.value.toString(),
                onChanged: (String value) {
                  if (value.isNotEmpty)
                    try {
                      groupStates.group.value.targetKm.value =
                          double.parse(value);
                    } catch (e) {
                      if (!Get.isSnackbarOpen)
                        Get.snackbar(
                            "Format error", "Please use only numbers and '.'");
                    }
                },
                hintText: "Group name"),
          ),
          SizedBox(height: 15),
          Container(
            color: mainColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 20.0, bottom: 20.0),
              child: Text(
                "Members",
                style: textStyleGroupsTitle,
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder(
                future: _futureMembers,
                builder: (BuildContext context, data) {
                  if (data.hasError) print(data.error);
                  if (data.hasData)
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: groupStates.groupAccounts.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Row(
                            children: [
                              ProfilePicture(
                                  height: 50, width: 50, pictureUrl: groupStates.groupAccounts[i].pictureUrl.value),
                              SizedBox(width: 35),
                              Container(
                                  child: AutoSizeText(
                                      groupStates.groupAccounts[i].name.value,
                                      maxLines: 1,
                                      style: textStyleNames
                                  )
                              ),
                              Spacer(),
                              accountStates.account.uid ==
                                          groupStates.group.value.owner &&
                                      accountStates.account.uid !=
                                          groupStates.groupAccounts[i].uid
                                  ? GestureDetector(
                                      onTap: () => showPopUpComingSoon(
                                          context,
                                          groupStates.groupAccounts[i]),
                                      child: Icon(Icons.close),
                                    )
                                  : Container()
                            ],
                          );
                        });
                  else
                    return Loading();
                }),
          ),
          Container(height: 20),
        ],
      ),
    );
  }

  void showPopUpComingSoon(BuildContext context, EntityAccount account) async {
    await Get.dialog(AlertDialog(
      title: AutoSizeText(
        "Are you sure to remove " +
            account.name.value +
            " from the running group ?",
        style: textStyleH1,
        textAlign: TextAlign.center,
      ),
      content: Row(
        children: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("No"),
          ),
          Spacer(),
          OutlinedButton(
            onPressed: () {
              groupStates.groupAccounts.removeWhere(
                  (EntityAccount element) => element.uid == account.uid);
              groupStates.group.value.accounts
                  .removeWhere((element) => element == account.uid);
              Navigator.pop(context);
            },
            child: Text("Yes"),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
    ));
  }
}
