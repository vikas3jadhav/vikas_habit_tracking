class RouteNames {
  static const String dashboard = 'dashboard';
  static const String categories = 'categories';
}

extension GoRouterPath on String {
  String path()=> '/$this';
}