// To parse this JSON data, do
//
//     final distName = distNameFromJson(jsonString);

import 'dart:convert';

DistName distNameFromJson(String str) => DistName.fromJson(json.decode(str));

String distNameToJson(DistName data) => json.encode(data.toJson());

class DistName {
  List<DistNameResult> results;

  DistName({
    required this.results,
  });

  factory DistName.fromJson(Map<String, dynamic> json) => DistName(
    results: List<DistNameResult>.from(json["results"].map((x) => DistNameResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class DistNameResult {
  int id;
  String name;
  String shortCode;

  DistNameResult({
    required this.id,
    required this.name,
    required this.shortCode,
  });

  factory DistNameResult.fromJson(Map<String, dynamic> json) => DistNameResult(
    id: json["id"],
    name: json["name"],
    shortCode: json["short_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "short_code": shortCode,
  };
}
