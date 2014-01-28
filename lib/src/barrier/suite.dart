part of barrier;

class Suite {
  Scope rootScope;
  List<Scope> children;

  Suite() {
    rootScope = new Scope(null, null);
    children = [rootScope];
  }

  Scope get currentScope => children.last;

  Scope describe(String title, Function block, {Map<Symbol,dynamic> flags}) {
    Scope scope = new Scope(title, currentScope, flags: flags);

    if (block != null) {
      children.add(scope);
      block();
      children.removeLast();
    }

    return scope;
  }

  TestCase it(String title, Function block, {Map<Symbol,dynamic> flags}) {
    return new TestCase(title, block, currentScope, flags: flags);
  }

  void hook(Symbol hookType, Function hook) {
    currentScope.addHook(hookType, hook);
  }

  Future run(Reporter reporter) {
    reporter.suiteStart();
    rootScope.run(reporter).then((value) { reporter.suiteEnd(); });
  }

  Map toJSON() => rootScope.toJSON();
}