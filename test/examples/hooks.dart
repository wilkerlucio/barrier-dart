library barrier.examples.hooks;

import 'package:barrier/dsl.dart';

void runTests() {
  describe("Hook Examples", () {
    describe("Follow the counter!!", () {
      int counter = 0;

      before(() { expect(counter++) == 0; });
      after(() { expect(counter++) == 7; });

      it("is a test", () { expect(counter++) == 2; });

      before(() { expect(counter++) == 1; });

      describe("another inside one", () {
        before(() { expect(counter++) == 3; });
        after(() { expect(counter++) == 5; });

        it("is another test", () { expect(counter++) == 4; });
      });

      it("hello again", () { expect(counter++) == 6; });
      after(() { expect(counter++) == 8; });
    });

    List<Symbol> calls = [];
    int count = 0;

    describe("each each...", () {
      beforeEach(() { calls.add(#beforeOut); });
      afterEach(() { calls.add(#afterOut); });

      it("out test", () { calls.add(#outTest); });

      describe("inner scope", () {
        beforeEach(() { calls.add(#beforeInner); });
        afterEach(() { calls.add(#afterIn); });

        it("is some test", () { calls.add(#innerTest); });
      });

      it("out test after", () { calls.add(#outTestAfter); });
      beforeEach(() { calls.add(#beforeEnd); });
    });

    it("runs the beforeEach and afterEach on proper order", () {
      expect(calls).to(beDeepEqual([
        #beforeOut, #beforeEnd, #outTest, #afterOut,
        #beforeOut, #beforeEnd, #beforeInner, #innerTest, #afterIn, #afterOut,
        #beforeOut, #beforeEnd, #outTestAfter, #afterOut
      ]));
    });
  });
}

void main() => run(runTests);