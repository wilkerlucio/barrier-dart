library barrier.all_tests;

import 'package:barrier/dsl.dart';
import 'scope_test.dart' as scope;
import 'test_case_test.dart' as testCase;

void runTests() {
  scope.runTests();
  testCase.runTests();
}

void main() { run(runTests); }