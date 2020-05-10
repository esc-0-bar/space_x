import 'package:flame/sprite.dart';
import 'package:spaceX/components/planet.dart';
import 'package:spaceX/space-x.dart';
import 'dart:ui';

class FibuPlanet extends Planet {
  double get speed => game.tileSize * 5;
  FibuPlanet(SpaceX game, double x, double y) : super(game) {
    flyingSprite = List();
    flyingSprite.add(Sprite('planets/planet_1.png'));
    flyingSprite.add(Sprite('planets/planet_1.png'));
    deadSprite = Sprite('planets/planet_1.png');
    planetRect = Rect.fromLTWH(x, y, game.tileSize * 2.5, game.tileSize * 2.5);
  }
}
