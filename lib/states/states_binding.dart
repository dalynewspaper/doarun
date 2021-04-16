import 'package:doarun/states/app_states.dart';
import 'package:get/get.dart';

import 'account_states.dart';

class StatesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AppStates>(AppStates(), permanent: true);
    Get.put<AccountStates>(AccountStates(), permanent: true);
  }
}
