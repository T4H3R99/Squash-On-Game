import 'package:flutter/material.dart';
import 'package:squash/Screens/menu.dart';
import 'package:squash/Screens/score.dart';
import 'package:squash/Screens/settings.dart';
import 'package:squash/Screens/gameplay.dart';
import 'package:squash/Screens/splashscreen.dart';

class Routes {
  static const settings = 'settings';
  static const menu = 'menu';
  static const game = 'game';
  static const score = 'score';
  static const splash = 'splash';

  static Map<String, WidgetBuilder> routes() {
    return <String, WidgetBuilder>{
      menu: (context) => const MenuScreen(),
      settings: (context) => const SettingsScreen(),
      game: (context) => const GamePlay(),
      score: (context) => const ScoreScreen(),
      splash: (context) => const Splashscreen()
    };
  }
}
