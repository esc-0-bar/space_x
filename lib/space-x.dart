import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:spaceX/views/lost-view.dart';
import 'components/planet.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'components/backyard.dart';
import 'components/my-venus-planet.dart';
import 'package:spaceX/components/fibu-planet.dart';
import 'package:spaceX/components/fancy-mars-planet.dart';
import 'view.dart';
import 'views/home-view.dart';
import 'components/start-button.dart';
import 'controllers/spawner.dart';
import 'components/credits-button.dart';
import 'components/help-button.dart';
import 'views/help-view.dart';
import 'views/credits-view.dart';
import 'components/ship.dart';
import 'components/fire.dart';

class SpaceX extends Game {
  Size screenSize;
  double tileSize;
  Random random;
  HelpButton helpButton;
  Backyard background;
  List<Planet> planets;
  StartButton startButton;
  CreditsButton creditsButton;
  FlySpawner spawner;
  HelpView helpView;
  CreditsView creditsView;
  View activeView = View.home;
  HomeView homeView;
  LostView lostView;
  Ship ship;
  Fire fire;
  bool didHitAFly = false;
  bool isHandled = false;
  SpaceX() {
    initialize();
  }
  void initialize() async {
    planets = List<Planet>();
    random = Random();
    resize(await Flame.util.initialDimensions());
    homeView = HomeView(this);
    background = Backyard(this);
    startButton = StartButton(this);
    lostView = LostView(this);
    spawner = FlySpawner(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
    helpView = HelpView(this);
    creditsView = CreditsView(this);
    ship = Ship(this);
    fire = Fire(this);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    super.resize(size);
  }

  void onTapDown(TapDownDetails d) {
    ship.setTargetLocation(d);
    fire.setTargetLocation(d);
    if (fire.fireRect.contains(d.globalPosition)) {
      fire.onTapDown();
    }
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        isHandled = true;
      }
    }

    if (!isHandled) {
      planets.forEach((Planet fly) {
        if (fly.planetRect.contains(d.globalPosition)) {
          fly.onTapDown();
          isHandled = true;
          didHitAFly = true;
        }
      });
      if (activeView == View.playing && !didHitAFly) {
        activeView = View.lost;
      }
    }
    // help button
    if (!isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }

// credits button
    if (!isHandled && creditsButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        creditsButton.onTapDown();
        isHandled = true;
      }
    }
    if (!isHandled) {
      if (activeView == View.help || activeView == View.credits) {
        activeView = View.home;
        isHandled = true;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    background.render(canvas);
    planets.forEach((Planet fly) => fly.render(canvas));
    if (activeView != View.home && activeView != View.lost) {
      fire.render(canvas);
      ship.render(canvas);
    }

    if (activeView == View.home) homeView.render(canvas);
    if (activeView == View.lost) lostView.render(canvas);
    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
      helpButton.render(canvas);
      creditsButton.render(canvas);
    }
    if (activeView == View.help) helpView.render(canvas);
    if (activeView == View.credits) creditsView.render(canvas);
  }

  @override
  void update(double t) {
    spawner.update(t);
    planets.forEach((Planet fly) => fly.update(t));
    planets.forEach((Planet fly) => fly.isOffScreen);
    ship.update(t);
    fire.update(t);
    planets.forEach((Planet fly) {
      if (fire.fireRect.top >= fly.planetRect.top - 75 &&
          fire.fireRect.top <= fly.planetRect.top + 75 &&
          fire.fireRect.left >= fly.planetRect.left - 15 &&
          fire.fireRect.left <= fly.planetRect.left + 35) {
        fly.onTapDown();
        isHandled = true;
        didHitAFly = true;
      }
    });
  }

  void spawnPlanet() {
    double x = screenSize.width - (tileSize * 7.5);
    double y = screenSize.width - (tileSize * 7.5);
    switch (random.nextInt(3)) {
      case 0:
        planets.add(MyVenusPlanet(this, x, y));
        break;
      case 1:
        planets.add(FancyMarsPlanet(this, x, y));
        break;
      case 2:
        planets.add(FibuPlanet(this, x, y));
        break;
    }
  }
}
