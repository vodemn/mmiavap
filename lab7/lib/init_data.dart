import 'package:lab7/models.dart';

final Matrix POSITIONS = Matrix([[5, 6, 7], [2, 3, 4], [null, 1, null]]);

const Line A = Line('a', 2);
const Line B = Line('b', 2);
const Line C = Line('c', 2);
const Line D = Line('d', 3);
const Line E = Line('e', 2);
const Line F = Line('f', 3);
const Line G = Line('g', 2);

final List<Element> ELEMENTS = [
  Element('1', [A, B]),
  Element('2', [A, C]),
  Element('3', [B, C, D]),
  Element('4', [F, G]),
  Element('5', [D, F]),
  Element('6', [E, F, G]),
  Element('7', [D, E])
];