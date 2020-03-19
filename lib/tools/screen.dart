/*
* @auther : Mark
* @date : 2020-03-19
* @ide : VSCode
*/

import 'package:flutter/services.dart';

/// Screen functions
class MScreen {
  MethodChannel _methodChannel = MethodChannel("mark.screen");

  Future keepOn({bool toOn = false}) async {
    return _methodChannel.invokeMethod("keepOn", {"on": toOn});
  }
}
