part of barrier;

class Scope implements ReportableRunnable {
  String title;
  Scope parent;
  List<ReportableRunnable> children;
  
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
    
    List<Future> childrenFutures = children.map((child) => child.run(reporter)).toList(growable: false); 
    return Future.wait(childrenFutures).then((value) {
      reporter.scopeEnd(this);
      return value;
    });
  }
  
  Map toJSON() => {
    'title': title,
    'children': children.map((c) => c.toJSON())
  };
}