/*
* @auther : Mark
* @date : 2020-04-08
* @ide : VSCode
*/

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:native_tools/models/response.dart';

/// 媒体相关
class MMediaTools {
  MethodChannel _mediaMethodChannel = MethodChannel("mark.tools.media");

  /// 转换mov 到 mp4 [iOS only]
  Future<MMediaResponse> transformMovToMp4(String movPath,
      {String savePath}) async {
    if (Platform.isIOS) {
      return MMediaResponse(await _mediaMethodChannel.invokeMethod(
          "_transformMovToMp4",
          {"movPath": movPath ?? "", "savePath": savePath ?? ""}));
    } else {
      return MMediaResponse.fail();
    }
  }

  /// 压缩图片
  Future<String> imageCompress(String path, {int maxSize = 500 * 1024}) async {
    MMediaResponse res = MMediaResponse(await _mediaMethodChannel.invokeMethod(
        "_imageCompress",
        {"path": path ?? "", "maxSize": maxSize ?? 500 * 1024}));
    if (res.succeed) {
      return res.savePath;
    } else {
      return null;
    }
  }
}
