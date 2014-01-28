library barrier.test;

import 'package:barrier/dsl.dart';
import 'barrier/all_tests.dart' as barrier;

void main() {
  run(() {
    barrier.runTests();
  });
}