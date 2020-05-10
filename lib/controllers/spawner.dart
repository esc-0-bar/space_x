import 'package:spaceX/space-x.dart';
import 'package:spaceX/components/planet.dart';

class FlySpawner {
  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 250;
  final int intervalChange = 3;
  final int maxFliesOnScreen = 1;
  int currentInterval;
  int nextSpawn;
  final SpaceX game;

  FlySpawner(this.game) {
    start();
    game.spawnPlanet();
  }
  void start() {
    killAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAll() {
    game.planets.forEach((Planet fly) => fly.isDead = true);
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    int livingFlies = 0;
    game.planets.forEach((Planet fly) {
      if (!fly.isDead) livingFlies += 1;
    });

    if (nowTimestamp >= nextSpawn && livingFlies < maxFliesOnScreen) {
      game.spawnPlanet();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }
}
