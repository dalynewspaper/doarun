import 'package:doarun/style/color.dart';
import 'package:doarun/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfilePicture extends StatelessWidget {
  final double height;
  final double width;

  ProfilePicture({@required this.height, @required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(URL_PROFILE);
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1.0, color: mainColor)),
      ),
    );
  }
}
