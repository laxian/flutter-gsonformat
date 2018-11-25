
import 'dart:convert';

import 'constant.dart';
import 'entity_writer.dart';

class EntityWriterBuilder {
  bool json_serializable_support = false;
  bool filename_camel_to_underline = true;
  bool _show_verbose = false;
  String _name;
  String _path;
  var _json;

  EntityWriterBuilder name(String name) {
    _name = name;
    return this;
  }

  EntityWriterBuilder json(dynamic json) {
    _json = json;
    return this;
  }

  EntityWriterBuilder jsonStr(String json_str) {
    _json = jsonDecode(json_str);
    return this;
  }
  
  EntityWriterBuilder supportJsonSerializable(bool a) {
    json_serializable_support = a;
    return this;
  }

  EntityWriterBuilder verbose(bool enable) {
    _show_verbose = enable;
    return this;
  }

  EntityWriterBuilder outpath(String path) {
    _path = path;
    return this;
  }

  EntityWriter build() {
    var ew = EntityWriter();
    ew.setName(_name);
    ew.setJson(_json);
    ew.addHeaders([ConstStr.AUTHOR]);
    ew.setSupportJsonSerialization(json_serializable_support);
    ew.setShowVerbose(_show_verbose);

    if (json_serializable_support) {
      ew.addHeaders(ConstStr.INSERT_HEADER);
      ew.setDecorators(ConstStr.INSERT_DECORATOR);
      ew.setInserts(ConstStr.INSERT_IN_CLASS);
    }
    ew.setOutputDir(_path);
    //ew.convert();
    return ew;
  }
}