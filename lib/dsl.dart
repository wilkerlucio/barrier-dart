library barrier.dsl;

import 'package:barrier/barrier.dart';

typedef void RunBlock();

Suite suite = new Suite();

void run(RunBlock block) {
  block();

  DotsReporter reporter = new DotsReporter();
  suite.run(reporter);
}

void describe(String title, RunBlock block) {
  suite.describe(title, block);
}

void it(String title, RunBlock block) {
  suite.it(title, block);
}

void before(RunBlock block) {
  suite.hook(#before, block);
}

void after(RunBlock block) {
  suite.hook(#after, block);
}

Expectation expect(dynamic subject) => new Expectation(subject);