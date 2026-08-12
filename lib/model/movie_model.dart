import 'dart:convert';

MovieModel movieModelFromJson(String str) => MovieModel.fromJson(json.decode(str));

String movieModelToJson(MovieModel data) => json.encode(data.toJson());

class MovieModel {
    String id;
    String title;
    String year;
    String rating;
    String rated;
    String description;
    String image;
    String genre;

    MovieModel({
        required this.id,
        required this.title,
        required this.year,
        required this.rating,
        required this.rated,
        required this.description,
        required this.image,
        required this.genre,
    });

    factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json["id"],
        title: json["title"],
        year: json["year"],
        rating: json["rating"],
        rated: json["rated"],
        description: json["description"],
        image: json["image"],
        genre: json["genre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "year": year,
        "rating": rating,
        "rated": rated,
        "description": description,
        "image": image,
        "genre": genre,
    };
}
