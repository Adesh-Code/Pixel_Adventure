import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'levels/level.dart';

class PixelAdventure extends FlameGame {
  late CameraComponent _camera;

  @override
  final world = Level();

  @override
  FutureOr<void> onLoad() {
    _camera = CameraComponent.withFixedResolution(
        width: 640, height: 360, world: world);

    _camera.viewfinder.anchor = Anchor.topLeft;

    addAll([_camera, world]);
    return super.onLoad();
  }

  @override
  Color backgroundColor() => const Color(0xFF211F30);
}
