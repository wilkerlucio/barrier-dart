part of barrier.matchers;

class BeTrueMatcher extends Matcher {
  Future match(Expectation e) {
    return new BeEqualMatcher(true).match(e);
  }
}
