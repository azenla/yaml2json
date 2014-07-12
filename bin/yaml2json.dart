import "dart:io";

import "package:yaml2json/yaml2json.dart";
import "package:args/args.dart";


main(List<String> args) {
  var parser = new ArgParser();
  parser.addOption("input", abbr: "i", help: "Input File");
  parser.addOption("output", abbr: "o", help: "Output File");
  parser.addFlag("pretty", abbr: "p", help: "Pretty Output", defaultsTo: true);
  parser.addFlag("help", abbr: "h", help: "Prints this Help Message", defaultsTo: false, negatable: false);
  var opts = parser.parse(args);
  if (opts["help"] || args.length == 0) {
    print("Usage: yaml2json [options]");
    print(parser.getUsage());
    exit(0);
  }
  var input = new File(opts["input"]);
  if (!input.existsSync()) {
    print("ERROR: No Such File: ${input.path}");
    exit(1);
  }
  var output = new File(opts["output"]);
  var data = input.readAsStringSync();
  if (output.existsSync()) {
    output.deleteSync();
  }
  output.createSync(recursive: true);
  output.writeAsStringSync(yaml2json(data, pretty: opts["pretty"]));
}