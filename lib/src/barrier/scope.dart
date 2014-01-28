part of barrier;

class Scope implements TestFragment {
  String title;
  Scope parent;
  List<TestFragment> children;

  Scope(this.title, [this.parent]) {
    children = new List();

    if (parent != null)
      parent.children.add(this);
  }

  String get fullTitle {
    if (parent != null)
      return "${parent.fullTitle} $title";
    else
      return title;
  }

  Future run(Reporter reporter) {
    reporter.scopeStart(this);

    return fg.sequence(children, (child) => child.run(reporter)).then((value) {
      reporter.scopeEnd(this);
      return value;
    });
  }

  Map toJSON() => {
    'title': title,
    'children': children.map((c) => c.toJSON())
  };
}