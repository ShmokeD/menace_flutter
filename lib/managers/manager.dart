// 1   2   3
// 4   5   6
// 7   8   9

import './ai_manager.dart';

const positonList = [1, 2, 3, 4, 5, 6, 7, 8, 9];

class GameManager {
  GameManager(Player firstPlayer)
      : nextPlayer = firstPlayer,
        gameState = GameState(),
        aiManager = AiManager();

  Player nextPlayer;

  final Map<GameState, int> _previousMoves =
      {}; //store all our previous moves in a map and pass it to AI manager after game end
  AiManager aiManager;
  GameState gameState;
  Player _winner = Player.none;

  void addHumanMove(int index) {
    if (isGameFinished()) {
      print("gameFinished");
      print(_winner);
      return;
    }
    gameState = GameState.fromState(gameState, index, Player.human);
    nextPlayer = Player.menace;
    addAiMove();
  }

  void addAiMove() {
    if (isGameFinished()) {
      print("gameFinished");
      print(_winner);
      return;
    }
    int movePosition = aiManager.moveAi(gameState);
    _previousMoves[gameState] = movePosition;
    gameState = GameState.fromState(gameState, movePosition, Player.menace);
    nextPlayer = Player.human;
    print(gameState.gameState);
  }

  bool isGameFinished() //8 lines to fill to finish the game
  {
    // Rows filling test
    if (gameState.gameState[1] != Player.none &&
        gameState.gameState[2] != Player.none &&
        gameState.gameState[3] != Player.none) {
      if (gameState.gameState[1] == gameState.gameState[2] &&
          gameState.gameState[2] == gameState.gameState[3]) {
        //Test if rows are filled by the same person
        _winner = gameState.gameState[1]!;
      } else {
        _winner = Player.none;
      }
      bool didWin = _winner == Player.menace;
      aiManager.fixAi(_previousMoves, didWin);
      return true;
    }
    if (gameState.gameState[4] != Player.none &&
        gameState.gameState[5] != Player.none &&
        gameState.gameState[6] != Player.none) {
      if (gameState.gameState[4] == gameState.gameState[5] &&
          gameState.gameState[5] == gameState.gameState[6]) {
        _winner = gameState.gameState[4]!;
      } else {
        _winner = Player.none;
      }
      bool didWin = _winner == Player.menace;
      aiManager.fixAi(_previousMoves, didWin);
      return true;
    }
    if (gameState.gameState[7] != Player.none &&
        gameState.gameState[8] != Player.none &&
        gameState.gameState[9] != Player.none) {
      if (gameState.gameState[7] == gameState.gameState[8] &&
          gameState.gameState[8] == gameState.gameState[9]) {
        _winner = gameState.gameState[7]!;
      } else {
        _winner = Player.none;
      }
      bool didWin = _winner == Player.menace;
      aiManager.fixAi(_previousMoves, didWin);
      return true;
    }

    // column filled test
    if (gameState.gameState[1] != Player.none &&
        gameState.gameState[4] != Player.none &&
        gameState.gameState[7] != Player.none) {
      if (gameState.gameState[1] == gameState.gameState[4] &&
          gameState.gameState[4] == gameState.gameState[7]) {
        _winner = gameState.gameState[1]!;
      } else {
        _winner = Player.none;
      }
      bool didWin = _winner == Player.menace;
      aiManager.fixAi(_previousMoves, didWin);
      return true;
    }
    if (gameState.gameState[2] != Player.none &&
        gameState.gameState[5] != Player.none &&
        gameState.gameState[8] != Player.none) {
      if (gameState.gameState[2] == gameState.gameState[5] &&
          gameState.gameState[5] == gameState.gameState[8]) {
        _winner = gameState.gameState[2]!;
      } else {
        _winner = Player.none;
      }
      bool didWin = _winner == Player.menace;
      aiManager.fixAi(_previousMoves, didWin);
      return true;
    }
    if (gameState.gameState[3] != Player.none &&
        gameState.gameState[6] != Player.none &&
        gameState.gameState[9] != Player.none) {
      if (gameState.gameState[3] == gameState.gameState[6] &&
          gameState.gameState[6] == gameState.gameState[9]) {
        _winner = gameState.gameState[3]!;
      } else {
        _winner = Player.none;
      }
      bool didWin = _winner == Player.menace;
      aiManager.fixAi(_previousMoves, didWin);
      return true;
    }

    //diagonal filling testb
    if (gameState.gameState[1] != Player.none &&
        gameState.gameState[5] != Player.none &&
        gameState.gameState[9] != Player.none) {
      if (gameState.gameState[1] == gameState.gameState[5] &&
          gameState.gameState[5] == gameState.gameState[9]) {
        _winner = gameState.gameState[1]!;
      } else {
        _winner = Player.none;
      }
      bool didWin = _winner == Player.menace;
      aiManager.fixAi(_previousMoves, didWin);
      return true;
    }
    if (gameState.gameState[3] != Player.none &&
        gameState.gameState[5] != Player.none &&
        gameState.gameState[7] != Player.none) {
      if (gameState.gameState[3] == gameState.gameState[5] &&
          gameState.gameState[5] == gameState.gameState[7]) {
        _winner = gameState.gameState[3]!;
      } else {
        _winner = Player.none;
      }
      bool didWin = _winner == Player.menace;
      aiManager.fixAi(_previousMoves, didWin);
      return true;
    }

    return false;
  }

  Player get gameWinner => _winner;
}

class GameState {
  GameState.fromState(GameState State, int index, Player player)
      : gameState = {...State.gameState} {
    gameState.update(
        index,
        (value) =>
            player); //Leaving it as is to be able to create scenarios from the middle;
  }

  GameState()
      : gameState = {for (int position in positonList) position: Player.none} {
    Map<int, Player>;
  }

  Map<int, Player> gameState;
}

enum Player { human, menace, none }
