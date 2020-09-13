import 'dart:convert';
import 'dart:io';

import '../apis/app_exception.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class TournamentService {
  factory TournamentService() {
    return _instance;
  }

  TournamentService._internal();

  static final TournamentService _instance = TournamentService._internal();

  Future<dynamic> getRequest(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(url);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
