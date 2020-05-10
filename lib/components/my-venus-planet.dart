import 'package:flame/sprite.dart';
import 'planet.dart';
import 'dart:ui';
import 'package:spaceX/space-x.dart';

class MyVenusPlanet extends Planet {
  MyVenusPlanet(SpaceX game, double x, double y) : super(game) {
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('planets/planet_3.png'));
    flyingSprite.add(Sprite('planets/planet_3.png'));
    deadSprite = Sprite('planets/planet_3.png');
    planetRect = Rect.fromLTWH(x, y, game.tileSize * 3.5, game.tileSize * 3.5);
  }
}
