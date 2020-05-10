import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:spaceX/space-x.dart';
import 'package:spaceX/view.dart';

class StartButton {
  final SpaceX game;
  Rect rect;
  Sprite sprite;
  StartButton(this.game) {
    resize();
    sprite = Sprite('ui/start-button.png');
  }
  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }

  void update(double t) {}
  void onTapDown() {
    game.activeView = View.playing;
    game.spawner.start();
  }

  void resize() {
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      (game.screenSize.height * .75) - (game.tileSize * 1.5),
      game.tileSize * 6,
      game.tileSize * 3,
    );
  }
}
