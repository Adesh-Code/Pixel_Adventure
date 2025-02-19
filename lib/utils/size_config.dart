import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;

  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double paddingTop;
  static late double paddingBottom;

  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static late bool smallDevice;
  static late bool mediumDevice;
  static late bool largeDevice;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    paddingTop = _mediaQueryData.padding.top;
    paddingBottom = _mediaQueryData.padding.bottom;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    double safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    double safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    safeBlockHorizontal = (screenWidth - safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - safeAreaVertical) / 100;

    smallDevice = screenWidth <= 640;
    mediumDevice = 640 < screenWidth && screenWidth <= 1000;
    largeDevice = 1000 < screenWidth;
  }
}
