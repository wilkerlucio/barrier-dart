part of barrier;

class Expectation {
  dynamic subject;

  Expectation(this.subject) {}

  operator ==(other) {
    if (subject != other)
      throw new Exception("$subject is not equal to $other");
  }

  void eql(other) {
    if (subject is List && other is List)
      try {
        _compareLists(subject, other);
      } catch(err) {
        throw new Exception("$subject is not deep equal $other");
      }
    else
      this == other;
  }

  Future reject() {
    return subject.then((v) { throw new Exception("expected to be rejected."); }, onError: (e) {});
  }
}

void _compareLists(List subject, List other) {
  if (subject.length != other.length)
    throw new Exception();

  for (int i = 0; i < subject.length; i++)
    expect(subject[i]).eql(other[i]);
}

Expectation expect(Object subject) => new Expectation(subject);