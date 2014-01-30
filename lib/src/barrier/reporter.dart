part of barrier;

class Reporter {
  DateTime _startTime;
  int _testCount = 0;
  int _passCount = 0;

  void suiteStart() {
    _startTime = new DateTime.now();
  }

  void scopeStart(Scope scope) {}

  void testStart(TestCase test) {
    _testCount += 1;
  }

  void testPass(TestCase test) {
    _passCount += 1;
  }

  void testEnd(TestCase test) {}

  void scopeEnd(Scope scope) {}

  void suiteEnd() {
    print("");
    print(summary());
  }

  String summary() {
    Duration difference = new DateTime.now().difference(_startTime);

    print("$_passCount passing (${difference.inMilliseconds}ms)");
  }
}

abstract class TestFragment {
  Future run(Reporter reporter);
}

class DotsReporter extends Reporter {
  void testPass(TestCase test) {
    super.testPass(test);

    print(test.fullTitle);
  }

  void suiteEnd() {
    super.suiteEnd();
  }
}

class VoidReporter extends Reporter {
  void suiteStart() {}
  void scopeStart(Scope scope) {}
  void testStart(TestCase test) {}
  void testPass(TestCase test) {}
  void testFail(TestCase test, dynamic err) {}
  void testEnd(TestCase test) {}
  void scopeEnd(Scope scope) {}
  void suiteEnd() {}
}