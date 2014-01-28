part of barrier;

class Expectation {
  Object subject;

  Expectation(this.subject) {}

  operator ==(other) {
    if (subject != other)
      throw new Exception("$subject is not equal to $other");
  }
}

Expectation expect(Object subject) => new Expectation(subject);