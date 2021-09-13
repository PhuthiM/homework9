import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/logo_number.png',
                      width: 240.0,
                    ),
                    Text(
                      'GUESS THE NUMBER',
                      style: GoogleFonts.kanit(fontSize: 22.0),
                    )
                  ],
                ),
                Text('TEST'),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.teal, width: 5.0))),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        
                      },
                      child: Text("GUESS"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
