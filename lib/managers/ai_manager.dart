import 'dart:io';

import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:flutter/foundation.dart';
import 'package:menace_flutter/managers/storage_manager.dart';

import './manager.dart';
import 'game_state.dart';

//Mananger Should primarily:
// -Accept a GameState and return a play position
// - Accept all Previous _gameMoves and fix the values depending on outcome

class AiManager {
  AiManager()
      : _stateValues = {
          GameState(): {1: 1, 2: 1, 3: 1, 4: 1, 5: 1, 6: 1, 7: 1, 8: 1, 9: 1}
        },
        _matchesPlayed = 0,
        _wins = 0,
        _storageManager = StorageManager();
  Map<GameState, Map<int, int>> _stateValues;
  double _matchesPlayed;
  final Map<double, double> _winRateData = {};
  double _wins;
  final StorageManager _storageManager;
  GameState lastState = GameState();

  int moveAi(GameState state) {
    Map<int, int> weightMap = {};
    bool isNewState = true;

    /* Weird method to check if states are equal since dart has some funky 
    equality problems involving enums */
    for (var element in _stateValues.keys) {
      if (element.toString() == state.toString()) {
        isNewState = false;
        weightMap = _stateValues[element]!;
      }
    }

    if (isNewState) {
      state.gameState.forEach((key, value) {
        //create new state if it does not exist
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
    lastState = state;
    var options = weightMap;
    var play = randomChoice(
        options.keys.toList(), options.values.map((e) => e.toDouble()));
    return play;
  }

  Future<bool> initialize() async {
    sleep(const Duration(milliseconds: 500));
    return true;
  }

  void store() {
    _storageManager.storeDisk(_stateValues);
  }

  void resetDisk() {
    _storageManager.resetDisk();
  }

  Future<bool> read() async {
    try {
      _stateValues = await _storageManager.readDisk();
      return true;
    } catch (err) {
      if (kDebugMode) {
        print("err");
      }
      return false;
    }
  }

  Map<int, int> get positionValues {
    for (var element in _stateValues.keys) {
      if (element.toString() == lastState.toString()) {
        return _stateValues[element]!;
      }
    }
    return {1: 1};
  }

  Map<double, double> get winRateData => _winRateData;

  void fixAi(Map<GameState, int> previousMoves, bool didWin) {
    _matchesPlayed += 1;
    if (didWin) _wins += 1;
    _winRateData[_matchesPlayed] = (_wins / _matchesPlayed) * 100.0;
    previousMoves.forEach((state, move) {
      // Just matching the current move to the move in ai list.
      late GameState internalState;
      int positionPlayed = move;
      Map<int, int> weightMap = {};
      for (var element in _stateValues.keys) {
        if (state.toString() == element.toString()) {
          weightMap = _stateValues[element]!;
          internalState = element;
        }
      }
      for (var stateMove in weightMap.keys) {
        if (stateMove == positionPlayed) {
          //forEach does NOT manipulate map data
          //I dont even know man God Saraswati help you next time you look here.
          if (didWin) {
            _stateValues[internalState]![stateMove] =
                _stateValues[internalState]![stateMove]! + 3;
          } else {
            _stateValues[internalState]![stateMove] =
                (_stateValues[internalState]![stateMove]! - 1) > 0
                    ? (_stateValues[internalState]![stateMove]! - 1)
                    : 0; // so that the value only goes to 0 and not -ve
          }

          if (_stateValues[internalState]!
              .values
              .every((element) => element == 0)) {
            if (kDebugMode) {
              print("StateValues Empty... Refilling");
            }

            Map<int, int> newWeightMap = {};
            internalState.gameState.forEach((key, value) {
              if (value != Player.none) {
                newWeightMap[key] = 0;
              } else {
                newWeightMap[key] = 1;
              }
            });
            _stateValues[internalState] = newWeightMap;
          }
        }
      }
    });

    store();
  }
}
