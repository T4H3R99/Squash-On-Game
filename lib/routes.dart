import 'package:flutter/material.dart';
import 'package:squash/gamelay.dart';
import 'package:squash/menu.dart';
import 'package:squash/score.dart';
import 'package:squash/settings.dart';
import 'package:squash/test.dart';

class Routes {
  static const settings = 'settings';
  static const menu = 'menu';
  static const game = 'game';
  static const score = 'score';

  static Map<String, WidgetBuilder> routes() {
    return <String, WidgetBuilder>{
      menu: (context) => MenuScreen(),
      settings: (context) => SettingsScreen(),
      game: (context) => Testgame(),
      score: (context) => ScoreScreen(),
    };
  }
}
