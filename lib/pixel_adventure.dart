import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'actors/player.dart';
import 'levels/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  late CameraComponent _camera;
  late JoystickComponent joystick;

  final Player player = Player(character: PlayerCosmetics.pink);

  void addJoystick() {
    joystick = JoystickComponent();
  }

  @override
  FutureOr<void> onLoad() async {
    // Add images in cache
    await images.loadAllImages();

    final world = Level(levelName: 'Level-01', player: player);

    _camera = CameraComponent.withFixedResolution(
        width: 640, height: 360, world: world);

    _camera.viewfinder.anchor = Anchor.topLeft;

    addAll([_camera, world]);

    addJoystick();

    return super.onLoad();
  }

  @override
  Color backgroundColor() => const Color(0xFF211F30);
}
