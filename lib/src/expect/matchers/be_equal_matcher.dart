part of barrier.matchers;

class BeEqualMatcher extends Matcher {
  dynamic expected;

  BeEqualMatcher(this.expected);

  Future match(Expectation e) {
    e.assertMatch(
      e.actual == expected,
      message:       "expected ${e.actual} to be equal $expected",
      negateMessage: "expected ${e.actual} to not be equal $expected"
    );
  }
}