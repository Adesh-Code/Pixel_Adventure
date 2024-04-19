import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';

import '../pixel_adventure.dart';

enum PlayerDirection { left, right, none }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler {
  final PlayerCosmetics character;

  late final SpriteAnimation idleAnimations;
  late final SpriteAnimation runningAnimations;
  late final SpriteAnimation jumpAnimations;
  late final SpriteAnimation doubleJumpAnimations;
  late final SpriteAnimation wallJumpAnimations;
  late final SpriteAnimation fallAnimations;
  late final SpriteAnimation hitAnimations;

  final double stepTime = 0.05;
  final Vector2 playerSize = Vector2.all(32);

  PlayerDirection playerDirection = PlayerDirection.none;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isFacingRight = true;

  Player({this.character = PlayerCosmetics.mask});

  @override
  FutureOr<void> onLoad() async {
    _loadAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    return super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final bool isLeftKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyA) ||
            keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final bool isRightKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyD) ||
            keysPressed.contains(LogicalKeyboardKey.arrowRight);

    if (isLeftKeyPressed && isRightKeyPressed) {
      playerDirection = PlayerDirection.none;
    } else if (isLeftKeyPressed) {
      playerDirection = PlayerDirection.left;
    } else if (isRightKeyPressed) {
      playerDirection = PlayerDirection.right;
    } else {
      playerDirection = PlayerDirection.none;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAnimations() {
    idleAnimations = _getAnimationData(state: PlayerState.idle);
    runningAnimations =
        _getAnimationData(state: PlayerState.running, totalFrames: 12);
    jumpAnimations = _getAnimationData(state: PlayerState.jump, totalFrames: 1);
    doubleJumpAnimations =
        _getAnimationData(state: PlayerState.doubleJump, totalFrames: 6);
    wallJumpAnimations =
        _getAnimationData(state: PlayerState.wallJump, totalFrames: 5);
    fallAnimations = _getAnimationData(state: PlayerState.fall, totalFrames: 1);
    hitAnimations = _getAnimationData(state: PlayerState.hit, totalFrames: 7);

    animations = {
      PlayerState.idle: idleAnimations,
      PlayerState.running: runningAnimations,
      PlayerState.jump: jumpAnimations,
      PlayerState.doubleJump: doubleJumpAnimations,
      PlayerState.wallJump: wallJumpAnimations,
      PlayerState.fall: fallAnimations,
      PlayerState.hit: hitAnimations,
    };

    // set current animation cycle
    current = PlayerState.idle;
  }

  SpriteAnimation _getAnimationData(
      {required PlayerState state, int totalFrames = 11}) {
    return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache(
            'Main Characters/${character.value}/${state.value} (32x32).png'),
        SpriteAnimationData.sequenced(
            amount: totalFrames, stepTime: stepTime, textureSize: playerSize));
  }

  void _updatePlayerMovement(double dt) {
    double directionX = 0.0;
    switch (playerDirection) {
      case PlayerDirection.left:
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        directionX -= moveSpeed;
        current = PlayerState.running;
      case PlayerDirection.right:
        if (isFacingRight == false) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        directionX += moveSpeed;
        current = PlayerState.running;
      case PlayerDirection.none:
        current = PlayerState.idle;
        break;
    }

    velocity = Vector2(directionX, 0);
    position += velocity * dt;
  }
}

class PlayerCosmetics {
  final String value;
  const PlayerCosmetics._(this.value);

  static const frog = PlayerCosmetics._('Ninja Frog');
  static const mask = PlayerCosmetics._('Mask Dude');
  static const pink = PlayerCosmetics._('Pink Man');
  static const amongus = PlayerCosmetics._('Virtual Guy');
}

class PlayerState {
  final String value;
  const PlayerState._(this.value);

  static const idle = PlayerState._('Idle');
  static const running = PlayerState._('Run');
  static const jump = PlayerState._('Jump');
  static const doubleJump = PlayerState._('Double Jump');
  static const wallJump = PlayerState._('Wall Jump');
  static const fall = PlayerState._('Fall');
  static const hit = PlayerState._('Hit');
}
