import 'package:doarun/screens/onboarding/onboarding.dart';
import 'package:doarun/states/app_states.dart';
import 'package:doarun/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Redirections extends StatefulWidget {
  @override
  _Redirections createState() => _Redirections();
}

class _Redirections extends State<Redirections> {
  final AppStates appStates = Get.find();
  Future<bool> _future;

  Future<bool> loader() async {
    if (!appStates.loaded) await appStates.initApp();
    return true;
  }

  @override
  void initState() {
    _future = loader();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData)
            switch (true) {
              case (true):
                return Onboarding();
              default:
                return Loading();
            }
          else
            return Loading();
        });
  }
}
