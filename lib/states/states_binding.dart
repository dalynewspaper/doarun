import 'package:doarun/states/app_states.dart';
import 'package:doarun/states/group_states.dart';
import 'package:doarun/states/onboarding_states.dart';
import 'package:get/get.dart';

import 'account_states.dart';

class StatesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AppStates>(AppStates(), permanent: true);
    Get.put<AccountStates>(AccountStates(), permanent: true);
    Get.put<GroupStates>(GroupStates(), permanent: true);
    Get.put<OnboardingStates>(OnboardingStates(), permanent: true);
  }
}
