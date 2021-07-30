import 'dart:convert';
import 'dart:core';

import 'package:doarun/utils/database/entities/group/entity_latest_run.dart';
import 'package:get/get.dart';

class EntityGroup extends GetxController {
  String name = "";
  RxString icon = "👟".obs;
  double targetKm = 10.0;
  String owner = "";
  List accounts = [];

  EntityLastRun lastRun = EntityLastRun();

  EntityGroup();

  EntityGroup.fromJson(Map<String, dynamic> data, {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "icon": this.icon.value,
      "targetKm": this.targetKm,
      "owner": this.owner,
      "accounts": this.accounts,
      "lastRun": this.lastRun.toMap(),
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.name = key;
    this.icon.value = data["icon"];
    this.targetKm = data["targetKm"];
    this.owner = data["owner"];
    this.accounts.assignAll(data["accounts"]);
    this.lastRun = EntityLastRun.fromJson(data["lastRun"]);
    return true;
  }
}
