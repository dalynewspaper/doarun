import 'package:doarun/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePicture extends StatelessWidget {
  final double height;
  final double width;
  final String pictureUrl;

  ProfilePicture(
      {@required this.height, @required this.width, @required this.pictureUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(URL_PROFILE);
      },
      child: Container(
        height: this.height,
        width: this.width,
        decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(pictureUrl)),
            shape: BoxShape.circle,
            border: Border.all(width: 1.0, color: Colors.white)),
      ),
    );
  }
}
