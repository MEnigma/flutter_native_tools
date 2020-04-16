/*
* @auther : Mark
* @date : 2020-04-08
* @ide : VSCode
*/

/// native 返回结果
class MResponse {
  MResponse(this.data);
  MResponse.fail({this.data});
  final Map data;

  /// 源数据
  Map get resData => data ?? {};

  /// 操作是否成功
  bool get succeed => resData['succeed'] ?? false;

  /// 失败原因
  String get reason => resData['reason'] ?? "";

  /// 状态码
  int get code => resData['code'] ?? 0;

  /// 动态数据
  Map get result => resData['result'] ?? {};
}

/// 媒体结果
class MMediaResponse extends MResponse {
  MMediaResponse(Map data) : super(data);
  MMediaResponse.fail() : super.fail();

  /// 导出的路径
  String get savePath => resData['savePath'] ?? "";

  /// 选择的媒体路径
  String get filePath => resData['filePath'] ?? "";

  /// 转换状态码
  MMovToMp4ResCode get movToMp4ResCode => MMovToMp4ResCode.values[code];

  /// 多文件
  List<String> get selectedFiles => resData['selectedFiles'] ?? [];

  /// 多文件导出的路径
  List<String> get saveFiles => resData['saveFiles'] ?? [];
}

class MFileResponse extends MMediaResponse {
  MFileResponse(Map data) : super(data);
  MFileResponse.fail() : super.fail();
}

/// mov转mp4状态码
enum MMovToMp4ResCode {
  failed,
  succeed,
  timeout,
}
