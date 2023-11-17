// To parse this JSON data, do
//
//     final leAndDealModel = leAndDealModelFromJson(jsonString);

import 'dart:convert';

LeAndDealModel leAndDealModelFromJson(String str) => LeAndDealModel.fromJson(json.decode(str));


class LeAndDealModel {
  int? count;
  String? next;
  dynamic previous;
  List<Result>? results;

  LeAndDealModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory LeAndDealModel.fromJson(Map<String, dynamic> json) => LeAndDealModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

 
}

class Result {
  int? id;
  String? name;
  String? address;
  String? mobile;
  String? place;
  dynamic location;
  int? dealerAccount;

  Result({
    required this.id,
    required this.name,
    required this.address,
    required this.mobile,
    required this.place,
    required this.location,
    required this.dealerAccount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    mobile: json["mobile"],
    place: json["place"],
    location: json["location"],
    dealerAccount: json["dealer_account"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "mobile": mobile,
    "place": place,
    "location": location,
    "dealer_account": dealerAccount,
  };
}
