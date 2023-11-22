// 1   2   3
// 4   5   6
// 7   8   9

import 'package:flutter/foundation.dart';

import './ai_manager.dart';

//Game ends only when no more moves are possible or findWInner returns a player other than none
class GameManager {
  GameManager(Player firstPlayer)
      : nextPlayer = firstPlayer,
        gameState = GameState(),
        aiManager = AiManager();

  Player nextPlayer;
  bool gameTied = false;
  final Map<GameState, int> _previousMoves =
      {}; //store all our previous moves in a map and pass it to AI manager after game end
  AiManager aiManager;
  GameState gameState;
  Player _winner = Player.none;
  bool isGameDisabled = false; //Disabled if game ended or paused(?)

  void reset({Player firstPlayer = Player.human}) {
    gameState = GameState();
    nextPlayer = firstPlayer;
    isGameDisabled = false;
    gameTied = false;
    _winner = Player.none;
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
    if (findWinner() == Player.menace) {
      if (kDebugMode) {
        print("MENACE WINS");
      }
    }
    nextPlayer = Player.human;
  }

  Player findWinner() //8 lines to fill to finish the game
  {
    // Rows filling test
    _winner = Player.none;
    if (gameState.gameState[1] == gameState.gameState[2] &&
        gameState.gameState[2] == gameState.gameState[3]) {
      //Test if rows are filled by the same person
      if (gameState.gameState[1]! != Player.none) {
        _winner = gameState.gameState[1]!;
      }
    }

    if (gameState.gameState[4] == gameState.gameState[5] &&
        gameState.gameState[5] == gameState.gameState[6]) {
      _winner = gameState.gameState[4]!;
    }

    if (gameState.gameState[7] == gameState.gameState[8] &&
        gameState.gameState[8] == gameState.gameState[9]) {
      _winner = gameState.gameState[7]!;
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
      _winner = gameState.gameState[2]!;
    }

    if (gameState.gameState[3] == gameState.gameState[6] &&
        gameState.gameState[6] == gameState.gameState[9]) {
      _winner = gameState.gameState[3]!;
    }

    //diagonal filling testb
    if (gameState.gameState[1] == gameState.gameState[5] &&
        gameState.gameState[5] == gameState.gameState[9]) {
      _winner = gameState.gameState[1]!;
    }

    if (gameState.gameState[3] == gameState.gameState[5] &&
        gameState.gameState[5] == gameState.gameState[7]) {
      _winner = gameState.gameState[3]!;
    }
    bool didWin = (_winner == Player.menace);
    if (_winner != Player.none) {
      isGameDisabled = true;
      aiManager.fixAi(_previousMoves, didWin);
    }

    return _winner;
  }

  Player get gameWinner => _winner;
}

class GameState {
  GameState.fromState(GameState state, int index, Player player)
      : gameState = {...state.gameState} {
    gameState.update(
        index,
        (value) =>
            player); //Leaving it as is to be able to create scenarios from the middle;
  }

  GameState()
      : gameState = {
          for (int position = 1; position <= 9; position++)
            position: Player.none
        } {
    Map<int, Player>;
  }

  Map<int, Player> gameState;
}

enum Player { human, menace, none }
