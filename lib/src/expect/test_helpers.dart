library barrier.expect.test_helpers;

import 'dart:async';
import 'package:barrier/src/expect/expectation.dart';
import 'package:barrier/src/expect/matchers.dart';

class FakeExpectation extends Expectation {
  bool expression = false;
  bool inversed;
  String message;
  String negateMessage;

  FakeExpectation(this.inversed, [actual]) : super(actual);

  void assertMatch(bool expression , {String message, String negateMessage}) {
    this.expression = inversed ? !expression : expression;
    this.message = message;
    this.negateMessage = negateMessage;
  }
}

class MatchPositiveMatcher extends Matcher {
  dynamic expected;

  MatchPositiveMatcher(this.expected);

  Future match(Expectation e) {
    Matcher matcher = e.actual;
    FakeExpectation exp = new FakeExpectation(e.inverted, expected);
    matcher.match(exp);

    new Expectation(exp.expression).to(new BeTrueMatcher());
  }
}

class MatchNegativeMatcher extends Matcher {
  dynamic expected;
  String expectedError;

  MatchNegativeMatcher(this.expected, [this.expectedError]);

  Future match(Expectation e) {
    Matcher matcher = e.actual;
    FakeExpectation exp = new FakeExpectation(e.inverted, expected);
    matcher.match(exp);

    String message = e.inverted ? exp.negateMessage : exp.message;

    new Expectation(exp.expression).to(new BeFalseMatcher());

    if (expectedError != null)
      new Expectation(message).to(new BeEqualMatcher(expectedError));
  }
}

MatchPositiveMatcher beMatch(expected) => new MatchPositiveMatcher(expected);
MatchNegativeMatcher beFailedMatch(expected, [String errorMessage]) => new MatchNegativeMatcher(expected, errorMessage);