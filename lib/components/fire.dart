import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:spaceX/space-x.dart';
import 'package:flutter/gestures.dart';
import 'package:spaceX/view.dart';

class Fire {
  final SpaceX game;
  Rect fireRect;
  Sprite sprite;
  double get speed => game.tileSize * 5;
  Offset targetLocation;
  bool fired = false;
  bool isOffScreen = false;
  bool isLost = false;
  double topPosition;
  Fire(this.game) {
    fireRect = Rect.fromLTWH(
        game.tileSize * 1,
        game.screenSize.height - (game.tileSize * 1.75),
        game.tileSize * .375,
        game.tileSize * 1.5);
    sprite = Sprite('ship/fire.png');
  }
  void render(Canvas canvas) {
    sprite.renderRect(canvas, fireRect);
  }

  void update(double t) {
    topPosition = fireRect.top;
    if (fired) {
      fireRect = fireRect.translate(0, -game.tileSize * 12 * t);
      if (fireRect.top < 0 && isLost == true) {
        game.activeView = View.lost;
        isLost = false;
      }
    }
    double stepDistance = speed * t;
    Offset toTarget = targetLocation == null
        ? Offset(fireRect.left, fireRect.top)
        : targetLocation - Offset(fireRect.left, fireRect.top);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget =
          Offset.fromDirection(toTarget.direction, stepDistance);
      fireRect = fireRect.shift(stepToTarget);
    } else {
      fireRect = fireRect.shift(toTarget);
    }
  }

  void setTargetLocation(TapDownDetails d) {
    targetLocation = Offset(
        d.globalPosition.dx, game.screenSize.height - (game.tileSize * 1.75));
  }

  void onTapDown() {
    fired = true;
  }
}
