import 'package:doarun/states/account_states.dart';
import 'package:doarun/utils/local_storage/consts.dart';
import 'package:doarun/utils/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AppStates extends GetxController {
  Future<void> initApp() async {
    final AccountStates accountStates = Get.find();
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
    if (userToken.isNotEmpty) {
      await accountStates.readAccount(userToken);
    }
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  RxBool loading = false.obs;
  RxBool uploadingProfilePicture = false.obs;
  bool loaded = false;
}
