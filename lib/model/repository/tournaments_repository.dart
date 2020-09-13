import 'package:game_tv_app/model/repository/base_repository.dart';
import 'package:game_tv_app/model/services/tournaments_service.dart';
import 'package:game_tv_app/model/services/user_login_validation.dart';
import 'package:game_tv_app/model/tournaments_response.dart';
import 'package:game_tv_app/model/user_details_response.dart';
import 'package:game_tv_app/utils/constants.dart';

class TournamentsRepository implements BaseRepository {
  final _tournamentService = TournamentService();

  @override
  Future<TournamentsResponse> getTournamentsData({String cursor}) async {
    final String url = cursor == null
        ? Constants.GAME_TV_URL + Constants.LIMIT_COUNT.toString()
        : Constants.GAME_TV_URL +
            Constants.LIMIT_COUNT.toString() + '&cursor=' + cursor;

    print("Tournament Details Request Url: " + url);
    dynamic response = await _tournamentService.getRequest(url);
    final tournamentsResponse = TournamentsResponse.fromJson(response);
    return Future.value(tournamentsResponse);
  }

  @override
  Future<UserDetails> getUserDetails() async {
    print("User Details Request Url: " + Constants.USER_DETAIL_URL);
    dynamic response =
        await _tournamentService.getRequest(Constants.USER_DETAIL_URL);
    final userDetails = UserDetails.fromJson(response);
    return Future.value(userDetails);
  }

  @override
  bool verifyUser(String phoneNumber, String password) {
    return UserLogInValidation().checkUserInfo(phoneNumber, password);
  }
}
