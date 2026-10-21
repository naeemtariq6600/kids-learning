import 'package:flutter/material.dart';
import 'package:learn/utils/constants.dart';
import 'package:learn/utils/route/route_constant.dart';

class Quiz extends StatefulWidget {
  static const routeName = "/quiz";
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class Questions {
  String question;
  List<String> options;
  String? image;
  int answer;

  Questions({
    required this.question,
    required this.options,
    required this.answer,
    this.image,
  });
}

class _QuizState extends State<Quiz> {
  int _score = 0;
  int _selectedIndex = -1;
  bool _isTappable = true;
  int _questionNumber = 0;

  void _handleOptionTap(int index) {
    if (!_isTappable) return;
    setState(() {
      _selectedIndex = index;
      _isTappable = false;
      if (index == AppConstants.ques[_questionNumber].answer) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_selectedIndex == -1) return;

    if (_questionNumber < AppConstants.ques.length - 1) {
      setState(() {
        _questionNumber++;
        _selectedIndex = -1;
        _isTappable = true;
      });
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    final total = AppConstants.ques.length;
    final percentage = ((_score / total) * 100).round();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF673AB7), Color(0xFF512DA8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Text("🏆", style: TextStyle(fontSize: 48)),
              ),
              const SizedBox(height: 16),
              const Text(
                "Super Job!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "You scored $_score out of $total ($percentage%)",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _score = 0;
                          _questionNumber = 0;
                          _selectedIndex = -1;
                          _isTappable = true;
                        });
                      },
                      child: const Text(
                        "Play Again",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 4,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed(AllRoutesConstant.mainhomeRoute);
                      },
                      child: const Text(
                        "Home",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final totalQues = AppConstants.ques.length;
    final currentQues = AppConstants.ques[_questionNumber];
    final progress = (_questionNumber + 1) / totalQues;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF7F4FD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Kids Quiz 🧠",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 22,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  "Score: $_score",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Question ${_questionNumber + 1} of $totalQues",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      Text(
                        "${(progress * 100).round()}%",
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor: Colors.deepPurple.withValues(alpha: 0.15),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                    ),
                  ),
                ],
              ),
            ),

            // Question Box
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E1E26) : Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          if (currentQues.image != null) ...[
                            Container(
                              height: 180,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  currentQues.image!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          Text(
                            currentQues.question,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: isDark ? Colors.white : Colors.black87,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Options List
                    ...List.generate(currentQues.options.length, (index) {
                      final option = currentQues.options[index];
                      final isSelected = _selectedIndex == index;
                      final isCorrect = index == currentQues.answer;

                      Color tileBg = isDark ? const Color(0xFF1E1E26) : Colors.white;
                      Color borderColor = isDark ? Colors.white12 : Colors.grey.shade300;
                      Color textColor = isDark ? Colors.white : Colors.black87;

                      if (_selectedIndex != -1) {
                        if (isSelected) {
                          if (isCorrect) {
                            tileBg = Colors.green.withValues(alpha: 0.18);
                            borderColor = Colors.green;
                            textColor = Colors.green.shade700;
                          } else {
                            tileBg = Colors.red.withValues(alpha: 0.18);
                            borderColor = Colors.red;
                            textColor = Colors.red.shade700;
                          }
                        } else if (isCorrect) {
                          tileBg = Colors.green.withValues(alpha: 0.1);
                          borderColor = Colors.green.shade400;
                        }
                      }

                      final optionLetters = ["A", "B", "C", "D"];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => _handleOptionTap(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                            decoration: BoxDecoration(
                              color: tileBg,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: borderColor, width: 2),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: borderColor.withValues(alpha: 0.25),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? borderColor
                                        : Colors.grey.withValues(alpha: 0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      index < optionLetters.length ? optionLetters[index] : "${index + 1}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                        color: isSelected ? Colors.white : textColor,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    option,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                                if (_selectedIndex != -1 && isSelected)
                                  Icon(
                                    isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                                    color: isCorrect ? Colors.green : Colors.red,
                                    size: 26,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // Bottom CTA button
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedIndex == -1
                        ? Colors.grey.shade400
                        : Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    elevation: _selectedIndex == -1 ? 0 : 4,
                  ),
                  onPressed: _selectedIndex == -1 ? null : _nextQuestion,
                  child: Text(
                    _questionNumber < totalQues - 1 ? "Next Question →" : "See Final Score 🏆",
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
