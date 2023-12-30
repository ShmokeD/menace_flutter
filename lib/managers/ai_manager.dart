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
      : _stateValues = {},
        _matchesPlayed = 0,
        _wins = 0,
        _storageManager = StorageManager();

  Map<GameState, Map<int, int>> _stateValues = {};
  double _matchesPlayed;
  final Map<double, double> _winRateData = {};
  double _wins;
  final StorageManager _storageManager;

  int moveAi(GameState state) {
    Map<int, int> weightMap = {};
    if (!_stateValues.keys.contains(state)) {
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
    var options = _stateValues[state];
    var play = randomChoice(
        options!.keys.toList(), options.values.map((e) => e.toDouble()));
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

  Map<double, double> get winRateData => _winRateData;

  void fixAi(Map<GameState, int> previousMoves, bool didWin) {
    _matchesPlayed += 1;
    if (didWin) _wins += 1;
    _winRateData[_matchesPlayed] = (_wins / _matchesPlayed) * 100.0;
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

    store();
  }
}
