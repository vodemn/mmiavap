import 'package:lab7/init_data.dart';
import 'package:lab7/random.dart';
import 'package:lab7/seq.dart';

void main() {
  print('Алгоритм случайного поиска\n');
  randomMethod(ELEMENTS, 500);
  print('\nАлгоритм последовательного поиска\n');
  sequential(ELEMENTS);
}