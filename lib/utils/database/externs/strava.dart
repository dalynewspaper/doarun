import 'dart:convert';

import 'package:doarun/utils/http.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart';

class ServiceStrava {
  final clientId = "62285";
  final clientSecret = "604cd72fbccdf35aac78f60ff67d41389751dabc";

  //methods
  Future<Map> auth() async {
    final Uri url = Uri.https('strava.com', '/oauth/mobile/authorize', {
      'response_type': 'code',
      'client_id': clientId,
      'redirect_uri': 'com.doarun://redirect/',
      'scope': 'activity:read_all',
    });
    final String code = Uri.parse(await FlutterWebAuth.authenticate(
            url: url.toString(), callbackUrlScheme: "com.doarun"))
        .queryParameters["code"];
    final Response response = await client
        .post(Uri.parse("https://www.strava.com/oauth/token"), body: {
      "client_id": clientId,
      "client_secret": clientSecret,
      "code": code,
      "grant_type": "authorization_code",
    });
    return json.decode(response.body);
  }

  Future<Map> getAccessToken(String refreshToken) async {
    final Response response = await client
        .post(Uri.parse("https://www.strava.com/oauth/token"), body: {
      "client_id": clientId,
      "client_secret": clientSecret,
      "grant_type": "refresh_token",
      "refresh_token": refreshToken,
      "scope": "activity:read_all"
    });
    return json.decode(response.body);
  }

  Future<Map> getAthleteStats(int stravaId, String accessToken) async {
    final Response response = await client.get(
        Uri.parse("https://www.strava.com/api/v3/athletes/" +
            stravaId.toString() +
            "/stats"),
        headers: {"Authorization": "Bearer $accessToken"});
    return json.decode(response.body);
  }

  Future<Map> getAthleteLastActivity(
      int fromTimestamp, String accessToken) async {
    final Response activitiesResponse = await client.get(
        Uri.parse("https://www.strava.com/api/v3/athlete/activities?after=" +
            fromTimestamp.toString()),
        headers: {"Authorization": "Bearer $accessToken"});
    try {
      final List activities = json.decode(activitiesResponse.body);
      Map lastActivity = activities.first;
      activities.forEach((element) {
        if (DateTime.parse(element["start_date"])
            .isAfter(DateTime.parse(lastActivity["start_date"])))
          lastActivity = element;
      });
      print(lastActivity);
      return lastActivity;
    } catch (e) {
      return Map();
    }
  }
}
