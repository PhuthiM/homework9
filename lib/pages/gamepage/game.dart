import 'dart:math';

class Game {
  int _answer = Random().nextInt(100) + 1;
  int _totalGuesses = 0;
  String _list='';
  int _count = 0;

  Game() {
    print('the answer is $_answer');
  }

  int get totalGuesses {
    return _totalGuesses;
  }

  String get arrayList {
    return _list;
  }

  int doGuess(int num) {
    _totalGuesses++;
    if (num > _answer) {
      _list = _list + num.toString() + ' -> ';
      return 1;
    } else if (num < _answer) {
      _list = _list + num.toString() + ' -> ';
      return -1;
    } else {
      _list = _list + num.toString();
      return 0;
    }
  }
}
