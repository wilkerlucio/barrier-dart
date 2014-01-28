part of barrier;

class TestCase implements ReportableRunnable {
  String title;
  Function block;
  Scope parent;

  TestCase(this.title, this.block, this.parent) {
    parent.children.add(this);
  }

  String get fullTitle => "${parent.fullTitle} $title";

  bool get isPending => block == null;

  Map toJSON() => {
    'title': title
  };

  Future run(Reporter reporter) {
    reporter.testStart(this);
    return new Future.sync(block).then((value) {
      reporter.testPass(this);
    }).catchError((e) {
      reporter.testFail(this, e);
    }).whenComplete(() {
      reporter.testEnd(this);
    });
  }
}