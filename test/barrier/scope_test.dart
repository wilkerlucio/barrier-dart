library barrier.test.scope;

import 'package:barrier/dsl.dart';
import 'package:barrier/barrier.dart';
import 'dart:async';

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

void runTests() {
  describe("Scope", () {
    describe("#constructor", () {
      it("initializes", () {
        expect(true) == true;
      });
    });

    describe("#run", () {
      Future testScopeRun(Scope scope, CallLogger callLogger, List<Symbol> expected) {
        return scope.run(new VoidReporter()).whenComplete(() { expect(callLogger.calls).eql(expected); });
      }

      it("runs the children of it", () {
        CallLogger calls = new CallLogger();

        Scope scope = new Scope("title");
        scope.children.add(calls.fragment(#fragment));
        scope.children.add(calls.fragment(#fragment2));

        return testScopeRun(scope, calls, [#fragment, #fragment2]);
      });

      describe("before filters", () {
        it("runs before filter before the test", () {
          CallLogger calls = new CallLogger();

          Scope scope = new Scope("");
          scope.addHook(#before, calls.hook(#beforeFilter));
          scope.children.add(calls.fragment(#test));

          return testScopeRun(scope, calls, [#beforeFilter, #test]);
        });

        it("respect run order on multilevel", () {
          CallLogger calls = new CallLogger();

          Scope scope = new Scope("");
          scope.addHook(#before, calls.hook(#level1));
          scope.children.add(calls.fragment(#test));
          Scope scope2 = new Scope("", scope);
          scope2.addHook(#before, calls.hook(#level2));
          scope.addHook(#before, calls.hook(#level1out));

          return testScopeRun(scope, calls, [#level1, #level1out, #test, #level2]);
        });
      });

      describe("after filters", () {
        it("runs after filter after the test", () {
          CallLogger calls = new CallLogger();

          Scope scope = new Scope("");
          scope.addHook(#after, calls.hook(#afterFilter));
          scope.children.add(calls.fragment(#test));

          return testScopeRun(scope, calls, [#test, #afterFilter]);
        });

        it("respect run order on multilevel", () {
          CallLogger calls = new CallLogger();

          Scope scope = new Scope("");
          scope.addHook(#after, calls.hook(#level1));
          Scope scope2 = new Scope("", scope);
          scope.children.add(calls.fragment(#test));
          scope2.addHook(#after, calls.hook(#level2));
          scope.addHook(#after, calls.hook(#level1out));

          return testScopeRun(scope, calls, [#level2, #test, #level1, #level1out]);
        });
      });
    });
  });
}

void main() => run(runTests);