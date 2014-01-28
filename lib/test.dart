part of barrier;

typedef void RunBlock();

Suite suite = new Suite();

void run(RunBlock block) {
  block();

  DotsReporter reporter = new DotsReporter();
  reporter.suiteStart();
  suite.rootScope.run(reporter).then((value) { reporter.suiteEnd(); });
}

void describe(String title, RunBlock block) {
  suite.describe(title, block);
}

void it(String title, RunBlock block) {
  suite.it(title, block);
}