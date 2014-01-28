library barrier.test.hello;

import 'package:barrier/barrier.dart';

void runTests() {
  for (int i = 0; i < 1; i++) {
    describe("Scope", () {
      it("simple runs it", () {
        expect(4) == 4;
      });

      describe("inner scope", () {
        it("has a test in it", () {

        });
      });

      it("fails mizerably...", () {
        expect(3) == 5;
      });
    });
  }
}

void main() => run(runTests);