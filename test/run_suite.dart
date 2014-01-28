library barrier.test;

import 'package:barrier/barrier.dart';
import 'hello_test.dart' as hello;
import 'scope_test.dart' as scope;

void main() {
  run(() {
    hello.runTests();
    scope.runTests();
  });
}