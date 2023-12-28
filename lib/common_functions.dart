
import 'dart:io';

import 'main.dart';

bool iOSCondition(double dH) => Platform.isIOS && dH > 850;
pop([data]) => navigatorKey.currentState!.pop(data);