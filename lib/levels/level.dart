import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../actors/player.dart';

class Level extends World {
  late TiledComponent level;
  late Player player;

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('Level-01.tmx', Vector2.all(16));
    player = Player(character: PlayerCosmetics.mask);

    final ObjectGroup? spawnPointLayer =
        level.tileMap.getLayer<ObjectGroup>('SpawnPoints');
    for (final spawnPoint in spawnPointLayer!.objects) {
      switch (spawnPoint.class_) {
        case 'Player':
          break;
        default:
      }
    }

    addAll([level, player]);

    return super.onLoad();
  }
}
