import 'dart:convert';

MovieModel movieModelFromJson(String str) => MovieModel.fromJson(json.decode(str));

String movieModelToJson(MovieModel data) => json.encode(data.toJson());

class MovieModel {
    String id;
    String title;
    String year;
    String rated;
    String released;
    String runtime;
    String genre;
    String director;
    String writer;
    String actors;
    String plot;
    String language;
    String country;
    String awards;
    String poster;
    String imdbRating;
    String imdbId;
    String boxOffice;

    MovieModel({
        required this.id,
        required this.title,
        required this.year,
        required this.rated,
        required this.released,
        required this.runtime,
        required this.genre,
        required this.director,
        required this.writer,
        required this.actors,
        required this.plot,
        required this.language,
        required this.country,
        required this.awards,
        required this.poster,
        required this.imdbRating,
        required this.imdbId,
        required this.boxOffice,
    });

    factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json["id"],
        title: json["title"],
        year: json["year"],
        rated: json["rated"],
        released: json["released"],
        runtime: json["runtime"],
        genre: json["genre"],
        director: json["director"],
        writer: json["writer"],
        actors: json["actors"],
        plot: json["plot"],
        language: json["language"],
        country: json["country"],
        awards: json["awards"],
        poster: json["poster"],
        imdbRating: json["imdbRating"],
        imdbId: json["imdbId"],
        boxOffice: json["boxOffice"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "year": year,
        "rated": rated,
        "released": released,
        "runtime": runtime,
        "genre": genre,
        "director": director,
        "writer": writer,
        "actors": actors,
        "plot": plot,
        "language": language,
        "country": country,
        "awards": awards,
        "poster": poster,
        "imdbRating": imdbRating,
        "imdbId": imdbId,
        "boxOffice": boxOffice,
    };
}
