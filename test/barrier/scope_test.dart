library barrier.test.scope;

import 'package:barrier/dsl.dart';
import 'package:barrier/barrier.dart';
import 'test_helpers.dart';

void runTests() {
  describe("Scope", () {
    describe("fullTitle", () {
      it("returns the title when there is no parent", () {
        Scope scope = new Scope("title", null);
        expect(scope.fullTitle).to(beEqual("title"));
      });

      it('returns parent titles concateneted', () {
        Scope root = new Scope('master', null);
        Scope child = new Scope('slave', root);

        expect(child.fullTitle).to(beEqual('master slave'));
      });

      it('truncates the final string', () {
        Scope root = new Scope('', null);
        Scope child = new Scope('slave', root);

        expect(child.fullTitle).to(beEqual('slave'));
      });
    });

    describe("#run", () {
      it("runs the children of it", () {
        CallLogger calls = new CallLogger();

        Scope scope = new Scope("title", null);
        scope.children.add(calls.fragment(#fragment));
        scope.children.add(calls.fragment(#fragment2));

        return testFragmentRun(scope, calls, [#fragment, #fragment2]);
      });

      describe("before filters", () {
        it("runs before filter before the test", () {
          CallLogger calls = new CallLogger();

          Scope scope = new Scope("", null);
          scope.addHook(#before, calls.hook(#beforeFilter));
          scope.children.add(calls.fragment(#test));

          return testFragmentRun(scope, calls, [#beforeFilter, #test]);
        });

        it("respect run order on multilevel", () {
          CallLogger calls = new CallLogger();

          Scope scope = new Scope("", null);
          scope.addHook(#before, calls.hook(#level1));
          scope.children.add(calls.fragment(#test));
          Scope scope2 = new Scope("", scope);
          scope2.addHook(#before, calls.hook(#level2));
          scope.addHook(#before, calls.hook(#level1out));

          return testFragmentRun(scope, calls, [#level1, #level1out, #test, #level2]);
        });
      });

      describe("after filters", () {
        it("runs after filter after the test", () {
          CallLogger calls = new CallLogger();

          Scope scope = new Scope("", null);
          scope.addHook(#after, calls.hook(#afterFilter));
          scope.children.add(calls.fragment(#test));

          return testFragmentRun(scope, calls, [#test, #afterFilter]);
        });

        it("respect run order on multilevel", () {
          CallLogger calls = new CallLogger();

          Scope scope = new Scope("", null);
          scope.addHook(#after, calls.hook(#level1));
          Scope scope2 = new Scope("", scope);
          scope.children.add(calls.fragment(#test));
          scope2.addHook(#after, calls.hook(#level2));
          scope.addHook(#after, calls.hook(#level1out));

          return testFragmentRun(scope, calls, [#level2, #test, #level1, #level1out]);
        });
      });
    });
  });
}

void main() => run(runTests);