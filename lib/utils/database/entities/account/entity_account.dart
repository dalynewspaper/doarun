import 'dart:convert';
import 'dart:core';

import 'package:doarun/states/account_states.dart';
import 'package:get/get.dart';

class EntityAccount extends GetxController {
  String uid;
  RxString name = "".obs;
  RxString pictureUrl = "".obs;
  double totalDistance = 0.0;
  RxInt onboardingStep = ID_ONBOARDING_STEP_AUTH.obs;
  String refreshToken = "";
  int stravaId = -1;

  //last run
  String lastRunPolyline = "";
  int lastRunTimestamp = 0;
  double lastRunDistance = 0.0;

  EntityAccount();

  EntityAccount.fromJson(Map<String, dynamic> data, {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "name": this.name.value,
      "pictureUrl": this.pictureUrl.value,
      "totalDistance": this.totalDistance,
      "onboardingStep": this.onboardingStep.value,
      "refreshToken": this.refreshToken,
      "stravaId": this.stravaId,
      "lastRunPolyline": this.lastRunPolyline,
      "lastRunTimestamp": this.lastRunTimestamp,
      "lastRunDistance": this.lastRunDistance,
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
    this.totalDistance = data["totalDistance"].toDouble();
    this.onboardingStep.value = data["onboardingStep"];
    this.refreshToken = data["refreshToken"];
    this.stravaId = data["stravaId"];
    this.lastRunPolyline = data["lastRunPolyline"];
    this.lastRunTimestamp = data["lastRunTimestamp"];
    this.lastRunDistance = data["lastRunDistance"];
    return true;
  }
}
