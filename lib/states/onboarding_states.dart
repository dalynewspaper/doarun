import 'package:get/get.dart';

class OnboardingStates extends GetxController {
  RxInt onboardingStep = ID_ONBOARDING_STEP_AUTH.obs;
}

const ID_ONBOARDING_STEP_AUTH = 0;
