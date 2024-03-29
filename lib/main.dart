import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'pixel_adventure.dart';
import 'utils/size_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.device.fullScreen();
  Flame.device.setLandscape();
  PixelAdventure game = PixelAdventure();

  runApp(
    Builder(builder: (context) {
      SizeConfig.init(context);
      return GameWidget(game: kDebugMode ? PixelAdventure() : game);
    }),
  );
}
