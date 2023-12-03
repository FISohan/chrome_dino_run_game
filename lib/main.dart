import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:run_dino_run/game_object/dino.dart';
import 'package:run_dino_run/painter/game_painter.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Game(),
      )));
}

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Dino _dino;
  bool isTapSpaceKey = false;
  Offset dinoPos = const Offset(0, 0);
  @override
  void initState() {
    super.initState();
    ServicesBinding.instance.keyboard.addHandler(_onKeyTap);
    _dino = Dino(x: 0, y: 0);
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1), vsync: this)
      ..addListener(_update)
      ..forward()
      ..repeat();
  }

  bool _onKeyTap(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.physicalKey.debugName == "Space") {
       _dino.jump();
      }
    }
   // log("$isTapSpaceKey");
    return false;
  }

  void _update() {
    setState(() {
      dinoPos = Offset(_dino.x, _dino.y);
      _dino.updateDino();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.all(2),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: CustomPaint(
        painter: GamePainter(),
      ),
    );
  }
}
