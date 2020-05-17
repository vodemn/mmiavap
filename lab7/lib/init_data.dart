import 'package:lab7/models.dart';

final Matrix POSITIONS = Matrix([[5, 6, 7], [2, 3, 4], [null, 1, null]]);

const Line A = Line('a', 2);
const Line B = Line('b', 2);
const Line C = Line('c', 2);
const Line D = Line('d', 2);
const Line E = Line('e', 2);
const Line F = Line('f', 2);
const Line G = Line('g', 3);
const Line H = Line('h', 3);
const Line I = Line('i', 2);

final List<Element> ELEMENTS = [
  Element('1', [A, C, D, F, G]),
  Element('2', [A, B]),
  Element('3', [B, C]),
  Element('4', [D, E]),
  Element('5', [E, F, I]),
  Element('6', [G, H]),
  Element('7', [H, I])
];