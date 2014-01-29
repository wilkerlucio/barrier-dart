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

        return testFragmentRun(tcase, calls, [#block]);
      });

      describe("beforeEach hook", () {
        it("runs it before the test", () {
          CallLogger calls = new CallLogger();

          Scope scope = new Scope("", null);
          scope.addHook(#beforeEach, calls.hook(#be));
          TestCase tcase = new TestCase("title", calls.hook(#block), scope);

          return testFragmentRun(tcase, calls, [#be, #block]);
        });

        it("correct runs into multiple levels", () {
          CallLogger calls = new CallLogger();

          Scope scope = new Scope("", null);
          scope.addHook(#beforeEach, calls.hook(#be));
          Scope scope2 = new Scope("", scope);
          scope2.addHook(#beforeEach, calls.hook(#beInner));
          new TestCase("title", calls.hook(#block), scope2);
          new TestCase("title", calls.hook(#blockOut), scope);

          return testFragmentRun(scope, calls, [#be, #beInner, #block, #be, #blockOut]);
        });
      });

      describe("afterEach hook", () {
        it("runs it after the test", () {
          CallLogger calls = new CallLogger();

          Scope scope = new Scope("", null);
          TestCase tcase = new TestCase("title", calls.hook(#block), scope);
          scope.addHook(#afterEach, calls.hook(#be));

          return testFragmentRun(tcase, calls, [#block, #be]);
        });

        it("correct runs into multiple levels", () {
          CallLogger calls = new CallLogger();

          Scope scope = new Scope("", null);
          scope.addHook(#afterEach, calls.hook(#be));
          Scope scope2 = new Scope("", scope);
          scope2.addHook(#afterEach, calls.hook(#beInner));
          new TestCase("title", calls.hook(#block), scope2);
          new TestCase("title", calls.hook(#blockOut), scope);

          return testFragmentRun(scope, calls, [#block, #beInner, #be, #blockOut, #be]);
        });
      });

      describe("calls the methos on correct order into the reporter", () {

      });
    });
  });
}

void main() => run(runTests);