library barrier.expectation;

import 'package:flagger/flagger.dart';
import 'dart:async';

abstract class Matcher {
  Future match(Expectation e);
}

class Expectation extends Object with Flaggable<dynamic> {
  dynamic actual;

  bool inverted = false;

  Expectation(this.actual);

  operator ==(expected) {
    assertMatch(
      actual == expected,
      message:       "expected $actual to be equal to $expected",
      negateMessage: "expected $actual to not be equal to $expected"
    );
  }

  Future to(Matcher matcher) {
    return matcher.match(this);
  }

  Future toNot(Matcher matcher) {
    inverted = !inverted;

    return matcher.match(this);
  }

  void assertMatch(bool expression , {String message, String negateMessage}) {
    if (expression == inverted) {
      message = inverted ? negateMessage : message;

      throw new Exception(message);
    }
  }
}