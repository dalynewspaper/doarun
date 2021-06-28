import 'package:doarun/screens/profile/create_group.dart';
import 'package:doarun/screens/profile/edit_group.dart';
import 'package:doarun/screens/profile/profile.dart';
import 'package:doarun/states/states_binding.dart';
import 'package:doarun/urls.dart';
import 'package:doarun/wizard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'flavors.dart';

void appInitialisation() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: F.title,
      defaultTransition: Transition.fade,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: "/",
            page: () => AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  systemNavigationBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                  systemNavigationBarIconBrightness: Brightness.dark,
                ),
                child: Wizard()),
            binding: StatesBinding()),
        GetPage(
          name: URL_PROFILE,
          page: () => Profile(),
        ),
        GetPage(
          name: URL_GROUP_CREATION,
          page: () => CreateGroup(),
        ),
        GetPage(
          name: URL_GROUP_EDITION,
          page: () => EditGroup(),
        ),
      ],
    );
  }
}
