// 1   2   3
// 4   5   6
// 7   8   9

import './ai_manager.dart';

const positonList = [1, 2, 3, 4, 5, 6, 7, 8, 9];

class GameManager {
  GameManager(){
    _gameState = GameState();
    aiManager = AiManager();
  }

  final Map<GameState, int> _previousMoves =
      {}; //store all our previous moves in a map and pass it to AI manager after game end
  late AiManager aiManager;
  late GameState _gameState;
  Player _winner = Player.none;

  void addHumanMove(int index) {
   
      _gameState = GameState.fromState(_gameState, index, Player.human);
    
  }

  void addAiMove(){
    int movePosition = aiManager.moveAi(_gameState);
    _previousMoves[_gameState] = movePosition;
    _gameState = GameState.fromState(_gameState, movePosition, Player.menace);

  }

  bool isGameFinished() //8 lines to fill to finish the game
  {
    // Rows filling test
    if (_gameState.state[1] != Player.none &&
        _gameState.state[2] != Player.none &&
        _gameState.state[3] != Player.none) {
      if (_gameState.state[1] == _gameState.state[2] &&
          _gameState.state[2] == _gameState.state[3]) {
        //Test if rows are filled by the same person
        _winner = _gameState.state[1];
      } else {
        _winner = Player.none;
      }
      bool didWin = _winner ==Player.menace;
      aiManager.fixAi(_previousMoves, didWin);
      return true;
    }
    if (_gameState.state[4] != Player.none &&
        _gameState.state[5] != Player.none &&
        _gameState.state[6] != Player.none) {
      if (_gameState.state[4] == _gameState.state[5] &&
          _gameState.state[5] == _gameState.state[6]) {
        _winner = _gameState.state[4];
      } else {
        _winner = Player.none;
      }
      bool didWin = _winner ==Player.menace;
      aiManager.fixAi(_previousMoves, didWin);
      return true;
    }
    if (_gameState.state[7] != Player.none &&
        _gameState.state[8] != Player.none &&
        _gameState.state[9] != Player.none) {
      if (_gameState.state[7] == _gameState.state[8] &&
          _gameState.state[8] == _gameState.state[9]) {
        _winner = _gameState.state[7];
      } else {
        _winner = Player.none;
      }
      bool didWin = _winner ==Player.menace;
      aiManager.fixAi(_previousMoves, didWin);
      return true;
    }

    // column filled test
    if (_gameState.state[1] != Player.none &&
        _gameState.state[4] != Player.none &&
        _gameState.state[7] != Player.none) {
      if (_gameState.state[1] == _gameState.state[4] &&
          _gameState.state[4] == _gameState.state[7]) {
        _winner = _gameState.state[1];
      } else {
        _winner = Player.none;
      }
      bool didWin = _winner ==Player.menace;
      aiManager.fixAi(_previousMoves, didWin);
      return true;
    }
    if (_gameState.state[2] != Player.none &&
        _gameState.state[5] != Player.none &&
        _gameState.state[8] != Player.none) {
      if (_gameState.state[2] == _gameState.state[5] &&
          _gameState.state[5] == _gameState.state[8]) {
        _winner = _gameState.state[2];
      } else {
        _winner = Player.none;
      }
      bool didWin = _winner ==Player.menace;
      aiManager.fixAi(_previousMoves, didWin);
      return true;
    }
    if (_gameState.state[3] != Player.none &&
        _gameState.state[6] != Player.none &&
        _gameState.state[9] != Player.none) {
      if (_gameState.state[3] == _gameState.state[6] &&
          _gameState.state[6] == _gameState.state[9]) {
        _winner = _gameState.state[3];
      } else {
        _winner = Player.none;
      }
      bool didWin = _winner ==Player.menace;
      aiManager.fixAi(_previousMoves, didWin);
      return true;
    }

    //diagonal filling testb
    if (_gameState.state[1] != Player.none &&
        _gameState.state[5] != Player.none &&
        _gameState.state[9] != Player.none) {
      if (_gameState.state[1] == _gameState.state[5] &&
          _gameState.state[5] == _gameState.state[9]) {
        _winner = _gameState.state[1];
      } else {
        _winner = Player.none;
      }
      bool didWin = _winner ==Player.menace;
      aiManager.fixAi(_previousMoves, didWin);
      return true;
    }
    if (_gameState.state[3] != Player.none &&
        _gameState.state[5] != Player.none &&
        _gameState.state[7] != Player.none) {
      if (_gameState.state[3] == _gameState.state[5] &&
          _gameState.state[5] == _gameState.state[7]) {
        _winner = _gameState.state[3];
      } else {
        _winner = Player.none;
      }
      bool didWin = _winner ==Player.menace;
      aiManager.fixAi(_previousMoves, didWin);
      return true;
    }

    return false;
  }
  GameState get gameState => _gameState;
  Player get gameWinner => _winner;
}

class GameState {
  GameState.fromState(GameState state, int index, Player player) { //Leaving it as is to be able to create scenarios from the middle;
    _gameState = [...state.state];
    _gameState[index] = player;
  }

  GameState() {
    Map<int, Player> _gameState = {
      for (int position in positonList) position: Player.none
    };
  }

  late List<Player> _gameState;
  List<Player> get state => _gameState;
}

enum Player { human, menace, none }
