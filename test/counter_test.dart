import 'package:restaurant_app/counter.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  test('Counter value should be incremented', () {
    final counter = Counter();
    counter.increment();
    expect(counter.value, 9);
  });
}
//test/counter_test.dart