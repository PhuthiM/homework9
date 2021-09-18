import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'game.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late Game _game;
  final _controller = TextEditingController();
  String? _guessNumber;
  String? _feedback;
  bool showNewgame = false;

  @override
  void initState() {
    super.initState();
    _game = Game();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GUESS THE NUMBER"),
      ),
      body: Container(
        color: Colors.yellow[100],
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader(),
                _buildMainContent(),
                _buildInputPanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo_number.png',
          width: 240.0,
        ),
        Text('GUESS THE NUMBER',
            style: GoogleFonts.kanit(fontSize: 22.0, color: Colors.blue))
      ],
    );
  }

  Widget _buildMainContent() {
    return _guessNumber == null
        ? SizedBox.shrink()
        : Column(
            children: [
              Text(
                _guessNumber!,
                style: GoogleFonts.kanit(fontSize: 80.0),
              ),
              Text(
                _feedback!,
                style: GoogleFonts.kanit(fontSize: 50.0),
              ),
              showNewgame == true
                  ? TextButton(
                      onPressed: () {
                        _game = Game();
                      },
                      child: Text('NEW GAME'),
                    )
                  : SizedBox.shrink()
            ],
          );
  }

  Widget _buildInputPanel() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                border: new OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: Colors.teal, width: 5.0))),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _guessNumber = _controller.text;
              int? guess = int.tryParse(_guessNumber!);
              if (guess != null) {
                int result = _game.doGuess(guess);
                if (result == 0) {
                  //ทายถูก
                  _feedback = 'CORRRECT!';
                  setState(() {
                    showNewgame=true;
                  });
                } else if (result == 1) {
                  //มากไป
                  _feedback = 'TOO HIGH!';
                } else {
                  //น้อยไป
                  _feedback = 'TOO LOW!';
                }
              }
            });
          },
          child: Text(
            "GUESS",
          ),
        )
      ],
    );
  }
}
