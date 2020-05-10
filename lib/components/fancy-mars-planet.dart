import 'package:flame/sprite.dart';
import 'planet.dart';
import 'package:spaceX/space-x.dart';
import 'dart:ui';

class FancyMarsPlanet extends Planet {
  double get speed => game.tileSize * 1.5;
  FancyMarsPlanet(SpaceX game, double x, double y) : super(game) {
    flyingSprite = List();
    flyingSprite.add(Sprite('planets/planet_2.png'));
    flyingSprite.add(Sprite('planets/planet_2.png'));
    deadSprite = Sprite('planets/planet_2.png');
    planetRect = Rect.fromLTWH(x, y, game.tileSize * 4.5, game.tileSize * 4.5);
  }
}
