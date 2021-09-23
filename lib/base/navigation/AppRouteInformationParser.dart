import 'package:first_flutter_project/base/navigation/routes.dart';
import 'package:flutter/widgets.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? "/");
    if (uri.pathSegments.length == 2) {
      switch (uri.pathSegments[1]) {
        case "zero":
          return AppRoutePath.zero();
        case "chat":
          return AppRoutePath.chat();
      }
    }
    return AppRoutePath.home();
  }

  @override
  RouteInformation restoreRouteInformation(AppRoutePath path) {
    switch (path.id) {
      case 0:
        return RouteInformation(location: "/zero");
      case 1:
        return RouteInformation(location: "/chat");
    }
    return RouteInformation(location: "/");
  }
}
