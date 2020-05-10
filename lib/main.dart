import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'space-x.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/flame.dart';

void main() {
  SpaceX game = SpaceX();
  runApp(game.widget);
  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientation(DeviceOrientation.portraitUp);
  Flame.images.loadAll(<String>[
    'bg/game_bg.png',
    'planets/planet_1.png',
    'planets/planet_2.png',
    'planets/planet_3.png',
    'ship/ship.png',
    'ship/fire.png',
    'bg/lose-splash.png',
    'branding/title.png',
    'ui/dialog-credits.png',
    'ui/dialog-help.png',
    'ui/icon-credits.png',
    'ui/icon-help.png',
    'ui/start-button.png',
  ]);
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}
