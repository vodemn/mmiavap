class Line {
  final String name;

  /// Number of [elements] connected with [this]
  final int pins;

  final double weight;

  const Line(this.name, this.pins, {this.weight = 100});

  double get weightCoeff => weight / pins;
}

class Element {
  final String name;

  /// Number of [lines], connected to [this]
  final List<Line> lines;

  Element(this.name, this.lines);

  double connectionWeightTo(Element j) {
    double weight = 0;
    this.lines.forEach((line) {
      if (j.lines.contains(line)) {
        weight += line.weightCoeff;
      }
    });
    return weight;
  }
}

extension PrintElements on List<Element> {
  void show() {
    List<String> _names = [];
    this.forEach((element) => _names.add(element.name));
    print(_names);
  }
}

class Matrix {
  Matrix(this._values);

  final List<List<num>> _values;

  /// Returns the number of rows
  int get m => _values.length;

  /// Returns the number of columns
  int get n => _values[0].length;

  List<num> operator [](int m) => _values[m];

  Matrix.fill(int m, int n, [double fillValue = 0.0]) : _values = _createMatrix(m, n, fillValue);

  /// [first] - row
  /// [last] - index
  List<int> indexOf(num value) {
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
  
  /// multiply by elemnts
  Matrix operator *(Matrix other) {
    Matrix toReturn = new Matrix.fill(m, n);
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        toReturn[i][j] = this[i][j] * other[i][j];
      }
    }
    return toReturn;
  }

  static List<List<double>> _createMatrix(int m, int n, double fill) {
    List<List<double>> result = List<List<double>>();
    for (int i = 0; i < m; i++) {
      List<double> sub = [];
      for (int j = 0; j < n; j++) {
        sub.add(fill);
      }
      result.add(sub);
    }
    return result;
  }

  void forEach(void f(num item)) {
    for (List<num> row in _values) {
      for (num item in row) {
        f(item);
      }
    }
  }

  void addRow(List<num> row) {
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
    List<num> tmp = this[indexA];
    this[indexA].clear();
    this[indexA].addAll(this[indexB]);
    this[indexB].clear();
    this[indexB].addAll(tmp);
  }
}

extension Length on List<num> {

  num get sum {
    num _res = 0;
    for (num item in this) {
      _res += item;
    }
    return _res;
  }

  num _abs(num value) {
    if (value < 0) {
      return value * -1;
    } else {
      return value;
    }
  }

  num relativeLengthTo(List<num> to) {
    return _abs(this.first - to.first) + _abs(this.last - to.last);
  }
}

extension Swap on List {
  void swap(int indexA, int indexB) {
    dynamic tmp = this[indexA];
    this[indexA] = this[indexB];
    this[indexB] = tmp;
  }
}

class Attempt {
  final List<int> positions;
  final double resultSum;

  Attempt(this.positions, this.resultSum);
}

extension AttemptsValues on List<Attempt> {
  Attempt max() {
    Attempt value = this.first;
    for (Attempt item in this) {
      if (value.resultSum < item.resultSum) {
        value = item;
      }
    }
    return value;
  }

  Attempt min() {
    Attempt value = this.first;
    for (Attempt item in this) {
      if (value.resultSum > item.resultSum) {
        value = item;
      }
    }
    return value;
  }
}