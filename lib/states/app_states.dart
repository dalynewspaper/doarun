import 'package:doarun/states/account_states.dart';
import 'package:doarun/utils/local_storage/consts.dart';
import 'package:doarun/utils/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'group_states.dart';

class AppStates extends GetxController {
  Future<void> initApp() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
    await localStorage.init();
    final String userToken =
        localStorage.getStringData(SHARED_PREF_KEY_ACCOUNT_ID);
    if (userToken.isNotEmpty) await readUserData(userToken);
    loaded = true;
  }

  Future<void> readUserData(String userToken) async {
    final AccountStates accountStates = Get.find();
    final GroupStates groupStates = Get.find();
    await accountStates.readAccount(userToken);
    await groupStates.readAllGroups(accountStates.account.uid);
  }

  RxBool loading = false.obs;
  RxBool uploadingProfilePicture = false.obs;
  bool loaded = false;
}
