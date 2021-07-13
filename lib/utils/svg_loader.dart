import 'package:flutter_svg/flutter_svg.dart';

class AssetsLoader {
  static final List<String> svgPaths = [
    "assets/doarun.svg",
    "assets/ground.svg",
    "assets/doarun-long.svg",
    "assets/target.svg",
    "assets/road-loop.svg",
  ];

  Future<void> loadSVGs() async {
    for (int i = 0; i < svgPaths.length; i++)
      await precachePicture(
          ExactAssetPicture(SvgPicture.svgStringDecoder, svgPaths[i]), null);
  }
}

final AssetsLoader assetsLoader = AssetsLoader();
