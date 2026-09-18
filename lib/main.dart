import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const CricketOverApp());
}

class CricketOverApp extends StatelessWidget {
  const CricketOverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cricket Over Challenge',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
      ),
      home: const CricketOverScreen(),
    );
  }
}

class CricketOverScreen extends StatefulWidget {
  const CricketOverScreen({super.key});

  @override
  State<CricketOverScreen> createState() => _CricketOverScreenState();
}

class _CricketOverScreenState extends State<CricketOverScreen> {
  static const int maximumBalls = 6;

  final Random _random = Random();

  int totalScore = 0;
  int ballsPlayed = 0;
  int previousShot = 0;

  String gameMessage = 'Press PLAY BALL to start the over';

  bool get overCompleted => ballsPlayed >= maximumBalls;

  void playBall() {
    if (overCompleted) {
      return;
    }

    const possibleScores = [0, 1, 2, 3, 4, 6];

    final int runs = possibleScores[_random.nextInt(possibleScores.length)];

    setState(() {
      previousShot = runs;
      totalScore += runs;
      ballsPlayed++;

      if (ballsPlayed == maximumBalls) {
        gameMessage = 'Over completed! Final score: $totalScore runs';
      } else {
        gameMessage = shotMessage(runs);
      }
    });
  }

  String shotMessage(int runs) {
    switch (runs) {
      case 0:
        return 'Dot ball! No run scored.';
      case 1:
        return 'Nice single!';
      case 2:
        return 'Good running! Two runs.';
      case 3:
        return 'Three runs added!';
      case 4:
        return 'FOUR! Great boundary!';
      case 6:
        return 'SIX! Excellent shot!';
      default:
        return '';
    }
  }

  void restartOver() {
    setState(() {
      totalScore = 0;
      ballsPlayed = 0;
      previousShot = 0;
      gameMessage = 'Press PLAY BALL to start the over';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FC),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF312E81),
        foregroundColor: Colors.white,
        title: const Text(
          'Cricket Over Challenge',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  // Bat and ball images in the previous compact design
                  Container(
                    width: 150,
                    height: 105,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E7FF),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/bat.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Image.asset(
                            'assets/ball.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Six-Ball Cricket',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1B4B),
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Score as many runs as possible in one over',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),

                  const SizedBox(height: 28),

                  Row(
                    children: [
                      Expanded(
                        child: informationCard(
                          label: 'TOTAL SCORE',
                          value: '$totalScore',
                          icon: Icons.scoreboard_outlined,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: informationCard(
                          label: 'BALLS',
                          value: '$ballsPlayed / $maximumBalls',
                          icon: Icons.sports_baseball_outlined,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 25,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          overCompleted ? 'OVER RESULT' : 'LAST BALL',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            color: Colors.black45,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          ballsPlayed == 0
                              ? '-'
                              : '$previousShot RUN${previousShot == 1 ? '' : 'S'}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4F46E5),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          gameMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.4,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: overCompleted ? restartOver : playBall,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: overCompleted
                            ? const Color(0xFFD97706)
                            : const Color(0xFF4F46E5),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: Icon(
                        overCompleted ? Icons.refresh : Icons.sports_cricket,
                      ),
                      label: Text(
                        overCompleted ? 'RESTART OVER' : 'PLAY BALL',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    overCompleted
                        ? 'The over is complete'
                        : '${maximumBalls - ballsPlayed} ball${maximumBalls - ballsPlayed == 1 ? '' : 's'} remaining',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget informationCard({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 27, color: const Color(0xFF4F46E5)),

          const SizedBox(height: 10),

          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1B4B),
            ),
          ),
        ],
      ),
    );
  }
}
