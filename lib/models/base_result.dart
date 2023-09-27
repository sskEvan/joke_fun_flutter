import 'package:joke_fun_flutter/generated/json/base/json_convert_content.dart';

///convert和FlutterJsonBeanFactory结合解析
class BaseResult<T> {
  T? data;
  int? code;
  String? msg;

  BaseResult({this.data, this.code, this.msg});

  BaseResult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null&&json['data']!='null') {
      try {
        data = JsonConvert.fromJsonAsT<T>(json['data']);
      }catch (e) {
        /// fix List<String>
        data = List<String>.from(json['data']) as T;
      }
    }
    code = json['code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data;
    }
    data['code'] = this.code;
    data['msg'] = this.msg;
    return data;
  }

  bool isSuccess() => code == 200;

  bool isEmpty() {
    if(data == null) {
      return true;
    } else {
      if(data is List) {
        return (data as List).isEmpty;
      }
      return false;
    }
  }

  bool noMoreData(int pageSize) {
    if(data == null) {
      return true;
    } else {
      if(data is List) {
        return (data as List).length < pageSize;
      }
      return false;
    }
  }
}