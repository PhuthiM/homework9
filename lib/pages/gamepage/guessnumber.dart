import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'game.dart';

class guessnumber extends StatefulWidget {
  const guessnumber({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<guessnumber> {
  late Game _game;
  final _controller = TextEditingController();
  String? _guessNumber;
  String _feedback = '';
  bool showNewgame = false;
  int start = 0;
  int icon = 0;
  int text = 0;

  /* String title = 'Error';
  String msg = 'Please enter the number.';
*/

  @override
  void initState() {
    super.initState();
    _game = Game();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _showMaterialError(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showMaterial(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _clickGuess() {
    if (_controller.text == '') {
      _showMaterialError('Error', 'Please enter the number.');
      return;
    }
  }

  void _newgame() {
    setState(() {
      _game = Game();
      start = 0;
      showNewgame = false;
      icon = 0;
    });
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: _buildHeader(),
              ),
              _buildMainContent(),
              _buildInputPanel(),
            ],
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
          width: 290.0,
        ),
        Text('Guess the Number',
            style: GoogleFonts.kanit(fontSize: 22.0, color: Colors.blue))
      ],
    );
  }

  Widget _buildMainContent() {
    return start == 0
        ? Column(
            children: [
              Text(
                'I\'m thinking of number between 1 and 100.\n',
                style: GoogleFonts.kanit(fontSize: 22.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Can you guess it?',
                      style: GoogleFonts.kanit(fontSize: 22.0)),
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          )
        : Column(
            children: [
              Text(
                text.toString(),
                style: GoogleFonts.kanit(fontSize: 80.0, color: Colors.black45),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon == 0
                      ? Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 50.0,
                        )
                      : Icon(
                          Icons.done,
                          color: Colors.lightGreen,
                          size: 50.0,
                        ),
                  Text(
                    _feedback,
                    style: GoogleFonts.kanit(fontSize: 50.0),
                  ),
                ],
              ),
              showNewgame == true
                  ? TextButton(
                      onPressed: () {
                        _newgame();
                      },
                      child: Text('NEW GAME'),
                    )
                  : SizedBox.shrink(),
            ],
          );
  }

  Widget _buildInputPanel() {
    return showNewgame == false
        ? Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    cursorColor: Colors.yellow,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      isDense: true,

                      // กำหนดลักษณะเส้น border ของ TextField ในสถานะปกติ
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),

                      // กำหนดลักษณะเส้น border ของ TextField เมื่อได้รับโฟกัส
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),

                      hintText: 'Enter the number here',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 16.0,
                      ),
                    ),
                  )),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _guessNumber = _controller.text;
                        int? guess = int.tryParse(_guessNumber!);

                        if (guess != null) {
                          start = 1;
                          text = guess;
                          int result = _game.doGuess(guess);

                          if (result == 0) {
                            _feedback = 'CORRRECT!';
                            setState(() {
                              showNewgame = true;
                              icon = 1;
                              int total = _game.totalGuesses;
                              String? arraylist = _game.arrayList;
                              _showMaterialError("GOOD JOB!\n",
                                  "The answer is $guess.\nYou have made $total guesses.\n\n $arraylist");
                            });
                          } else if (result == 1) {
                            //มากไป
                            _feedback = 'TOO HIGH!';
                          } else {
                            //น้อยไป
                            _feedback = 'TOO LOW!';
                          }
                          _controller.clear();
                        } else if (guess == null) {
                          _clickGuess();
                        }
                      });
                    },
                    child: Text(
                      "GUESS",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    enabled: false,
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    cursorColor: Colors.yellow,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      isDense: true,
                      // กำหนดลักษณะเส้น border ของ TextField ในสถานะปกติ
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      // กำหนดลักษณะเส้น border ของ TextField เมื่อได้รับโฟกัส
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: 'Enter the number here',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 16.0,
                      ),
                    ),
                  )),
                  TextButton(
                    onPressed: null,
                    child: Text(
                      "GUESS",
                      style: TextStyle(color: Colors.black26),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
