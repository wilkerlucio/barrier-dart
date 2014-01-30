part of barrier.matchers;

class BeDeepEqualMatcher extends Matcher {
  dynamic expected;

  BeDeepEqualMatcher(this.expected);

  Future match(Expectation e) {
    e.assertMatch(_compareDynamics(e.actual, expected),
        message:       'expected ${e.actual} to be deep equal $expected',
        negateMessage: 'expected ${e.actual} to not be deep equal $expected'
    );
  }

  bool _compareDynamics(a, b) {
    bool equality;

    if (a is List && b is List)
      equality = _compareLists(a, b);
    else
      equality = a == b;

    return equality;
  }

  bool _compareLists(List a, List b) {
    if (a.length != b.length)
      return false;

    for (int i = 0; i < a.length; i++)
      if (_compareDynamics(a[i], b[i]) == false)
        return false;

    return true;
  }
}