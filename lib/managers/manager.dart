// 1   2   3
// 4   5   6
// 7   8   9

import './ai_manager.dart';

const positonList = [1, 2, 3, 4, 5, 6, 7, 8, 9];

//BUGFIX : CHeck for winner only after game is finished. IsGameFinished to be converted to isEcist for Player.none.
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
  bool isGameDisabled = false; //Disabled if game ended or paused(?)

  void addHumanMove(int index) {
    gameState = GameState.fromState(gameState, index, Player.human);
    if (findWinner() != Player.none) {
      // If game is ended, fix ai will occour automatically.
      print("gameEnded");
      return;
    }
    nextPlayer = Player.menace;
    addAiMove();
  }

  void addAiMove() {
    int movePosition = aiManager.moveAi(gameState);
    if (movePosition == 0) {
      print("Reached End");
      print(findWinner());
      return;
    }
    _previousMoves[gameState] = movePosition;
    gameState = GameState.fromState(gameState, movePosition, Player.menace);
    nextPlayer = Player.human;
    print(gameState.gameState);
  }

  Player findWinner() //8 lines to fill to finish the game
  {
    
    // Rows filling test
    _winner = Player.none;
    if (gameState.gameState[1] == gameState.gameState[2] &&
        gameState.gameState[2] == gameState.gameState[3]) {
      //Test if rows are filled by the same person
      _winner = gameState.gameState[1]!;
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
      _winner = gameState.gameState[1]!;
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
    print(_winner);
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
      : gameState = {for (int position in positonList) position: Player.none} {
    Map<int, Player>;
  }

  Map<int, Player> gameState;
}

enum Player { human, menace, none }
