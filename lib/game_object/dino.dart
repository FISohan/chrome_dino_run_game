import 'dart:developer';
import 'package:run_dino_run/const.dart';
import 'package:run_dino_run/painter/game_painter.dart';

import '../utility/math.dart';

class Dino extends GamePainter{

   double x;
   double y;
  Dino({ required this.x,required this.y});
   double v = 7;
  double acc = -0.04;
  up(double height){
    y += v;
    v += acc;
  }


  bool isGround(){
    log("$y == ${canvasSize.height - groundBottomMargin}");
      if(abs(y) == canvasSize.height - groundBottomMargin)return true;
      return false;
  }
  void updateDino(){
     up(1);
     setDinoPosition(x, y);
     if(isGround()){
       v = 0;
       acc = 0;
     }
     //log(" -- ${isGround()}");
  }
}