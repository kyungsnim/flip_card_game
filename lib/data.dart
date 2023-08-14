import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

List<String> fillSourceArray() {
  return [
    'assets/images/bee.png',
    'assets/images/cat.png',
    'assets/images/chick.png',
    'assets/images/chicken.png',
    'assets/images/deer.png',
    'assets/images/dino.png',
    'assets/images/dog.png',
    'assets/images/duck.png',
    'assets/images/elephant.png',
    'assets/images/hippo.png',
    'assets/images/horse.png',
    'assets/images/lion.png',
    'assets/images/lobster.png',
    'assets/images/monkey.png',
    'assets/images/octopus.png',
    'assets/images/parrot.png',
    'assets/images/penguin.png',
    'assets/images/pig.png',
    'assets/images/rabbit.png',
    'assets/images/sheep.png',
    'assets/images/snail.png',
    'assets/images/tiger.png',
    'assets/images/turtle.png',
  ];
}

enum Level {Hard, Medium, Easy}

List<String> getSourceArray(Level level) {
  List<String> levelList = [];
  List sourceArray = fillSourceArray();

  sourceArray.shuffle();

  if (level == Level.Hard) {
    for (int i = 0; i < 10; i++) {
      levelList.add(sourceArray[i]);
      levelList.add(sourceArray[i]);
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 6; i++) {
      levelList.add(sourceArray[i]);
      levelList.add(sourceArray[i]);
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 3; i++) {
      levelList.add(sourceArray[i]);
      levelList.add(sourceArray[i]);
    }
  }
  levelList.shuffle();

  return levelList;
}

List<bool> getInitialItemState(Level level) {
  List<bool> initialItemState = [];

  if (level == Level.Hard) {
    for(int i = 0; i < 20; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Medium) {
    for(int i = 0; i < 12; i++) {
      initialItemState.add(true);
    }
  } else if( level == Level.Easy) {
    for(int i = 0; i < 6; i++) {
      initialItemState.add(true);
    }
  }
  return initialItemState;
}

List<GlobalKey<FlipCardState>> getCardStateKeys(Level level) {
  List<GlobalKey<FlipCardState>> cardStateKeys = [];

  if (level == Level.Hard) {
    for (int i = 0; i < 20; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  }

  return cardStateKeys;
}