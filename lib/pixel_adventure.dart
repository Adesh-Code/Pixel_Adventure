import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';

import 'actors/player.dart';
import 'levels/level.dart';
import 'utils/Functions.dart';
import 'utils/size_config.dart';
import 'utils/styles.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  late CameraComponent _camera;
  late JoystickComponent joystick;

  final Player player = Player(character: PlayerCosmetics.pink);

  @override
  FutureOr<void> onLoad() async {
    // Add images in cache
    await images.loadAllImages();

    final world = Level(levelName: 'Level-01', player: player);

    _camera = CameraComponent.withFixedResolution(
        width: 640, height: 360, world: world)
      ..priority = 1;

    _camera.viewfinder.anchor = Anchor.topLeft;

    addAll([_camera, world]);

    platformSpecificAction(action: addHUDButton);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    platformSpecificAction(action: updateHUDButton);
    super.update(dt);
  }

  @override
  Color backgroundColor() => const Color(0xFF211F30);

  String getSize() {
    if (SizeConfig.largeDevice) {
      return '4x';
    }
    if (SizeConfig.mediumDevice) {
      return '2x';
    }
    if (SizeConfig.smallDevice) {
      return '1x';
    }
    return '2x';
  }

  void addHUDButton() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/${getSize()}/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/${getSize()}/Joystick.png'),
        ),
      ),
      priority: 99,
      margin: Styles.marginJoystick,
    );

    add(joystick);
  }

  void updateHUDButton() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.playerDirection = PlayerDirection.left;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.playerDirection = PlayerDirection.right;
        break;
      default:
        player.playerDirection = PlayerDirection.none;
        break;
    }
  }
}
