import 'dart:async';

import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrickBreaker extends StatefulWidget {
  @override
  _BrickBreakerState createState() => _BrickBreakerState();
}

class _BrickBreakerState extends State<BrickBreaker> {
  final int rows = 5;
  final int columns = 5;
  final double brickWidth = 70.0;
  final double brickHeight = 20.0;
  final double paddleWidth = 100.0;
  final double paddleHeight = 15.0;
  final double ballRadius = 10.0;
  late double ballX, ballY, dx, dy;
  late double paddleX;
  bool gameStarted = false;
  int hitCount = 0;
  bool out = false;
  bool start = false;
  @override
  void initState() {
    super.initState();
    start = true;
    startGame();
  }

  void startGame() {
    ballX = 150;
    ballY = 150;
    dx = 1;
    dy = 1;

    paddleX = 150;
    hitCount = 0;
    out = false;
    gameStarted = false;
  }

  void movePaddle(DragUpdateDetails dragDetails) {
    setState(() {
      start = false;
      paddleX += dragDetails.delta.dx;
    });
  }

  void startBall() {
    if (!gameStarted) {
      Timer.periodic(Duration(milliseconds: 10), (timer) {
        setState(() {
          ballX += dx;
          ballY += dy;

          // Ball collision detection
          if (ballX + ballRadius >= MediaQuery.of(context).size.width ||
              ballX - ballRadius <= 0) {
            dx = -dx;
          }

          if (ballY - ballRadius <= 0) {
            dy = -dy;
          }

          if (ballY + ballRadius >=
              MediaQuery.of(context).size.height - paddleHeight) {
            if (ballX >= paddleX && ballX <= paddleX + paddleWidth) {
              dy = -dy;
              hitCount++; // Increment hit count
              dx *= 1.1; // Increase speed
              dy *= 1.1; // Increase speed
            } else {
              out = true;
              timer.cancel();
              showGameOverDialog().then((value) => startGame());
            }
          }
        });
      });
      gameStarted = true;
    }
  }

  Future<void> showGameOverDialog() {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Game Over'),
        content: Text(
          'You scored $hitCount points.\nScore 40 and convert your 40 into 1000 Credits',
          textAlign: TextAlign.center,
        ),
        actions: [
          hitCount >= 25
              ? TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Convert'))
              : TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Play Again',
                  ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      backgroundColor:
          theme.getDarkTheme ? themeColor.darkTheme : themeColor.themeColor,
      body: GestureDetector(
        onHorizontalDragUpdate: movePaddle,
        onTap: startBall,
        child: Container(
          color:
              theme.getDarkTheme ? themeColor.darkTheme : themeColor.themeColor,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment(0, 0),
                child:start==true? Text("Drag the Screen to Begin the Game"):Container(),
              ),
              Positioned(
                left: ballX,
                top: ballY,
                child: Container(
                  width: ballRadius * 2,
                  height: ballRadius * 2,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: paddleX,
                bottom: 0,
                child: Container(
                  width: paddleWidth,
                  height: paddleHeight,
                  color: theme.getDarkTheme ? Colors.white : Colors.black,
                ),
              ),
              Positioned(
                top: 40.0,
                left: 10.0,
                child: Text(
                  'Hits: $hitCount',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              out
                  ? Align(
                      alignment: Alignment(0, 0),
                      child: Text("Touch To Start The Game"))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
