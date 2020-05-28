import 'package:lab8/models.dart';

final Element ONE = Element(
    first: Coord(14 - 1, 21),
    second: Coord(14 - 1, 22),
    third: Coord(14 - 1, 23),
    fourth: Coord(17 + 1, 21),
    fifth: Coord(17 + 1, 22));

final Element TWO = Element(
    second: Coord(5 - 1, 14),
    fifth: Coord(8 + 1, 14));

final Element THREE = Element(
    second: Coord(23 - 1, 14),
    fifth: Coord(26 + 1, 14));

final Element FOUR = Element(
    second: Coord(14 - 1, 6),
    fifth: Coord(17 + 1, 6));

final Element FIVE = Element(
    first: Coord(5 - 1, 5),
    second: Coord(5 - 1, 6),
    fifth: Coord(8 + 1, 6));

final Element SIX = Element(
    first: Coord(14 - 1, 13),
    second: Coord(14 - 1, 14),
    fifth: Coord(17 + 1, 14));

final Element SEVEN = Element(
    first: Coord(23 - 1, 5),
    second: Coord(23 - 1, 6),
    fifth: Coord(26 + 1, 6));

List<Line> LINES = [
  Line('a', ONE.first, TWO.second),
  Line('b', THREE.second, TWO.fifth),
  Line('c', ONE.fourth, THREE.fifth),
  Line('d', ONE.second, FOUR.second),
  Line('e', FIVE.second, FOUR.fifth),
  Line('f', ONE.fifth, FIVE.fifth),
  Line('g', ONE.third, SIX.second),
  Line('h', SIX.fifth, SEVEN.second),
  Line('i', FIVE.first, SEVEN.fifth)
];

Matrix<Cell> generateInitFront() {
  Matrix<Cell> _matrix;
  for (int i = 1; i <= 29; i++) {
    List<Cell> _row = [];
    for (int j = 1; j <= 32; j++) {
      if ((((i >= 6 && i <= 8) || (i >= 14 && i <= 16)) && ((j >= 6 && j <= 9) || (j >= 15 && j <= 18) || (j >= 24 && j <= 27))) ||
          ((i >= 22 && i <= 24) && ((j >= 0 && j <= 9) || (j >= 15 && j <= 18) || (j >= 24 && j <= 32))) ||
          ((i >= 25 && i <= 29) && ((j >= 0 && j <= 9) || (j >= 24 && j <= 32)))) {
        _row.add(Cell.occupied(Coord(j - 1, i - 1)));
      } else {
        _row.add(Cell.empty(Coord(j - 1, i - 1)));
      }
    }
    if (_matrix == null) {
      _matrix = Matrix([_row]);
    } else {
      _matrix.addRow(_row);
    }
  }
  return _matrix;
}

Matrix<Cell> generateInitBack() {
  Matrix<Cell> _matrix;
  for (int i = 1; i <= 29; i++) {
    List<Cell> _row = [];
    for (int j = 1; j <= 32; j++) {
      if ((((i >= 6 && i <= 8) || (i >= 14 && i <= 16)) && (j == 6 || j == 9 || j == 15 || j == 18 || j == 24 || j == 27)) ||
          ((i >= 22 && i <= 24) && ((j >= 0 && j <= 9) || (j == 15 || j == 18) || (j >= 24 && j <= 32))) ||
          ((i >= 25 && i <= 29) && ((j >= 0 && j <= 9) || (j >= 24 && j <= 32)))) {
        _row.add(Cell.occupied(Coord(j - 1, i - 1)));
      } else {
        _row.add(Cell.empty(Coord(j - 1, i - 1)));
      }
    }
    if (_matrix == null) {
      _matrix = Matrix([_row]);
    } else {
      _matrix.addRow(_row);
    }
  }
  return _matrix;
}
