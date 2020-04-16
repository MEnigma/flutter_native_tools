/*
* @auther : Mark
* @date : 2020-04-09
* @ide : VSCode
*/

import 'package:flutter/services.dart';
import 'package:native_tools/models/response.dart';

class MFileTools {
  MethodChannel _fileMethodChannel = MethodChannel("mark.tools.file");

  /// 复制文件
  Future<MFileResponse> copyFile(String filePath, String savePath) async {
    return MFileResponse(await _fileMethodChannel.invokeMethod(
        "_copyFile", {"filePath": filePath ?? "", "savePath": savePath ?? ""}));
  }
}
