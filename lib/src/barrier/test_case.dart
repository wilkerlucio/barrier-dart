part of barrier;

class TestCase extends Object with NestedFlaggable<dynamic> implements TestFragment {
  String title;
  Function block;
  Scope parent;

  TestCase(this.title, this.block, this.parent, {Map<Symbol,dynamic> flags}) {
    parent.children.add(this);
    updateFlags(flags);
  }

  String get fullTitle => "${parent.fullTitle} $title";

  bool get isPending => block == null;

  Map toJSON() => {
    'title': title
  };

  Future run(Reporter reporter) {
    reporter.testStart(this);

    return parent.runHooks(beforeEachHooks)
                 .then(runBlock(reporter))
                 .then((v) => parent.runHooks(afterEachHooks));
  }

  Function runBlock(Reporter reporter) {
    return (v) {
      return new Future.sync(block).then((value) {
        reporter.testPass(this);
        reporter.testEnd(this);
      });
    };
  }

  List<Function> get beforeEachHooks => parent.getHooksWithAncestors(#beforeEach).reversed.expand((v) => v).toList();
  List<Function> get afterEachHooks => parent.getHooksWithAncestors(#afterEach).expand((v) => v).toList();
}