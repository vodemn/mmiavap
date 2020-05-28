class Cell {
  int weight;
  String key;
  Coord coord;

  Cell.empty(this.coord) : weight = -1, key = '-';
  Cell(this.coord, this.weight, this.key);
  Cell.occupied(this.coord) : weight = null, key = '@';

  void clear() {
    this.weight = -1;
  }

  void occupy() {
    this.weight = null;
  }

  Cell copy() {
    return Cell(this.coord, this.weight, this.key);
  }

  bool get isEmpty => this.weight == -1;
  bool get isOccupied => this.weight == null;
  bool get isFree => !isEmpty && !isOccupied;
}

/// [1][*][*][4]
/// [2][*][*][5]
/// [3][*][*][6]

class Element {
  Coord first;
  Coord second;
  Coord third;
  Coord fourth;
  Coord fifth;
  Coord sixth;

  Element(
      {this.first,
      this.second,
      this.third,
      this.fourth,
      this.fifth,
      this.sixth});
}

class Line {
  String name;
  Coord start;
  Coord end;

  Line(this.name, this.start, this.end);

  int get length => this.start.distanceTo(this.end);
}

class Coord {
  int x;
  int y;

  Coord(this.x, this.y);

  Coord down() {
    return Coord(this.x, this.y + 1);
  }

  Coord left() {
    return Coord(this.x - 1, this.y);
  }

  Coord right() {
    return Coord(this.x + 1, this.y);
  }

  Coord up() {
    return Coord(this.x, this.y - 1);
  }

  int distanceTo(Coord to) {
    int result = 0;
    if (this.x > to.x) {
      result += this.x - to.x;
    } else {
      result += to.x - this.x;
    }
    if (this.y > to.y) {
      result += this.y - to.y;
    } else {
      result += to.y - this.y;
    }
    return result;
  }
}

class Matrix<T> {
  Matrix(this._values);

  final List<List<T>> _values;

  /// Returns the number of rows
  int get m => _values.length;

  /// Returns the number of columns
  int get n => _values[0].length;

  List<T> operator [](int m) => _values[m];

  /// [first] - row
  /// [last] - index
  List<int> indexOf(T value) {
    int x = 0;
    int y = 0;
    for (var row in _values) {
      if (row.contains(value)) {
        x = row.indexOf(value);
        y = _values.indexOf(row);
        return [x, y];
      }
    }

    return null;
  }

  void forEach(void f(T item)) {
    for (List<T> row in _values) {
      for (T item in row) {
        f(item);
      }
    }
  }

  void addRow(List<T> row) {
    _values.add(row);
  }

  void show() {
    _values.forEach((row) {
      String _row = ' ';
      row.forEach((item) {
        _row = _row + '${item} ';
      });
      print(_row);
    });
  }

  void swap(int indexA, int indexB) {
    List<T> tmp = this[indexA];
    this[indexA].clear();
    this[indexA].addAll(this[indexB]);
    this[indexB].clear();
    this[indexB].addAll(tmp);
  }
}

extension PrintCells on Matrix<Cell> {
  void showCells() {
    this._values.forEach((row) {
      String _row = ' ';
      row.forEach((item) {
        _row += item.key + ' ';
      });
      print(_row);
    });
  }

  void clearUnused() {
    this.forEach(
      (item) {
        if (item.isFree) {
          item.clear();
        }
      }
    );
  }

  bool isValidCoord(Coord coord) {
    return coord.x >= 0 && coord.x < this.n && coord.y >= 0 && coord.y < this.m;
  }

  Matrix<Cell> copy() {
    Matrix<Cell> result;
    for (int i = 0; i < this.m; i++) {
      List<Cell> row = [];
      for (int j = 0; j < this.n; j++) {
        Cell temp = this[i][j].copy();
        row.add(temp);
      }
      if (result == null) {
        result = Matrix<Cell>([row]);
      } else {
        result.addRow(row);
      }
    }
    return result;
  }
}
