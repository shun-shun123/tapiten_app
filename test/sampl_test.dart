import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sample test', () {
    final sampleTestUnit = SampleTestUnit();
    expect(sampleTestUnit.i, 0);

    sampleTestUnit.increment();
    expect(sampleTestUnit.i, 1);

    sampleTestUnit.decrement();
    expect(sampleTestUnit.i, 0);
  });
}

class SampleTestUnit {
  var i = 0;

  void increment() {
    i++;
  }

  void decrement() {
    i--;
  }
}
