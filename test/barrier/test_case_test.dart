library barrier.test.test_case;

import 'package:barrier/dsl.dart';
import 'package:barrier/barrier.dart';
import 'test_helpers.dart';

void runTests() {
  describe("TestCase", () {
    describe("#constructor", () {
      Function fn = () {};

      it("initializes without flags", () {
        Scope scope = new Scope("", null);
        TestCase tcase = new TestCase("title", fn, scope);

        expect(tcase.title) == "title";
        expect(tcase.block) == fn;
        expect(tcase.parent) == scope;
      });

      it("initializes with flags", () {
        Scope scope = new Scope("", null);
        TestCase tcase = new TestCase("title", fn, scope, flags: {#timeout: 3000});

        expect(tcase.getFlag(#timeout)) == 3000;
      });
    });

    describe("#run", () {
      it("simply runs the provided task", () {
        CallLogger calls = new CallLogger();

        Scope scope = new Scope("", null);
        TestCase tcase = new TestCase("title", calls.hook(#block), scope);

        testFragmentRun(tcase, calls, [#block]);
      });
    });
  });
}

void main() => run(runTests);