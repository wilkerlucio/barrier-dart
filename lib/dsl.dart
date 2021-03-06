library barrier.dsl;

import 'package:barrier/barrier.dart';
export 'package:barrier/expect.dart';

typedef void RunBlock();

Suite suite = new Suite();

void run(RunBlock block) {
  block();

  DotsReporter reporter = new DotsReporter();
  suite.run(reporter);
}

void describe(String title, RunBlock block, {Map<Symbol,dynamic> flags}) {
  suite.describe(title, block, flags: flags);
}

void it(String title, RunBlock block, {Map<Symbol,dynamic> flags}) {
  suite.it(title, block, flags: flags);
}

void before(RunBlock block) {
  suite.hook(#before, block);
}

void after(RunBlock block) {
  suite.hook(#after, block);
}

void beforeEach(RunBlock block) {
  suite.hook(#beforeEach, block);
}

void afterEach(RunBlock block) {
  suite.hook(#afterEach, block);
}