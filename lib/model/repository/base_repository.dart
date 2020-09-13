import 'package:game_tv_app/model/repository/tournaments_repository.dart';
import 'package:game_tv_app/model/tournaments_response.dart';
import 'package:game_tv_app/model/user_details_response.dart';


abstract class BaseRepository {
  factory BaseRepository(){
    return TournamentsRepository();
  }

  Future<UserDetails> getUserDetails();

  Future<TournamentsResponse> getTournamentsData({String cursor});

  bool verifyUser(String phoneNumber, String password);

}

