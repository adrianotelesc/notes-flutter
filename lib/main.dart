import 'package:flutter/material.dart';

import 'package:postnote/ui/app.dart';
import 'package:postnote/di/dependencies.dart';
import 'package:postnote/plugins/plugins.dart'
    if (dart.library.html) 'package:postnote/plugins/web_plugins.dart'
    if (dart.library.io) 'package:postnote/plugins/plugins.dart';

void main() {
  setUpPlugins();
  setUpDependencies();

  runApp(const PostnoteApp());
}
