library barrier.all_tests;

import 'package:barrier/dsl.dart';
import 'scope_test.dart' as scope;
import 'test_case_test.dart' as testCase;
import 'expect_test.dart' as expect;

void runTests() {
  scope.runTests();
  testCase.runTests();
  expect.runTests();
}

void main() { run(runTests); }