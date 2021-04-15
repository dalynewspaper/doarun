import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';

class EntityAccount extends GetxController {
  String uid;
  RxString name = "".obs;
  RxString pictureUrl = "".obs;
  double totalDistance = 0.0;

  EntityAccount();

  EntityAccount.fromJson(Map<String, dynamic> data, {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "name": this.name.value,
      "pictureUrl": this.pictureUrl.value,
      "totalDistance": this.totalDistance,
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
    this.totalDistance = data["totalDistance"];
    return true;
  }
}
