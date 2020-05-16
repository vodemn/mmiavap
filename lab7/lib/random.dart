import 'package:lab7/init_data.dart';
import 'package:lab7/models.dart';

void randomMethod(List<Element> elements, int numberOfAttempts) {
  List<Attempt> attemptsResults = [];
  for (int k = 0; k < numberOfAttempts; k++) {
    attemptsResults.add(_random(elements));
  }

  print('Количество попыток: ${attemptsResults.length}');
  final bestAttemp = attemptsResults.indexOf(attemptsResults.min());
  print('Лучшая попытка №$bestAttemp');
  print('Суммарная взвешенная длина соединений: ${attemptsResults[bestAttemp].resultSum}');
  for (int i = 0; i < elements.length; i++) {
    print('${elements[i].name} -> ${attemptsResults[bestAttemp].positions[i]}');
  }

  final worst = attemptsResults.indexOf(attemptsResults.max());
  print('Худшая попытка №$worst');
  print('Суммарная взвешенная длина соединений: ${attemptsResults[worst].resultSum}');
  for (int i = 0; i < elements.length; i++) {
    print('${elements[i].name} -> ${attemptsResults[worst].positions[i]}');
  }
}

Attempt _random(List<Element> elements) {
  double sum = 0;
  List<int> positions = [2, 3, 4, 5, 6, 7];
  positions.shuffle();
  positions.insert(0, 1);
  for (int i = 0; i < elements.length; i++) {
    for (int j = 0; j < elements.length; j++) {
      final coordOfCurrent = POSITIONS.indexOf(positions[i]);
      final coordOfConnecting = POSITIONS.indexOf(positions[j]);
      sum += elements[i].connectionWeightTo(elements[j]) * coordOfCurrent.relativeLengthTo(coordOfConnecting);
    }
  }
  return Attempt(positions, sum);
}
