library barrier.test.test_case;

import 'package:barrier/dsl.dart';

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
      });
    });
  }
}

void main() => run(runTests);