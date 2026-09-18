import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const PitchChallengeApp());
}

class PitchChallengeApp extends StatelessWidget {
  const PitchChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pitch Challenge',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const PitchChallengeScreen(),
    );
  }
}

class PitchChallengeScreen extends StatefulWidget {
  const PitchChallengeScreen({super.key});

  @override
  State<PitchChallengeScreen> createState() => _PitchChallengeScreenState();
}

class _PitchChallengeScreenState extends State<PitchChallengeScreen> {
  final Random _random = Random();

  static const int maximumBalls = 6;

  int runs = 0;
  int ballsRemaining = maximumBalls;

  bool get gameFinished => ballsRemaining == 0;

  void playShot() {
    if (gameFinished) {
      restartGame();
      return;
    }

    const List<int> possibleRuns = [
      0,
      1,
      2,
      3,
      4,
      6,
    ];

    final int scoredRuns = possibleRuns[_random.nextInt(possibleRuns.length)];

    setState(() {
      runs += scoredRuns;
      ballsRemaining--;
    });
  }

  void restartGame() {
    setState(() {
      runs = 0;
      ballsRemaining = maximumBalls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16867D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E57),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Pitch Challenge',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 55),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cricketDisplay(
                        imagePath: 'assets/bat.jpeg',
                        title: 'Runs',
                        value: '$runs',
                      ),
                      const SizedBox(width: 26),
                      cricketDisplay(
                        imagePath: 'assets/ball.jpeg',
                        title: 'Balls',
                        value: '$ballsRemaining',
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: playShot,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: gameFinished
                          ? const Color(0xFFD97706)
                          : const Color(0xFF064E3B),
                      foregroundColor: Colors.white,
                      elevation: 5,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      gameFinished ? 'Restart' : 'Bat',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cricketDisplay({
    required String imagePath,
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Container(
          width: 110,
          height: 110,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            errorBuilder: (
              BuildContext context,
              Object error,
              StackTrace? stackTrace,
            ) {
              return const Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 42,
                  color: Colors.grey,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 29,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
