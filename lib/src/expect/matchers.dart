library barrier.matchers;

import 'expectation.dart';
import 'dart:async';

part 'matchers/be_equal_matcher.dart';
part 'matchers/be_true_matcher.dart';
part 'matchers/be_false_matcher.dart';
part 'matchers/be_deep_equal_matcher.dart';

class BeRejectedMatcher extends Matcher {
  Future match(Expectation e) {
    return (e.actual as Future).then((v) {
      e.assertMatch(false,
        message:       'expected ${e.actual} to get reject',
        negateMessage: 'expected ${e.actual} to not get rejected');
    }, onError: (err) {});
  }
}