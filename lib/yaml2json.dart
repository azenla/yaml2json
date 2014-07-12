library yaml2json;

import "package:yaml/yaml.dart";
import "dart:convert";

class Yaml2JsonConverter extends Converter<String, String> {  
  String indent;
  bool pretty;
  
  Yaml2JsonConverter({this.pretty: true, this.indent: "    "});
  
  @override
  String convert(String input) {
    JsonEncoder encoder;
    if (pretty) {
      encoder = new JsonEncoder.withIndent(indent);
    } else {
      encoder = new JsonEncoder();
    }
    return encoder.convert(loadYaml(input));
  }
}

String yaml2json(String yaml, {bool pretty: true, String indent: "    "}) {
  return new Yaml2JsonConverter(pretty: pretty, indent: indent).convert(yaml);
}