// 1   2   3
// 4   5   6
// 7   8   9

import 'package:flutter/foundation.dart';

import './ai_manager.dart';
import './storage_manager.dart';
import 'game_state.dart';

//Game ends only when no more moves are possible or findWInner returns a player other than none
class GameManager {
  GameManager(Player firstPlayer)
      : nextPlayer = firstPlayer,
        gameState = GameState(),
        aiManager = AiManager(),
        storageManager = StorageManager();

  Player nextPlayer;
  Player firstPlayer = Player.human;
  bool gameTied = false;
  final Map<GameState, int> _previousMoves =
      {}; //store all our previous moves in a map and pass it to AI manager after game end
  AiManager aiManager;
  GameState gameState;
  StorageManager storageManager;
  Player _winner = Player.none;
  bool isGameDisabled = false; //Disabled if game ended or paused(?)

  Future<bool> initialize() async {
    return await aiManager.initialize();
  }

  void setHumanFirstPlayer(bool val) {
    firstPlayer = val ? Player.human : Player.menace;
    print("First PLayer $val");
  }

  void reset() {
    gameState = GameState();
    nextPlayer = firstPlayer;
    isGameDisabled = false;
    gameTied = false;
    _winner = Player.none;

    if (firstPlayer == Player.menace) {
      addAiMove();
    }
  }

  void addHumanMove(int index) {
    if (gameState.gameState[index] != Player.none) {
      //Prevents Player from Overwriting previous Own/Menace's moves
      if (kDebugMode) {
        print("Cannot Overwrite PRevious Moves");
      }
      return;
    }
    gameState = GameState.fromState(gameState, index, Player.human);
    if (findWinner() != Player.none) {
      // If game is ended, fix ai will occour automatically.
      if (kDebugMode) {
        print("gameEnded");
      }
      return;
    }
    nextPlayer = Player.menace;
    addAiMove();
  }

  void store() {}
  void addAiMove() {
    int movePosition = aiManager.moveAi(gameState);
    if (movePosition == 0) {
      if (kDebugMode) {
        print("Reached End");
      }
      if (findWinner() == Player.none) {
        if (kDebugMode) {
          gameTied = true;
          print("Game Tied");
        }
      }
      return;
    }
    _previousMoves[gameState] = movePosition;
    gameState = GameState.fromState(gameState, movePosition, Player.menace);
    print("Tide ${gameState.hasEnded()}");
    if (findWinner() == Player.menace) {
      if (kDebugMode) {
        print("MENACE WINS");
      }
    } else {
      nextPlayer = Player.human;
      if (gameState.hasEnded()) {
        print("Game Tide");
        gameTied = true;
      }
    }
  }

  Player findWinner() //8 lines to fill to finish the game
  {
    // Rows filling test
    _winner = Player.none;
    if (gameState.gameState[1] == gameState.gameState[2] &&
        gameState.gameState[2] == gameState.gameState[3]) {
      //Test if rows are filled by the same person
      if (gameState.gameState[1]! != Player.none) {
        //Prevents override if Blank rows is found and passed in
        _winner = gameState.gameState[1]!;
      }
    }

    if (gameState.gameState[4] == gameState.gameState[5] &&
        gameState.gameState[5] == gameState.gameState[6]) {
      if (gameState.gameState[4]! != Player.none) {
        _winner = gameState.gameState[4]!;
      }
    }

    if (gameState.gameState[7] == gameState.gameState[8] &&
        gameState.gameState[8] == gameState.gameState[9]) {
      if (gameState.gameState[7]! != Player.none) {
        _winner = gameState.gameState[7]!;
      }
    }

    // column filled test
    if (gameState.gameState[1] == gameState.gameState[4] &&
        gameState.gameState[4] == gameState.gameState[7]) {
      if (gameState.gameState[1]! != Player.none) {
        _winner = gameState.gameState[1]!;
      }
    }

    if (gameState.gameState[2] == gameState.gameState[5] &&
        gameState.gameState[5] == gameState.gameState[8]) {
      if (gameState.gameState[2]! != Player.none) {
        _winner = gameState.gameState[2]!;
      }
    }

    if (gameState.gameState[3] == gameState.gameState[6] &&
        gameState.gameState[6] == gameState.gameState[9]) {
      if (gameState.gameState[3]! != Player.none) {
        _winner = gameState.gameState[3]!;
      }
    }

    //diagonal filling testb
    if (gameState.gameState[1] == gameState.gameState[5] &&
        gameState.gameState[5] == gameState.gameState[9]) {
      if (gameState.gameState[1]! != Player.none) {
        _winner = gameState.gameState[1]!;
      }
    }

    if (gameState.gameState[3] == gameState.gameState[5] &&
        gameState.gameState[5] == gameState.gameState[7]) {
      if (gameState.gameState[3]! != Player.none) {
        _winner = gameState.gameState[3]!;
      }
    }
    bool didWin = (_winner == Player.menace);

    if (_winner != Player.none) {
      isGameDisabled = true;
      aiManager.fixAi(_previousMoves, didWin);
    } else {
      if (kDebugMode) {
        print("GameState is ${gameState.gameState} for $_winner");
      }
    }

    return _winner;
  }

  Player get gameWinner => _winner;
}

enum Player {
  none,
  human,
  menace,
}
