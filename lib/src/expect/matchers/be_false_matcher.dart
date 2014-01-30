part of barrier.matchers;

class BeFalseMatcher extends Matcher {
  Future match(Expectation e) {
    return new BeEqualMatcher(false).match(e);
  }
}
