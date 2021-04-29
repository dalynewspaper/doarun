import 'dart:convert';

import 'package:doarun/utils/http.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart';

class ServiceStrava {
  final clientId = "65432";
  final clientSecret = "26c2e44b133cc407cafa410b35bb179bae2fa725";

  //methods
  Future<Map> auth() async {
    final Uri url = Uri.https('strava.com', '/oauth/mobile/authorize', {
      'response_type': 'code',
      'client_id': clientId,
      'redirect_uri': 'com.doarun://redirect/',
      'scope': 'activity:write,read',
    });
    final String code = Uri.parse(await FlutterWebAuth.authenticate(
            url: url.toString(), callbackUrlScheme: "com.doarun"))
        .queryParameters["code"];
    final Response response = await client
        .post(Uri.parse("https://www.strava.com/oauth/token"), body: {
      "client_id": clientId,
      "client_secret": clientSecret,
      "code": code,
      "grant_type": "authorization_code"
    });
    return json.decode(response.body);
  }
}