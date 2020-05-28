import 'package:lab8/models.dart';
import 'package:lab8/init_data.dart';

void main() {
  // Разметка пространства платы
  Matrix<Cell> _matrixFront = generateInitFront();
  Matrix<Cell> _matrixBack = generateInitBack();
  print('Лицевая сторона схемы');
  _matrixFront.showCells();
  print('\nОбратная сторона схемы');
  _matrixBack.showCells();

  // Установка очередности трассировки соединений
  for (int i = 0; i < LINES.length; i++) {
    for (int j = 0; j < LINES.length - 1; j++) {
      if (LINES[j].length > LINES[j + 1].length) {
        Line tmp = LINES[j];
        LINES[j] = LINES[j + 1];
        LINES[j + 1] = tmp;
      }
    }
  }

  for (int i = 0; i < LINES.length; i++) {
    print('${LINES[i].name}: ${LINES[i].length}');
  }
  print('');

  // Распространение волны
  for (int i = 0; i < LINES.length; i++) {
    Line _currentLine = LINES[i];
    Matrix<Cell> _frontSave = _matrixFront.copy();
    Matrix<Cell> _backSave = _matrixBack.copy();
    Coord start = _currentLine.start;
    Coord end = _currentLine.end;

    int lengthFront;
    _frontSave[start.y][start.x].weight = 0;
    bool _foundEndFront = _spreadWave(_frontSave, start, end);
    if (_foundEndFront) {
      lengthFront = _buildConnection(_frontSave, start, end, _currentLine.name);
    }
    _frontSave.clearUnused();

    int lengthBack = 0;
    _backSave[start.y][start.x].weight = 0;
    bool _foundEndBack = _spreadWave(_backSave, start, end);
    if (_foundEndBack) {
      lengthBack = _buildConnection(_backSave, start, end, _currentLine.name);
    }
    _backSave.clearUnused();

    if (!_foundEndFront) {
      _matrixBack = null;
      _matrixBack = _backSave.copy();
    } else if (!_foundEndBack) {
      _matrixFront = null;
      _matrixFront = _frontSave.copy();
    } else {
      if (lengthFront < lengthBack) {
        _matrixFront = null;
        _matrixFront = _frontSave.copy();
      } else {
        _matrixBack = null;
        _matrixBack = _backSave.copy();
      }
    }
  }
  print('Лицевая сторона схемы');
  _matrixFront.showCells();
  print('\nОбратная сторона схемы');
  _matrixBack.showCells();
}

// распространяем волну
bool _spreadWave(Matrix<Cell> matrix, Coord currentCoord, Coord end) {
  bool resultD;
  bool resultL;
  bool resultR;
  bool resultU;

  bool foundEnd = false;

  int i = 0;
  while (!foundEnd) {
    int found = 0;
    matrix.forEach((item) {
      if (item.weight == i) {
        Coord currentCoord = item.coord;
        resultD = _checkCell(matrix, currentCoord.down(), end, i + 1);
        if (resultD == null) {
          foundEnd = true;
        } else {
          found++;
        }
        resultL = _checkCell(matrix, currentCoord.left(), end, i + 1);
        if (resultL == null) {
          foundEnd = true;
        } else {
          found++;
        }
        resultR = _checkCell(matrix, currentCoord.right(), end, i + 1);
        if (resultR == null) {
          foundEnd = true;
        } else {
          found++;
        }
        resultU = _checkCell(matrix, currentCoord.up(), end, i + 1);
        if (resultU == null) {
          foundEnd = true;
        } else {
          found++;
        }
      }
    });
    if (found == 0) {
      return false;
    }
    i++;
  }

  return foundEnd;
}

bool _checkCell(Matrix<Cell> matrix, Coord currentCoord, Coord end, int i) {
  if (matrix.isValidCoord(currentCoord)) {
    if (matrix[currentCoord.y][currentCoord.x].weight == -1) {
      matrix[currentCoord.y][currentCoord.x].weight = i;
      if (currentCoord.x == end.x && currentCoord.y == end.y) {
        // нашли конец
        return null;
      }
      // нашли пустую ячейку
      return true;
    } else {
      // нашли занятую ячейку
      return false;
    }
  } else {
    // нашли занятую ячейку
    return false;
  }
}

// строим линию
int _buildConnection(Matrix<Cell> matrix, Coord start, Coord end, String name) {
  bool resultD;
  bool resultL;
  bool resultR;
  bool resultU;

  Coord currentCoord = end;

  int length = 0;

  while (currentCoord.x != start.x || currentCoord.y != start.y) {
    resultD = _buildConnectionSegment(matrix, currentCoord, currentCoord.down(), name);
    if (!resultD) {
      resultL = _buildConnectionSegment(matrix, currentCoord, currentCoord.left(), name);
      if (!resultL) {
        resultR = _buildConnectionSegment(matrix, currentCoord, currentCoord.right(), name);
        if (!resultR) {
          resultU = _buildConnectionSegment(matrix, currentCoord, currentCoord.up(), name);
          if (resultU) {
            currentCoord = currentCoord.up();
            length++;
          }
        } else {
          currentCoord = currentCoord.right();
            length++;
        }
      } else {
        currentCoord = currentCoord.left();
            length++;
      }
    } else {
      currentCoord = currentCoord.down();
      length++;
    }
  }
  matrix[end.y][end.x].occupy();
  matrix[end.y][end.x].key = name;
  matrix[start.y][start.x].occupy();
  matrix[start.y][start.x].key = name;

  return length;
}

bool _buildConnectionSegment(Matrix<Cell> matrix, Coord cur, Coord to, String name) {
  bool success = false;
  if (matrix.isValidCoord(to)) {
    if (matrix[to.y][to.x].isFree) {
      int curWeight = matrix[cur.y][cur.x].weight;
      int toWeight = matrix[to.y][to.x].weight;
      if (toWeight < curWeight) {
        matrix[cur.y][cur.x].occupy();
        matrix[cur.y][cur.x].key = name;
        success = true;
      }
    }
  }

  return success;
}
