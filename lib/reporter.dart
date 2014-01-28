part of barrier;

class Reporter {
  DateTime _startTime;
  int _testCount = 0;
  int _passCount = 0;
  int _failCount = 0;

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

  void testFail(TestCase test, dynamic err) {
    _failCount += 1;
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

    if (_failCount > 0)
      print("$_failCount failing");
  }
}

abstract class TestFragment {
  Future run(Reporter reporter);
}

class DotsReporter extends Reporter {
  void testPass(TestCase test) {
    super.testPass(test);

    stdout.write(".");
  }

  void testFail(TestCase test, err) {
    super.testFail(test, err);

    stdout.write("F");
  }

  void suiteEnd() {
    print("");

    super.suiteEnd();
  }
}