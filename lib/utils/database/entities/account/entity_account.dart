import 'dart:convert';
import 'dart:core';

import 'package:doarun/states/account_states.dart';
import 'package:get/get.dart';

class EntityAccount extends GetxController {
  String uid;
  RxString name = "".obs;
  RxString pictureUrl = "".obs;
  RxInt onboardingStep = ID_ONBOARDING_STEP_AUTH.obs;
  String refreshToken = "";
  int stravaId = -1;
  double weeklyDistance = 0.0;

  EntityAccount();

  EntityAccount.fromJson(Map<String, dynamic> data, {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "name": this.name.value,
      "pictureUrl": this.pictureUrl.value,
      "totalDistance": this.weeklyDistance,
      "onboardingStep": this.onboardingStep.value,
      "refreshToken": this.refreshToken,
      "stravaId": this.stravaId,
      "weeklyDistance": this.weeklyDistance,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.uid = key;
    this.name.value = data["name"];
    this.pictureUrl.value = data["pictureUrl"];
    this.onboardingStep.value = data["onboardingStep"];
    this.refreshToken = data["refreshToken"];
    this.stravaId = data["stravaId"];
    this.weeklyDistance = data["weeklyDistance"].toDouble();
    return true;
  }
}
