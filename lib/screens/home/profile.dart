import 'package:auto_size_text/auto_size_text.dart';
import 'package:doarun/style/color.dart';
import 'package:doarun/style/text.dart';
import 'package:doarun/widgets/profile_picture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getHomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            ProfilePicture(height: 100, width: 100),
            _getUserInfos(),
            SizedBox(height: 50),
            _getRunningGroups(),
          ],
        ),
      )
    );
  }

  AppBar getHomeAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: Container(),
      title:
        Container(
          height: 50,
          width: 50,
          child: SvgPicture.asset(
            "assets/doarun.svg",
            fit: BoxFit.contain,
          ),
        ),
    );
  }

  _getUserInfos() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
          child: Center(
              child: AutoSizeText(
                  "Brian Daly".toUpperCase(),
                  style: textStyleUserName)
          ),
        ),
        RichText(
          text: TextSpan(
            // Note: Styles for TextSpans must be explicitly defined.
            // Child text spans will inherit styles from parent
            style: textStyleInfos,
            children: <TextSpan>[
              new TextSpan(text: 'Wallet   '),
              new TextSpan(text: '0.00 EUR', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    );
  }

  _getRunningGroups() {
    return Column(
      children: [
        Container(
          color: mainColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 20.0, bottom: 20.0),
            child: Row(
              children: [
                Text("My running groups".toUpperCase(), style: textStyleGroupsTitle),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                AutoSizeText("Grandpal - 10 km", style: textStyleGroups)
              ],
            ),
          ),
        )
      ],
    );
  }
}