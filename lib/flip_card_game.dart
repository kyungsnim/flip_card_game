import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flip_card_game/importer.dart';
import 'package:get/get.dart';

class FlipCardGame extends StatefulWidget {
  Level level;

  FlipCardGame({
    required this.level,
    super.key});

  @override
  State<FlipCardGame> createState() => _FlipCardGameState();
}

class _FlipCardGameState extends State<FlipCardGame> {
  int _previousIndex = -1;
  bool _flip = false;
  bool _start = false;

  bool _wait = false;
  late Level _level;
  late Timer _timer;
  int _time = 7;
  late int _left;
  late bool _isFinished;
  late List<String> _data;

  late List<bool> _cardFlips;
  late List<GlobalKey<FlipCardState>> _cardStateKeys;

  Widget getItem(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 3,
              spreadRadius: 0.8,
              offset: Offset(2.0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.all(4.0),
      child: Image.asset(_data[index]),
    );
  }

  startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        _time = _time - 1;
      });
    });
  }

  void restart() {
    startTimer();
    _data = getSourceArray(
      _level,
    );
    _cardFlips = getInitialItemState(_level);
    _cardStateKeys = getCardStateKeys(_level);
    _time = 7;
    _left = (_data.length ~/ 2);

    _isFinished = false;
    Future.delayed(const Duration(seconds: 8), () {
      setState(() {
        _start = true;
        _timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _level = widget.level;
    restart();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isFinished
        ? Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  restart();
                });
              },
              child: Container(
                height: 50,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  "Replay",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  Get.offAll(() => HomePage());
                });
              },
              child: Container(
                height: 50,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  "Home",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    )
        : Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _time > 0
                    ? Text(
                  '$_time',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline3,
                )
                    : Text(
                  'Left:$_left',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.level == Level.Hard ? 4 : 3,
                  ),
                  itemBuilder: (context, index) =>
                  _start
                      ? FlipCard(
                      key: _cardStateKeys[index],
                      onFlip: () {
                        if (!_flip) {
                          _flip = true;
                          _previousIndex = index;
                        } else {
                          _flip = false;
                          if (_previousIndex != index) {
                            if (_data[_previousIndex] !=
                                _data[index]) {
                              _wait = true;

                              Future.delayed(
                                  const Duration(milliseconds: 1500),
                                      () {
                                    _cardStateKeys[_previousIndex]
                                        .currentState!
                                        .toggleCard();
                                    _previousIndex = index;
                                    _cardStateKeys[_previousIndex]
                                        .currentState!
                                        .toggleCard();

                                    Future.delayed(
                                        const Duration(milliseconds: 160),
                                            () {
                                          setState(() {
                                            _wait = false;
                                          });
                                        });
                                  });
                            } else {
                              _cardFlips[_previousIndex] = false;
                              _cardFlips[index] = false;
                              print(_cardFlips);

                              setState(() {
                                _left -= 1;
                              });
                              if (_cardFlips
                                  .every((t) => t == false)) {
                                // print("Won");
                                Future.delayed(
                                    const Duration(milliseconds: 160),
                                        () {
                                      setState(() {
                                        _isFinished = true;
                                        _start = false;
                                      });
                                    });
                              }
                            }
                          }
                        }
                        setState(() {});
                      },
                      flipOnTouch: _wait ? false : _cardFlips[index],
                      direction: FlipDirection.HORIZONTAL,
                      front: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 3,
                                spreadRadius: 0.8,
                                offset: Offset(2.0, 1),
                              )
                            ]),
                        margin: const EdgeInsets.all(4.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/quest.png",
                          ),
                        ),
                      ),
                      back: getItem(index))
                      : getItem(index),
                  itemCount: _data.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}