import 'package:doarun/states/app_states.dart';
import 'package:doarun/states/onboarding_states.dart';
import 'package:get/get.dart';

class StatesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AppStates>(AppStates(), permanent: true);
    Get.put<OnboardingStates>(OnboardingStates(), permanent: true);
  }
}
