import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';

class EntityGroup extends GetxController {
  String name = "";
  RxString icon = "👟".obs;
  double targetKm = 10.0;
  String owner = "";
  List accounts = [];

  //last run
  String lastRunPolyline = "";
  String lastRunner = "";
  int lastRunTimestamp = 0;
  double lastRunDistance = 0.0;

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
      "lastRunPolyline": this.lastRunPolyline,
      "lastRunner": this.lastRunner,
      "lastRunTimestamp": this.lastRunTimestamp,
      "lastRunDistance": this.lastRunDistance,
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
    this.lastRunPolyline = data["lastRunPolyline"];
    this.lastRunner = data["lastRunner"];
    this.lastRunTimestamp = data["lastRunTimestamp"];
    this.lastRunDistance = data["lastRunDistance"];
    return true;
  }
}
