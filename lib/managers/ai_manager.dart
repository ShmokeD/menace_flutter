import 'package:dart_random_choice/dart_random_choice.dart';

import './manager.dart';

//Mananger Should primarily:
// -Accept a GameState and return a play position
// - Accept all Previous _gameMoves and fix the values depending on outcome

//BUG: Does not check if position is preoccupiesd.
class AiManager {
  static const positionList = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  AiManager() : _stateValues = {};

 final  Map<GameState, Map<int, double>> _stateValues;

  int moveAi(GameState state) {
    Map<int, double> weightMap = {};
    if (!_stateValues.keys.contains(state)) {
      state.gameState.forEach((key, value) {
        if (value != Player.none) {
          weightMap[key] = 0;
        } else {
          weightMap[key] = 1;
        }
      });

      _stateValues.addEntries({
        state: weightMap
      }.entries); // Create a new Map with keys from positionList and values as 1; Edit: Values cant be just one. Should be 0 if preoccupied.
    }
    int c = 0;
    weightMap.forEach((key, value) => c += value.toInt());
    if (c == 0) {
      //all weights are 0. thus signaling the end.
      return 0;
    }
    var options = _stateValues[state];
    var play = randomChoice(options!.keys.toList(), options.values.toList());
    return play;
  }

  void fixAi(Map<GameState, int> previousMoves, bool didWin) {
    previousMoves.forEach((state, move) {
      // Just matching the current move to the move in ai list.
      int positionPlayed = move;

      _stateValues[state]!.forEach((stateMove, moveWeight) {
        if (stateMove == positionPlayed) {
          //I dont even know man God Saraswati help you next time you look here.
          if (didWin) {
            moveWeight += 3;
          } else {
            moveWeight -= 1;
          }
        }
      });
    });
  }
}
