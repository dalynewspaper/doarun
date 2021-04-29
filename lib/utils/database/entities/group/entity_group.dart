import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';

class EntityGroup extends GetxController {
  RxString name = "".obs;
  RxString icon = "👟".obs;
  RxDouble targetKm = 0.0.obs;
  List accounts = [];

  EntityGroup();

  EntityGroup.fromJson(Map<String, dynamic> data, {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "icon": this.icon.value,
      "targetKm": this.targetKm.value,
      "accounts": this.accounts,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.name.value = key;
    this.icon.value = data["icon"];
    this.targetKm.value = data["targetKm"];
    this.accounts.assignAll(data["accounts"]);
    return true;
  }
}
