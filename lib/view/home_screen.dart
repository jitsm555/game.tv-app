import 'package:flutter/material.dart';
import 'package:game_tv_app/model/apis/api_response.dart';
import 'package:game_tv_app/model/tournaments_response.dart';
import 'package:game_tv_app/model/user_details_response.dart';
import 'package:game_tv_app/utils/constants.dart';
import 'package:game_tv_app/utils/localization/application_localizations.dart';
import 'package:game_tv_app/view/login_screen.dart';
import 'package:game_tv_app/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String home_screen_route = "Home_Screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _nextPageThreshold = 5;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeViewModel>(context).fetchUserDetails();
      Provider.of<HomeViewModel>(context).fetchTournamentsData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
            child: ListView(
          children: [
            ListTile(
              title: Text(ApplicationLocalizations.of(context).translate('log_out')),
              onTap: () {
                Provider.of<HomeViewModel>(context).loggedOut();
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginScreen.login_screen_route,
                    (Route<dynamic> route) => false);
              },
            )
          ],
        )),
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text(
            ApplicationLocalizations.of(context).translate('title'),
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: _customIconTheme(),
        ),
        body: _buildTournamentDetails());
  }

  Widget _buildTournamentDetails() {
    var userApiResponse = Provider.of<HomeViewModel>(context).userResponse;
    var tournamentApiResponse =
        Provider.of<HomeViewModel>(context).tournamentsResponse;
    var userStatus = userApiResponse.status;
    var tournamentStatus = tournamentApiResponse.status;
    var _tournaments;
    var _userDetails;
    if (Status.LOADING == userStatus || Status.LOADING == tournamentStatus) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (Status.ERROR == userStatus || Status.ERROR == tournamentStatus) {
      return Center(
        child: Text(userApiResponse.message),
      );
    } else if (Status.COMPLETED == userStatus ||
        Status.ERROR == tournamentStatus) {
      _tournaments = tournamentApiResponse.data as List<Tournament>;
      _userDetails = userApiResponse.data as UserDetails;

      return CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(_userDetails.imageUrl),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                              child: Text(_userDetails.name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.9))),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.blue),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(32)),
                                ),
                                padding: EdgeInsets.all(4),
                                margin: EdgeInsets.all(4),
                                child: Row(
                                  children: [
                                    Padding(
                                      child: Text(
                                        _userDetails.tournamentRating
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue),
                                      ),
                                      padding: EdgeInsets.all(4),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                                      child: Text(
                                        ApplicationLocalizations.of(context).translate('elo_rating'),
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.orange,
                                        Colors.orange.withOpacity(0.5)
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight),
                                  borderRadius: BorderRadius.horizontal(
                                      left: const Radius.circular(16))),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(
                                    _userDetails.tournamentPlayed.toString(),
                                    style: tournamentNumberTextStyle,
                                  ),
                                  Text(
                                    ApplicationLocalizations.of(context).translate('tournament_played'),
                                    textAlign: TextAlign.center,
                                    style: tournamentDetailsTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                    Colors.deepPurple,
                                    Colors.deepPurple.withOpacity(0.5)
                                  ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight)),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(
                                    _userDetails.tournamentWon.toString(),
                                    style: tournamentNumberTextStyle,
                                  ),
                                  Text(
                                    ApplicationLocalizations.of(context).translate('tournament_won'),
                                    textAlign: TextAlign.center,
                                    style: tournamentDetailsTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.deepOrange,
                                        Colors.deepOrange.withOpacity(0.5)
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight),
                                  borderRadius: BorderRadius.horizontal(
                                      right: const Radius.circular(16))),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(
                                    "${_userDetails.tournamentWinningPercentage}%",
                                    style: tournamentNumberTextStyle,
                                  ),
                                  Text(
                                    ApplicationLocalizations.of(context).translate('win_percentage'),
                                    textAlign: TextAlign.center,
                                    style: tournamentDetailsTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_tournaments.length > 0)
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: Text(
                              ApplicationLocalizations.of(context).translate('recommended_for_you'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              )
            ]),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index == _tournaments.length - _nextPageThreshold) {
                Provider.of<HomeViewModel>(context).fetchTournamentsData();
              }
              if (index == _tournaments.length) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (index > _tournaments.length) {
                return null;
              }
              return _buildRow(_tournaments[index]);
            }),
          ),
        ],
      );
    }
    return Container();
  }

  Widget _buildRow(Tournament tournament) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/tournament_placeholder.png',
            image: tournament.coverUrl,
            height: 100,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        tournament.name,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.7)),
                      ),
                      Text(
                        tournament.gameName,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            height: 1.5,
                            fontSize: 13,
                            color: Colors.black.withOpacity(0.6)),
                      )
                    ],
                  )),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconThemeData _customIconTheme() {
    ThemeData original = ThemeData.light();
    return original.iconTheme.copyWith(color: Colors.black);
  }

  final TextStyle tournamentNumberTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 17,
    height: 1.25,
    fontWeight: FontWeight.w500,
  );
  final TextStyle tournamentDetailsTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 12,
      height: 1.25,
      fontWeight: FontWeight.w400);
}
