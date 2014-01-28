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
  });
}

void main() => run(runTests);