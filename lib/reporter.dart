part of barrier;

abstract class Reporter {
  void suiteStart();
  void suiteEnd();
  void scopeStart(Scope scope);
  void scopeEnd(Scope scope);
  void testStart(TestCase test);
  void testEnd(TestCase test);
  void testPass(TestCase test);
  void testFail(TestCase test, Error err);
}

abstract class ReportableRunnable {
  Future run(Reporter reporter);
}

class SimpleReporter extends Reporter {
  void scopeEnd(Scope scope) {
    print("Scope ended ${scope.title}");
  }

  void scopeStart(Scope scope) {
    print("Scope started ${scope.title}");
  }

  void testEnd(TestCase test) {
    print("Test end ${test.fullTitle}");
  }

  void testStart(TestCase test) {
    print("Test start ${test.fullTitle}");
  }

  void testFail(TestCase test, err) {
    print("Test failed $err");
  }

  void testPass(TestCase test) {
    print("Test passed ${test.fullTitle}");
  }

  void suiteEnd() {
    print("Suite ended");
  }

  void suiteStart() {
    print("Suite started");
  }
}