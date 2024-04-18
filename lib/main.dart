import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'pixel_adventure.dart';
import 'utils/size_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  PixelAdventure game = PixelAdventure();

  runApp(
    Builder(builder: (context) {
      SizeConfig.init(context);
      return GameWidget(game: kDebugMode ? PixelAdventure() : game);
    }),
  );
}
