import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';

void setUpPlugins() {
  usePathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;
}
