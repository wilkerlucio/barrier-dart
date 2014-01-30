library barrier.expect;

import 'package:barrier/src/expect/expectation.dart';
import 'package:barrier/src/expect/matchers.dart';

/**
 * Starts an expectation
 */
Expectation expect(dynamic subject) => new Expectation(subject);

/**
 * Compares if two objects are equal by using the == operator
 */
BeEqualMatcher beEqual(to) => new BeEqualMatcher(to);

/**
 *
 */
BeDeepEqualMatcher beDeepEqual(to) => new BeDeepEqualMatcher(to);

/**
 *
 */
BeTrueMatcher beTrue() => new BeTrueMatcher();

/**
 *
 */
BeFalseMatcher beFalse() => new BeFalseMatcher();

BeRejectedMatcher beRejected() => new BeRejectedMatcher();