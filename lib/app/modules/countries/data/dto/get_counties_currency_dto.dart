// To parse this JSON data, do
//
//     final getCountiesCurrencyDto = getCountiesCurrencyDtoFromJson(jsonString);

import 'dart:convert';

GetCountiesCurrencyDto getCountiesCurrencyDtoFromJson(String str) => GetCountiesCurrencyDto.fromJson(json.decode(str));

String getCountiesCurrencyDtoToJson(GetCountiesCurrencyDto data) => json.encode(data.toJson());

class GetCountiesCurrencyDto {
    Data? data;

    GetCountiesCurrencyDto({
        this.data,
    });

    factory GetCountiesCurrencyDto.fromJson(Map<String, dynamic> json) => GetCountiesCurrencyDto(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    List<Country>? countries;

    Data({
        this.countries,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        countries: json["countries"] == null ? [] : List<Country>.from(json["countries"]!.map((x) => Country.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "countries": countries == null ? [] : List<dynamic>.from(countries!.map((x) => x.toJson())),
    };
}

class Country {
    String? code;
    String? emoji;
    String? capital;
    String? currency;
    String? name;

    Country({
        this.code,
        this.emoji,
        this.capital,
        this.currency,
        this.name,
    });

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        code: json["code"],
        emoji: json["emoji"],
        capital: json["capital"],
        currency: json["currency"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "emoji": emoji,
        "capital": capital,
        "currency": currency,
        "name": name,
    };
}
