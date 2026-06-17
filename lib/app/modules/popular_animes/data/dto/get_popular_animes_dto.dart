// To parse this JSON data, do
//
//     final getPopularAnimeDto = getPopularAnimeDtoFromJson(jsonString);

import 'dart:convert';

GetPopularAnimeDto getPopularAnimeDtoFromJson(String str) => GetPopularAnimeDto.fromJson(json.decode(str));

String getPopularAnimeDtoToJson(GetPopularAnimeDto data) => json.encode(data.toJson());

class GetPopularAnimeDto {
    Data? data;

    GetPopularAnimeDto({
        this.data,
    });

    factory GetPopularAnimeDto.fromJson(Map<String, dynamic> json) => GetPopularAnimeDto(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    Page? page;

    Data({
        this.page,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json["Page"] == null ? null : Page.fromJson(json["Page"]),
    );

    Map<String, dynamic> toJson() => {
        "Page": page?.toJson(),
    };
}

class Page {
    List<Media>? media;

    Page({
        this.media,
    });

    factory Page.fromJson(Map<String, dynamic> json) => Page(
        media: json["media"] == null ? [] : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x.toJson())),
    };
}

class Media {
    int? id;
    Title? title;
    CoverImage? coverImage;
    String? description;

    Media({
        this.id,
        this.title,
        this.coverImage,
        this.description,
    });

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        title: json["title"] == null ? null : Title.fromJson(json["title"]),
        coverImage: json["coverImage"] == null ? null : CoverImage.fromJson(json["coverImage"]),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title?.toJson(),
        "coverImage": coverImage?.toJson(),
        "description": description,
    };
}

class CoverImage {
    String? large;

    CoverImage({
        this.large,
    });

    factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
        large: json["large"],
    );

    Map<String, dynamic> toJson() => {
        "large": large,
    };
}

class Title {
    String? english;
    String? native;

    Title({
        this.english,
        this.native,
    });

    factory Title.fromJson(Map<String, dynamic> json) => Title(
        english: json["english"],
        native: json["native"],
    );

    Map<String, dynamic> toJson() => {
        "english": english,
        "native": native,
    };
}
