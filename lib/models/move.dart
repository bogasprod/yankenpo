import 'dart:math';

enum Move { rock, paper, scissors }

extension MoveExtension on Move {
  static Move random() {
    final moves = Move.values;
    return moves[Random().nextInt(moves.length)];
  }

  bool beats(Move other) {
    return (this == Move.rock && other == Move.scissors) ||
           (this == Move.paper && other == Move.rock) ||
           (this == Move.scissors && other == Move.paper);
  }

  String get assetPath {
    switch (this) {
      case Move.rock:
        return 'assets/images/rock.png';
      case Move.paper:
        return 'assets/images/paper.png';
      case Move.scissors:
        return 'assets/images/scissors.png';
    }
  }
}
