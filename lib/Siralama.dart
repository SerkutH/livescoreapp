import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class Siralama extends StatefulWidget {
  final String code;

  const Siralama({required this.code});

  @override
  _SiralamaState createState() => _SiralamaState();
}

class _SiralamaState extends State<Siralama> {
  List? _table;

  getTable() async {
    http.Response response = await http.get(
        'http://api.football-data.org/v2/competitions/${widget.code}/standings',
        headers: {'X-Auth-Token': '08af73a4e3f94411874eb92b9eb2957f'});
    String body = response.body;
    Map data = jsonDecode(body);
    List table = data['standings'][0]['table'];
    setState(() {
      _table = table;
    });
  }

  Widget buildTable() {
    List<Widget> teams = [];
    for (var team in _table!) {
      teams.add(
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    team['position'].toString().length > 1
                        ? Text(team['position'].toString() + ' - ')
                        : Text(" " + team['position'].toString() + ' - '),
                    Row(
                      children: [
                        team['team']['name'].toString().length > 22
                            ? Text(team['team']['name']
                            .toString()
                            .substring(0, 11) +
                            '...')
                            : Text(team['team']['name'].toString()),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(team['playedGames'].toString()),
                    Text(team['won'].toString()),
                    Text(team['draw'].toString()),
                    Text(team['lost'].toString()),
                    Text(team['goalDifference'].toString()),
                    Text(team['points'].toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      children: teams,
    );
  }

  @override
  void initState() {
    super.initState();
    getTable();
  }

  @override
  Widget build(BuildContext context) {
    return _table == null
        ? Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(0xFFe70066),
          ),
        ),
      ),
    )
        : Scaffold(
      body: Container(
        decoration: BoxDecoration(),
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Pos',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Club',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'PL',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'W',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'D',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'L',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'GD',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Pts',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            buildTable(),
          ],
        ),
      ),
    );
  }
}
