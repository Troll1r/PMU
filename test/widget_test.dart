import 'package:flutter_test/flutter_test.dart';

import 'package:pmu/main.dart';

void main() {
  test('Box хранит элементы и умеет фильтровать', () {
    final box = Box<int>()
      ..add(1)
      ..add(2)
      ..add(3);

    expect(box.items, <int>[1, 2, 3]);
    expect(box.where((value) => value.isOdd), <int>[1, 3]);
  });
}
