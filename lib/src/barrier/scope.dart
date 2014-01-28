part of barrier;

class Scope extends Object with NestedFlaggable<dynamic> implements TestFragment {
  String title;
  Scope parent;
  List<TestFragment> children;
  Map<Symbol, List<Function>> hooks;

  Scope(this.title, this.parent, {Map<Symbol,dynamic> flags}) {
    updateFlags(flags);

    children = new List();
    hooks = new Map<Symbol, List<Function>>();

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

    return runHooks(getHooks(#before))
      .then((v) {
        return fg.sequence(children, (child) => child.run(reporter)).then((value) {
          reporter.scopeEnd(this);
          return value;
        });
      }).then((v) {
        return runHooks(getHooks(#after)).then((x) => v);
      });
  }

  Future runHooks(List<Function> hooks) {
    return fg.sequence(hooks, (Function hook) => new Future.sync(hook));
  }

  void addHook(Symbol hookType, Function hook) {
    getHooks(hookType).add(hook);
  }

  List<Function> getHooks(Symbol hookType) {
    if (hooks[hookType] == null)
      hooks[hookType] = [];

    return hooks[hookType];
  }

  Map toJSON() => {
    'title': title,
    'children': children.map((c) => c.toJSON())
  };
}