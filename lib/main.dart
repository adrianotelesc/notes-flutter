import 'package:flutter/material.dart';

import 'package:postnote/app.dart';
import 'package:postnote/dependencies.dart';
import 'package:postnote/plugins/plugins.dart'
    if (dart.library.html) 'package:postnote/plugins/web_plugins.dart'
    if (dart.library.io) 'package:postnote/plugins/plugins.dart';

void main() {
  setUpPlugins();
  setUpDependencies();

  runApp(PostnoteApp());
}
