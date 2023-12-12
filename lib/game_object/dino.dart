import 'dart:developer';
import 'dart:ui';
import 'package:run_dino_run/const.dart';
import 'package:run_dino_run/painter/game_painter.dart';

import '../utility/math.dart';

class Dino  {
  double x;
  double y;
  bool shouldJump = false;

  Dino({required this.x, required this.y});

  double v = 0;
  double acc = -0.00;
  up() {
    y += v;
    v += acc;
  }

  void jump() {
    if (shouldJump) {
      v = 7.0;
      acc = -0.29;
    }
  }

  bool isGround() {
    //log("$y");
    if (y > 0) {
      return false;
    }
    //log("$y");
    return true;
  }

  void updateDino() {
    up();
    if (isGround()) {
      shouldJump = true;
      v = 0.0;
    } else {
      shouldJump = false;
    }

  }
}
