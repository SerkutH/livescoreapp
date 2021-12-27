import 'package:flutter/material.dart';
import 'myContainer.dart';
import 'Siralama.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leagues'),
        centerTitle: true,
      ),
      backgroundColor: Colors.lightBlue,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Siralama(code: 'PL'),
                          ));
                    },
                    child: Expanded(
                        child: myContainer(
                      image: ('assets/pl.png'),
                    )),
                  ),
                ),
                GestureDetector(
                  child: Expanded(
                    child: myContainer(
                      image: 'assets/bundesliga.png',
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                GestureDetector(
                  child: Expanded(
                    child: myContainer(
                      image: 'assets/seria.png',
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  child: Expanded(
                    child: myContainer(
                      image: 'assets/nos.png',
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: Row(children: [
                GestureDetector(
                  child: Expanded(
                    child: myContainer(
                      image: 'assets/laliga.png',
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: myContainer(
                      image: 'assets/ligue1.png',
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
