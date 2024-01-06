// 1   2   3
// 4   5   6
// 7   8   9

import 'package:flutter/foundation.dart';
import 'package:menace_flutter/managers/manager.dart';

class GameState {
  GameState.fromState(GameState state, int index, Player player)
      : gameState = {...state.gameState} {
    gameState.update(
        index,
        (value) =>
            player); //Leaving it as is to be able to create scenarios from the middle;
  }

  GameState.fromUint8List(Uint8List stateList)
      : gameState = {
          for (int position = 1; position <= 9; position++)
            position: Player.none
        } {
    List<int> state = List.from(stateList);
    for (int i = 0; i < 9; i++) {
      gameState[i + 1] = Player.values[state[i]];
    }
  }

  @override
  String toString() {
    //overriden sring to show up when used with print. just returns gameState (>'-'<)
    return gameState.map((key, value) => MapEntry(key, value.index)).toString();
  }

  Uint8List toUint8List() {
    var stateList = gameState.values
        .map((e) => e.index)
        .toList(); //give a list of indexes instead of enums. ie converts Player.human to 1
    return Uint8List.fromList(stateList);
  }

  GameState()
      : gameState = {
          for (int position = 1; position <= 9; position++)
            position: Player.none
        };

  bool hasEnded() {
    var hasEnded = true;

    for (var element in gameState.values) {
      if (element == Player.none) hasEnded = false;
    }
    return hasEnded;
  }

  Map<int, Player> gameState;
}
