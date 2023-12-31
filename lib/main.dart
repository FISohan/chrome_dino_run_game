import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:run_dino_run/const.dart';
import 'package:run_dino_run/game_object/dino.dart';
import 'package:run_dino_run/game_object/obstacle.dart';
import 'package:run_dino_run/painter/game_painter.dart';
import 'dart:ui' as ui;

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

class _GameState extends State<Game> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _spriteAnimationController;
  late Animation<int> _spriteAnimation;
  late Dino _dino;
  bool isTapSpaceKey = false;
  Offset dinoPos = const Offset(0, 0);

  int index = 0;
  Random random = Random();

  int _randomOffset() {
    return OBSTACLE_MIN_OFFSET + random.nextInt(OBSTACLE_MAX_OFFSET);
  }

  List<Obstacle> obstacleList = List.empty();

  Future<ui.FrameInfo> _loadImage(String assetPath) async {
    try {
      final ByteData byteData = await rootBundle.load(assetPath);
      final Uint8List bytes = byteData.buffer.asUint8List();
      final ui.Codec codec = await ui.instantiateImageCodec(bytes);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      return frameInfo;
    } catch (err) {
      return Future.error(err);
    }
  }

  ui.Image? img;
  @override
  void initState() {
    super.initState();
    obstacleList = List.generate(
      1,
      (index) => Obstacle(
          x: (OBSTACLE_VIEWPORT_WIDTH * (index * _randomOffset())),
          y: 0,
          height: OBSTACLE_VIEWPORT_HEIGHT,
          width: OBSTACLE_VIEWPORT_WIDTH),
    );

    _loadImage("assets/sprites/s.png").then((value) => img = value.image);

    ServicesBinding.instance.keyboard.addHandler(_onKeyTap);
    _dino = Dino(x: 0, y: 0);
    _spriteAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _spriteAnimation =
        IntTween(begin: 0, end: 4).animate(_spriteAnimationController)
          ..addListener(() {
            setState(() {});

            if (_spriteAnimationController.isCompleted) {
              _spriteAnimationController.repeat();
            } else if (_spriteAnimationController.isDismissed) {
              _spriteAnimationController.forward();
            }
          });
    _spriteAnimationController.forward();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
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
      for (Obstacle obstacle in obstacleList) {
        obstacle.update();
        obstacle.onOutOfViewport(() {
          if (obstacle.outOfViewport) {
            obstacle.resetPosition(
                (OBSTACLE_VIEWPORT_WIDTH * (index * _randomOffset())));
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    ServicesBinding.instance.keyboard.removeHandler(_onKeyTap);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.all(2),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: img == null
          ? const CircularProgressIndicator()
          : CustomPaint(
              painter: GamePainter(
                img: img!,
                dinoPosition: Offset(_dino.x, _dino.y),
                spriteImgIndex: _spriteAnimation.value,
                obstaclesList: obstacleList,
              ),
            ),
    );
  }
}
