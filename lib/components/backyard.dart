import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:spaceX/space-x.dart';

class Backyard {
  final SpaceX game;
  Sprite bgSprite;
  Rect bgRect;

  Backyard(this.game) {
    bgSprite = Sprite('bg/game_bg.png');
    bgRect = Rect.fromLTWH(0, game.screenSize.height - (game.tileSize * 23),
        game.tileSize * 9, game.tileSize * 23);
  }
  void render(Canvas canvas) {
    bgSprite.renderRect(canvas, bgRect);
  }

  void update(double t) {}
}
