class GameManager {
  GameManager.init() {
    _gameState = GameState();
  }

  Map<GameState, int> _previousMoves =
      {}; //store all our previous moves in a map and pass it to AI manager after game end

  late GameState _gameState;
  Player _winner = Player.none;

  void addMove(int index, Player player) {
    if (player == Player.human) {
      _gameState = GameState.fromState(_gameState, index, player);
    }
    if (player == Player.menace) {}
  }

  bool isGameFinished() //8 lines to fill to finish the game
  {
    // Rows filling test
    if (_gameState.state[0] != Player.none &&
        _gameState.state[1] != Player.none &&
        _gameState.state[2] != Player.none) {
      if (_gameState.state[0] == _gameState.state[1] &&
          _gameState.state[1] == _gameState.state[2]) {
        //Test if rows are filled by the same person
        _winner = _gameState.state[0];
      } else {
        _winner = Player.none;
      }
      return true;
    }
    if (_gameState.state[3] != Player.none &&
        _gameState.state[4] != Player.none &&
        _gameState.state[5] != Player.none) {
      if (_gameState.state[3] == _gameState.state[4] &&
          _gameState.state[4] == _gameState.state[5]) {
        _winner = _gameState.state[3];
      } else {
        _winner = Player.none;
      }
      return true;
    }
    if (_gameState.state[6] != Player.none &&
        _gameState.state[7] != Player.none &&
        _gameState.state[8] != Player.none) {
      if (_gameState.state[6] == _gameState.state[7] &&
          _gameState.state[7] == _gameState.state[8]) {
        _winner = _gameState.state[6];
      } else {
        _winner = Player.none;
      }
      return true;
    }

    // column filled test
    if (_gameState.state[0] != Player.none &&
        _gameState.state[3] != Player.none &&
        _gameState.state[6] != Player.none) {
      if (_gameState.state[0] == _gameState.state[3] &&
          _gameState.state[3] == _gameState.state[6]) {
        _winner = _gameState.state[0];
      } else {
        _winner = Player.none;
      }
      return true;
    }
    if (_gameState.state[1] != Player.none &&
        _gameState.state[4] != Player.none &&
        _gameState.state[7] != Player.none) {
      if (_gameState.state[1] == _gameState.state[4] &&
          _gameState.state[4] == _gameState.state[7]) {
        _winner = _gameState.state[1];
      } else {
        _winner = Player.none;
      }
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
      return true;
    }
    //diagonal filling testb
    if (_gameState.state[0] != Player.none &&
        _gameState.state[4] != Player.none &&
        _gameState.state[8] != Player.none) {
      if (_gameState.state[0] == _gameState.state[4] &&
          _gameState.state[4] == _gameState.state[8]) {
        _winner = _gameState.state[0];
      } else {
        _winner = Player.none;
      }
      return true;
    }
    if (_gameState.state[2] != Player.none &&
        _gameState.state[4] != Player.none &&
        _gameState.state[7] != Player.none) {
      if (_gameState.state[2] == _gameState.state[4] &&
          _gameState.state[4] == _gameState.state[7]) {
        _winner = _gameState.state[2];
      } else {
        _winner = Player.none;
      }
      return true;
    }

    return false;
  }

  Player get gameWinner => _winner;
}

class GameState {
  GameState.fromState(GameState state, int index, Player player) {
    _gameState = [...state.state];
    _gameState[index] = player;
  }

  GameState() {
    Map<int, Player> _gameState = {};
  }

  late List<Player> _gameState;
  List<Player> get state => _gameState;
}

enum Player { human, menace, none }
