import 'dart:developer';
import 'dart:ui';

class Obstacle {
  double x;
  double y;
  final double height;
  final double width;
  double v = 4.5;
  double a = 0.00001;
  bool isOutOfViewport = true;
  Obstacle({
    required this.x,
    required this.y,
    required this.height,
    required this.width,
  });

  bool outOfViewport = false;
  update(){
    x += -v;
    v += a;
    a += 0.0000001;
    //log(x.toString());
  }
  void onOutOfViewport(Function action){
   if(outOfViewport)action.call();
  }

  resetPosition(double pos){
    x = pos;
  }
 void checkOutOfViewport(Offset currentPos,Size viewportSize){
    if(currentPos.dx < 0){
      outOfViewport = true;
    }else{
      outOfViewport = false;
    }
 }

}
