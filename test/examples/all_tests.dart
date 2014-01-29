library barrier.examples.all_tests;

import 'package:barrier/dsl.dart';
import 'hooks.dart' as hooks;

void runTests() {
  hooks.runTests();
}

void main() { run(runTests); }