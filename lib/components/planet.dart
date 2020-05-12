import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:spaceX/space-x.dart';

class Planet {
  double x;
  double y;
  double width;
  double height;
  Rect planetRect;
  bool isDead = false;
  bool isOffScreen = false;
  final SpaceX game;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  double get speed => game.tileSize * 3;
  Offset targetLocation;

  Planet(this.game) {
    setTargetLocation();
  }
  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(c, planetRect.inflate(2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()]
          .renderRect(c, planetRect.inflate(2));
    }
  }

  void update(double t) {
    if (isDead) {
      planetRect = planetRect.translate(0, game.tileSize * 12 * t);
      if (planetRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    } else {
      flyingSpriteIndex += 30 * t;
      while (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }
      double stepDistance = speed * t;
      Offset toTarget =
          targetLocation - Offset(planetRect.left, planetRect.top);
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget =
            Offset.fromDirection(toTarget.direction, stepDistance);
        planetRect = planetRect.shift(stepToTarget);
      } else {
        planetRect = planetRect.shift(toTarget);
        setTargetLocation();
      }
    }
  }

  void onTapDown() {
    isDead = true;
  }

  void setTargetLocation() {
    double x = game.random.nextDouble() *
        (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.screenSize.width - (game.tileSize * 7.5);
    targetLocation = Offset(x, y);
  }
}
