import 'package:doarun/style/color.dart';
import 'package:doarun/style/text.dart';
import 'package:flutter/cupertino.dart';

class LatestRun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          color: mainColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 15.0, 5.0),
            child: Text("Latest runs".toUpperCase(), style: textStyleTitle),
          )),
    ]);
  }
}
