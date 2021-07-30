import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';

class EntityLastRun extends GetxController {
  String ownerName = "";
  String polyline = "";
  double distance = 0.0;

  EntityLastRun();

  EntityLastRun.fromJson(Map<String, dynamic> data, {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "ownerName": this.ownerName,
      "polyline": this.polyline,
      "distance": this.distance,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.ownerName = data["ownerName"];
    this.polyline = data["polyline"];
    this.distance = data["distance"];
    return true;
  }
}
