import 'dart:developer';
import 'package:run_dino_run/const.dart';
import 'package:run_dino_run/painter/game_painter.dart';

import '../utility/math.dart';

class Dino extends GamePainter{

   double x;
   double y;
  Dino({ required this.x,required this.y});
   double v = 0;
  double acc = -0.00;
  up(double height){
    y += v;
    v += acc;
  }

  void jump(){
    v = 5.0;
    acc = -0.09;
  }

  bool isGround(){
   // log("$y == ${canvasSize.height - groundBottomMargin}");
      if(abs(y) == canvasSize.height - groundBottomMargin)return true;
      return false;
  }
  void updateDino(){
     up(1);
     setDinoPosition(x, y);
     //log(" -- ${isGround()}");
  }
}