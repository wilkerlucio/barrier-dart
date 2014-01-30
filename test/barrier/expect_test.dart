library barrier.test.expect;

import "package:barrier/dsl.dart";
import 'package:barrier/src/expect/matchers.dart';
import 'package:barrier/src/expect/test_helpers.dart';

void runTests() {
  describe("Matchers", () {
    describe("BeEqualMatcher", () {
      it("correct match basic types and object references", () {
        Object obj = new Object();

        expect(new BeEqualMatcher(true)).to(beMatch(true));
        expect(new BeEqualMatcher(true)).toNot(beMatch(null));
        expect(new BeEqualMatcher(true)).toNot(beMatch(false));
        expect(new BeEqualMatcher(null)).toNot(beMatch(false));
        expect(new BeEqualMatcher(1)).to(beMatch(1));
        expect(new BeEqualMatcher(null)).to(beMatch(null));
        expect(new BeEqualMatcher(#sym)).to(beMatch(#sym));
        expect(new BeEqualMatcher(obj)).to(beMatch(obj));
        expect(new BeEqualMatcher([])).toNot(beMatch([]));
      });

      it('fails when comparing different things', () {
        expect(new BeEqualMatcher(true)).to(beFailedMatch(false, 'expected false to be equal true'));
        expect(new BeEqualMatcher(true)).toNot(beFailedMatch(true, 'expected true to not be equal true'));
      });
    });

    describe('BeFalseMatcher', () {
      it('test values against false', () {
        expect(new BeFalseMatcher()).to(beMatch(false));
        expect(new BeFalseMatcher()).toNot(beMatch(true));
        expect(new BeFalseMatcher()).toNot(beMatch(1));
        expect(new BeFalseMatcher()).toNot(beMatch(null));
        expect(new BeFalseMatcher()).to(beFailedMatch(null, 'expected null to be equal false'));
        expect(new BeFalseMatcher()).toNot(beFailedMatch(false, 'expected false to not be equal false'));
      });
    });

    describe('BeTrueMatcher', () {
      it('test values against true', () {
        expect(new BeTrueMatcher()).to(beMatch(true));
        expect(new BeTrueMatcher()).toNot(beMatch(false));
        expect(new BeTrueMatcher()).toNot(beMatch(1));
        expect(new BeTrueMatcher()).toNot(beMatch(null));
        expect(new BeTrueMatcher()).to(beFailedMatch(null, 'expected null to be equal true'));
        expect(new BeTrueMatcher()).toNot(beFailedMatch(true, 'expected true to not be equal true'));
      });
    });

    describe('BeDeepEqualMatcher', () {
      it('test values with deep comparing', () {
        expect(new BeDeepEqualMatcher(1)).to(beFailedMatch(2));
        expect(new BeDeepEqualMatcher(1)).to(beMatch(1));
        expect(new BeDeepEqualMatcher([])).to(beMatch([]));
        expect(new BeDeepEqualMatcher([1, 2])).to(beMatch([1, 2]));
        expect(new BeDeepEqualMatcher([[1], 2])).to(beMatch([[1], 2]));
        expect(new BeDeepEqualMatcher([])).toNot(beMatch([1]));
        expect(new BeDeepEqualMatcher([1, 2])).to(beFailedMatch([1], 'expected [1] to be deep equal [1, 2]'));
        expect(new BeDeepEqualMatcher([1])).toNot(beFailedMatch([1], 'expected [1] to not be deep equal [1]'));
      });
    });
  });
}

void main() => run(runTests);
