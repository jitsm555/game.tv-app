import 'package:flutter/material.dart';
import 'package:game_tv_app/model/apis/api_response.dart';
import 'package:game_tv_app/model/repository/base_repository.dart';
import 'package:game_tv_app/model/tournaments_response.dart';
import 'package:game_tv_app/model/user_details_response.dart';
import 'package:game_tv_app/utils/share_preference_helper.dart';

//enum HOME_SCREEN_STATE { NO_INTERNET, SUCCESS, FAILURE }

class HomeViewModel extends ChangeNotifier {
  ApiResponse _tournament_Api_Response =
      ApiResponse.loading('Fetching artist data');
  ApiResponse _user_Api_Response = ApiResponse.loading('Fetching artist data');
  List<Tournament> _tournaments = [];
  String _cursor = "";

  ApiResponse get tournamentsResponse {
    return _tournament_Api_Response;
  }

  ApiResponse get userResponse {
    return _user_Api_Response;
  }

  /// Call the media service and gets the data of requested media data of
  /// an artist.
  Future<void> fetchTournamentsData() async {
    try {
      TournamentsResponse tournamentsResponse =
          await BaseRepository().getTournamentsData(cursor: _cursor);
      _cursor = tournamentsResponse.data.cursor;
      _tournaments.addAll(tournamentsResponse.data.tournaments);
      _tournament_Api_Response = ApiResponse.completed(_tournaments);
    } catch (e) {
      _tournament_Api_Response = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  Future<void> fetchUserDetails() async {
    try {
      UserDetails userDetailsResponse = await BaseRepository().getUserDetails();
      _user_Api_Response = ApiResponse.completed(userDetailsResponse);
    } catch (e) {
      _user_Api_Response = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  Future<void> loggedOut() async {
    await SharePreferenceHelper().setLoggedInStatus(false);
    notifyListeners();
  }
}
