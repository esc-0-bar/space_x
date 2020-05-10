import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:spaceX/space-x.dart';
import 'package:spaceX/view.dart';

class HelpButton {
  final SpaceX game;
  Rect rect;
  Sprite sprite;
  HelpButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * .25,
      game.screenSize.height - (game.tileSize * 1.25),
      game.tileSize,
      game.tileSize,
    );
    sprite = Sprite('ui/icon-help.png');
  }
  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }

  void onTapDown() {
    game.activeView = View.help;
  }
}
