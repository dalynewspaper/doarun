import 'package:doarun/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DoarunLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitDualRing(
          color: mainColor,
          size: 28.0,
          lineWidth: 3.0,
        ),
      ),
    );
  }
}
