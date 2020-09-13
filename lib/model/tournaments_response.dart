class TournamentsResponse {
  int code;
  Data data;
  bool success;

  TournamentsResponse({this.code, this.data, this.success});

  TournamentsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String cursor;
  Null tournamentCount;
  List<Tournament> tournaments;
  bool isLastBatch;

  Data({this.cursor, this.tournamentCount, this.tournaments, this.isLastBatch});

  Data.fromJson(Map<String, dynamic> json) {
    cursor = json['cursor'];
    tournamentCount = json['tournament_count'];
    if (json['tournaments'] != null) {
      tournaments = new List<Tournament>();
      json['tournaments'].forEach((v) {
        tournaments.add(new Tournament.fromJson(v));
      });
    }
    isLastBatch = json['is_last_batch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cursor'] = this.cursor;
    data['tournament_count'] = this.tournamentCount;
    if (this.tournaments != null) {
      data['tournaments'] = this.tournaments.map((v) => v.toJson()).toList();
    }
    data['is_last_batch'] = this.isLastBatch;
    return data;
  }
}

class Tournament {
  String name;
  String coverUrl;

  String gameName;

  Tournament({
    this.name,
    this.coverUrl,
    this.gameName,
  });

  Tournament.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    coverUrl = json['cover_url'];
    gameName = json['game_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['cover_url'] = this.coverUrl;
    data['game_name'] = this.gameName;
    return data;
  }
}
