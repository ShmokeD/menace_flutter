import 'package:dart_random_choice/dart_random_choice.dart';

import './manager.dart';

//Mananger Should primarily:
// -Accept a GameState and return a play position
// - Accept all Previous _gameMoves and fix the values depending on outcome
class AiManager {
  static const positionList = [1, 2, 3, 4, 5, 6, 7, 8, 9]; 
  AiManager() : _stateValues = {};

  Map<GameState, Map<int, double>> _stateValues;

  int moveAi(GameState state) {
    if (!_stateValues.keys.contains(state)) {
      _stateValues[state] = {
        for (var element in positionList) element: 1
      }; // Create a new Map with keys from positionList and values as 1;
    }

    var options = _stateValues[state];
    var play = randomChoice(options!.keys.toList(), options.values.toList());
    return play;
  }

  void fixAi(List<Map<GameState, int>> previousMoves, bool didWin) {
    for (var move in previousMoves) {
      move.forEach((key, value) {
        // Just matching the current move to the move in ai list.
        int positionPlayed = value;
        _stateValues[key]!.forEach((stateKey, stateValue) {
          if (stateKey == positionPlayed) {
            //I dont even know man God Saraswati help you next time you look here.
            if (didWin) {
              stateValue += 3;
            } else {
              stateValue -= 1;
            }
          }
        });
      });
    }
  }
}
