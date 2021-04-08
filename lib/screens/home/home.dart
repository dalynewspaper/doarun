import 'package:doarun/widgets/profile_picture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          appBar: getHomeAppBar(),
          body: ListView(
            shrinkWrap: true,
            children: [],
          )),
    );
  }

  AppBar getHomeAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: [
        Container(width: 12),
        Container(
          height: 50,
          width: 50,
          child: SvgPicture.asset(
            "assets/doarun.svg",
            fit: BoxFit.contain,
          ),
        ),
        Expanded(child: Container()),
        ProfilePicture(
          height: 50,
          width: 50,
        ),
        Container(width: 12),
      ],
    );
  }
}
