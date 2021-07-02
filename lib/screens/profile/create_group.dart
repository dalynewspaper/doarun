import 'package:doarun/states/group_states.dart';
import 'package:doarun/style/color.dart';
import 'package:doarun/urls.dart';
import 'package:doarun/utils/database/entities/group/entity_group.dart';
import 'package:doarun/widgets_common/group_creation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateGroup();
}

class _CreateGroup extends State<CreateGroup> {
  final GroupStates groupStates = Get.find();
  final EntityGroup editedGroup = Get.arguments;

  @override
  void initState() {
    if (editedGroup != null) groupStates.group.value = editedGroup;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: mainColor, //change your color here
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              groupStates.group.value = groupStates.groupsOwned.first;
              Get.offNamed(URL_PROFILE);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GroupCreation(isOnboarding: false),
      ),
    );
  }
}
