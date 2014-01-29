library barrier.test;

import 'package:barrier/dsl.dart';
import 'barrier/all_tests.dart' as barrier;
import 'examples/all_tests.dart' as examples;

void main() {
  run(() {
    barrier.runTests();
    examples.runTests();
  });
}