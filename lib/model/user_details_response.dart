class UserDetails {
  String name;
  int tournamentRating;
  int tournamentPlayed;
  int tournamentWon;
  int tournamentWinningPercentage;
  String imageUrl;

  UserDetails(
      {this.name,
        this.tournamentRating,
        this.tournamentPlayed,
        this.tournamentWon,
        this.tournamentWinningPercentage,
        this.imageUrl});

  UserDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tournamentRating = json['tournament_rating'];
    tournamentPlayed = json['tournament_played'];
    tournamentWon = json['tournament_won'];
    tournamentWinningPercentage = json['tournament_winning_percentage'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['tournament_rating'] = this.tournamentRating;
    data['tournament_played'] = this.tournamentPlayed;
    data['tournament_won'] = this.tournamentWon;
    data['tournament_winning_percentage'] = this.tournamentWinningPercentage;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
