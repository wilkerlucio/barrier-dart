library barrier.test.barrier_helpers;

import 'package:barrier/barrier.dart';
import 'dart:async';
import 'package:barrier/dsl.dart';

class MockFragment implements TestFragment {
  int callCount = 0;
  List<Symbol> callLog;
  Symbol logInfo;

  MockFragment([this.callLog, this.logInfo = #fragment]) {
    if (callLog == null)
        callLog = [];
  }

  Future run(Reporter reporter) {
    callCount += 1;
    callLog.add(logInfo);
    return new Future.value(null);
  }
}

class CallLogger {
  List<Symbol> calls;

  CallLogger() {
    calls = [];
  }

  Function hook(Symbol symbol) {
    return () { calls.add(symbol); };
  }

  TestFragment fragment(Symbol symbol) {
    return new MockFragment(calls, symbol);
  }
}

Future testFragmentRun(TestFragment fragment, CallLogger callLogger, List<Symbol> expected) {
  return fragment.run(new VoidReporter()).whenComplete(() { expect(callLogger.calls).eql(expected); });
}