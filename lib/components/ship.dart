import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:spaceX/space-x.dart';

class Ship {
  final SpaceX game;
  Rect shipRect;
  Sprite sprite;
  double get speed => game.tileSize * 5;
  Offset targetLocation;
  Ship(this.game) {
    shipRect = Rect.fromLTWH(
        game.tileSize * .25,
        game.screenSize.height - (game.tileSize * 1.75),
        game.tileSize * 1.25,
        game.tileSize * 1.5);
    sprite = Sprite('ship/ship.png');
  }
  void render(Canvas canvas) {
    sprite.renderRect(canvas, shipRect);
  }

  void update(double t) {
    double stepDistance = speed * t;
    Offset toTarget = targetLocation == null
        ? Offset(shipRect.left, shipRect.top)
        : targetLocation - Offset(shipRect.left, shipRect.top);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget =
          Offset.fromDirection(toTarget.direction, stepDistance);
      shipRect = shipRect.shift(stepToTarget);
    } else {
      shipRect = shipRect.shift(toTarget);
    }
  }

  void setTargetLocation(TapDownDetails d) {
    targetLocation = Offset(d.globalPosition.dx - 21,
        game.screenSize.height - 4 - (game.tileSize * 1.75));
  }
}
