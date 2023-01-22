import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/src/constants/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayXD = ['', '', '', '', '', '', '', '', ''];
  List<int> matchIndexes = [];
  String resultDeclaration = '';
  int oScore = 0, xScore = 0, filledBoxes = 0, attempts = 0;
  bool winnerFound = false;

  Timer? timer;
  static const maxSeconds = 30;
  int seconds = maxSeconds;

  static var customFontWhite = GoogleFonts.coiny(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSeconds;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Player O',
                            style: customFontWhite.copyWith(
                                color: Colors.lightBlueAccent),
                          ),
                          Text(
                            oScore.toString(),
                            style: customFontWhite.copyWith(
                                color: Colors.lightBlueAccent),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Player X',
                            style: customFontWhite.copyWith(
                                color: Colors.lightBlueAccent),
                          ),
                          Text(
                            xScore.toString(),
                            style: customFontWhite.copyWith(
                                color: Colors.lightBlueAccent),
                          )
                        ],
                      ),
                    ],
                  )),
              const SizedBox(
                height: 60,
              ),
              Expanded(
                flex: 3,
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                          onTap: () {
                            _tapped(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(width: 5, color: Colors.black),
                                color: matchIndexes.contains(index)
                                    ? Colors.orange
                                    : primaryColor),
                            child: Center(
                              child: Text(
                                displayXD[index],
                                style: GoogleFonts.coiny(
                                    textStyle: const TextStyle(
                                        fontSize: 64, color: Colors.yellow)),
                              ),
                            ),
                          ),
                        )),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        resultDeclaration,
                        style: customFontWhite.copyWith(
                            color: Colors.lightGreenAccent),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildTimer()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      setState(() {
        if (oTurn && displayXD[index] == '') {
          displayXD[index] = 'O';
          filledBoxes++;
        } else if (!oTurn && displayXD[index] == '') {
          displayXD[index] = 'X';
          filledBoxes++;
        }
        oTurn = !oTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    if (displayXD[0] == displayXD[1] &&
        displayXD[0] == displayXD[2] &&
        displayXD[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXD[0] + ' Wins!';
        matchIndexes.addAll([0, 1, 2]);
        stopTimer();
        _updateScore(displayXD[0]);
      });
    }
    if (displayXD[3] == displayXD[4] &&
        displayXD[3] == displayXD[5] &&
        displayXD[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXD[3] + ' Wins!';
        matchIndexes.addAll([3, 4, 5]);
        stopTimer();
        _updateScore(displayXD[3]);
      });
    }
    if (displayXD[6] == displayXD[7] &&
        displayXD[6] == displayXD[8] &&
        displayXD[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXD[6] + ' Wins!';
        matchIndexes.addAll([6, 7, 8]);
        stopTimer();
        _updateScore(displayXD[6]);
      });
    }
    if (displayXD[0] == displayXD[3] &&
        displayXD[0] == displayXD[6] &&
        displayXD[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXD[0] + ' Wins!';
        matchIndexes.addAll([0, 3, 6]);
        stopTimer();
        _updateScore(displayXD[0]);
      });
    }
    if (displayXD[1] == displayXD[4] &&
        displayXD[1] == displayXD[7] &&
        displayXD[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXD[1] + ' Wins!';
        matchIndexes.addAll([1, 4, 7]);
        stopTimer();
        _updateScore(displayXD[1]);
      });
    }
    if (displayXD[2] == displayXD[5] &&
        displayXD[2] == displayXD[8] &&
        displayXD[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXD[2] + ' Wins!';
        matchIndexes.addAll([2, 5, 8]);
        stopTimer();
        _updateScore(displayXD[2]);
      });
    }
    if (displayXD[0] == displayXD[4] &&
        displayXD[0] == displayXD[8] &&
        displayXD[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXD[0] + ' Wins!';
        matchIndexes.addAll([0, 4, 8]);
        stopTimer();
        _updateScore(displayXD[0]);
      });
    }
    if (displayXD[6] == displayXD[4] &&
        displayXD[6] == displayXD[2] &&
        displayXD[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXD[6] + ' Wins!';
        matchIndexes.addAll([6, 4, 2]);
        stopTimer();
        _updateScore(displayXD[6]);
      });
    }
    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'Ops! Nobody Wins!';
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerFound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXD[i] = '';
      }
      resultDeclaration = '';
      matchIndexes = [];
    });
    filledBoxes = 0;
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: const AlwaysStoppedAnimation(Colors.yellow),
                  strokeWidth: 8,
                  backgroundColor: primaryColor,
                ),
                Center(
                  child: Text(
                    '$seconds',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.yellowAccent,
                        fontSize: 45),
                  ),
                )
              ],
            ),
          )
        : ElevatedButton(
            onPressed: () {
              startTimer();
              _clearBoard();
              attempts++;
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            child: Text(
              attempts == 0 ? 'Start' : 'Play Again!',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ));
  }
}
