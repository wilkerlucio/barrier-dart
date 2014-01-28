library barrier.test.scope;

import 'package:barrier/dsl.dart';
import 'package:barrier/barrier.dart';
import 'dart:async';

class MockFragment implements TestFragment {
  int callCount = 0;

  Future run(Reporter reporter) {
    callCount += 1;
    return new Future.value(null);
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
      it("#runs the children of it", () {
        Scope scope = new Scope("title");
        MockFragment fragment = new MockFragment();
        scope.children.add(fragment);

        return scope.run(new VoidReporter()).then((v) { expect(fragment.callCount) == 1; });
      });
    });
  });
}

void main() => run(runTests);