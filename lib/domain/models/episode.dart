
import 'dart:convert';

Episode episodeFromJson(String str) => Episode.fromJson(json.decode(str));

String episodeToJson(Episode data) => json.encode(data.toJson());

class Episode {
    Episode({
        this.airDate,
        this.episodeNumber,
        this.id,
        this.name,
        this.overview,
        this.productionCode,
        this.runtime,
        this.seasonNumber,
        this.showId,
        this.stillPath,
        this.voteAverage,
        this.voteCount,
        this.crew,
        this.guestStars,
    });

    DateTime? airDate;
    int? episodeNumber;
    int? id;
    String? name;
    String? overview;
    String? productionCode;
    int? runtime;
    int? seasonNumber;
    int? showId;
    String? stillPath;
    double? voteAverage;
    int? voteCount;
    List<Crew>? crew;
    List<dynamic>? guestStars;

    factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        airDate: json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        runtime: json["runtime"],
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
        crew: json["crew"] == null ? null : List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
        guestStars: json["guest_stars"] == null ? null : List<dynamic>.from(json["guest_stars"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "air_date": airDate == null ? null : "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "runtime": runtime,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "crew": crew == null ? null : List<dynamic>.from(crew!.map((x) => x.toJson())),
        "guest_stars": guestStars == null ? null : List<dynamic>.from(guestStars!.map((x) => x)),
    };
}

class Crew {
    Crew({
        this.job,
        this.department,
        this.creditId,
        this.adult,
        this.gender,
        this.id,
        this.knownForDepartment,
        this.name,
        this.originalName,
        this.popularity,
        this.profilePath,
    });

    String? job;
    String? department;
    String? creditId;
    bool? adult;
    int? gender;
    int? id;
    String? knownForDepartment;
    String? name;
    String? originalName;
    double? popularity;
    String? profilePath;

    factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        job: json["job"],
        department: json["department"],
        creditId: json["credit_id"],
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"] == null ? null : json["popularity"].toDouble(),
        profilePath: json["profile_path"],
    );

    Map<String, dynamic> toJson() => {
        "job": job,
        "department": department,
        "credit_id": creditId,
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
    };
}
