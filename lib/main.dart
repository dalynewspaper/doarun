import 'package:doarun/redirections.dart';
import 'package:doarun/screens/home/profile.dart';
import 'package:doarun/states/states_binding.dart';
import 'package:doarun/urls.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
                child: Redirections()),
            binding: StatesBinding()),
        GetPage(
          name: URL_PROFILE,
          page: () => Profile(),
        ),
//        GetPage(name: URL_GROCERY_LIST_OPTION, page: () => GroceryListOption()),
      ],
    );
  }
}
