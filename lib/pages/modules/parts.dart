import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:learn/utils/assets_path.dart';
import 'package:learn/utils/constants.dart';
import 'package:learn/utils/functions.dart';
import 'parts_test.dart';

class PartsPage extends StatefulWidget {
  const PartsPage({Key? key}) : super(key: key);

  @override
  State<PartsPage> createState() => _PartsPageState();
}

class _PartsPageState extends State<PartsPage> {
  final CardSwiperController _swiperController = CardSwiperController();
  final FlutterTts _flutterTts = FlutterTts();

  int _currentIndex = 0;
  final List<int> _history = [];
  bool _isGridView = false;

  final List<Color> _palette = const [
    Color(0xFFE91E63),
    Color(0xFF9C27B0),
    Color(0xFF3F51B5),
    Color(0xFF2196F3),
    Color(0xFF00BCD4),
    Color(0xFF009688),
    Color(0xFF4CAF50),
    Color(0xFFFF9800),
    Color(0xFFFF5722),
    Color(0xFF795548),
  ];

  Color _getColor(int index) => _palette[index % _palette.length];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _speak(String text) async {
    try {
      await _flutterTts.stop();
      await _flutterTts.setSpeechRate(0.42);
      await _flutterTts.setPitch(1.1);
      await _flutterTts.speak(text);
    } catch (_) {}
  }

  @override
  void dispose() {
    _swiperController.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  void _navigateToPartsTestPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PartsTestPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const parts = AppConstants.candidates;
    final currentPart = parts[_currentIndex % parts.length];
    final currentColor = _getColor(_currentIndex);
    final description = AppFunctions().getDescription(currentPart);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF7F9FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Body Parts 🧠",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_carousel_rounded : Icons.grid_view_rounded),
            tooltip: _isGridView ? "Deck View" : "Grid View",
            onPressed: () => setState(() => _isGridView = !_isGridView),
          ),
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: IconButton(
              icon: const Icon(Icons.quiz_rounded, color: Colors.blueAccent),
              tooltip: "Test Yourself",
              onPressed: () => _navigateToPartsTestPage(context),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: _isGridView
            ? _buildGridView(isDark, parts)
            : _buildDeckView(isDark, parts, currentPart, currentColor, description),
      ),
    );
  }

  Widget _buildDeckView(
    bool isDark,
    List<String> parts,
    String currentPart,
    Color currentColor,
    String description,
  ) {
    return Column(
      children: [
        // Top instruction banner
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [currentColor, currentColor.withValues(alpha: 0.75)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.touch_app_rounded, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "Swipe cards or tap listen to learn about your body!",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                Text(
                  "${_currentIndex + 1}/${parts.length}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Swiper area
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: CardSwiper(
              controller: _swiperController,
              cardsCount: parts.length,
              numberOfCardsDisplayed: 3,
              backCardOffset: const Offset(0, -25),
              padding: EdgeInsets.zero,
              onSwipe: (prevIndex, newIndex, direction) {
                setState(() {
                  _history.add(_currentIndex);
                  _currentIndex = newIndex ?? 0;
                });
                _speak(parts[_currentIndex % parts.length]);
                return true;
              },
              cardBuilder: (context, index, percentX, percentY) {
                final partName = parts[index];
                final color = _getColor(index);
                return Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1E26) : Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: color.withValues(alpha: 0.4), width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(28),
                            child: SvgPicture.asset(
                              AssetsPath.getBodyImage("$partName.svg"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          color: color.withValues(alpha: 0.15),
                          child: Center(
                            child: Text(
                              partName,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: color,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Bottom description & controls card
        Expanded(
          flex: 4,
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E26) : Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currentPart,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton.filledTonal(
                          style: IconButton.styleFrom(
                            backgroundColor: currentColor.withValues(alpha: 0.15),
                          ),
                          onPressed: () => _speak("$currentPart. $description"),
                          icon: Icon(Icons.volume_up_rounded, color: currentColor, size: 24),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filledTonal(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.grey.withValues(alpha: 0.15),
                          ),
                          onPressed: () {
                            if (_history.isNotEmpty) {
                              _swiperController.undo();
                              setState(() {
                                _currentIndex = _history.removeLast();
                              });
                            }
                          },
                          icon: const Icon(Icons.undo_rounded, size: 24),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.45,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGridView(bool isDark, List<String> parts) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.9,
      ),
      itemCount: parts.length,
      itemBuilder: (context, index) {
        final partName = parts[index];
        final color = _getColor(index);
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentIndex = index;
              _isGridView = false;
            });
            _speak(partName);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E26) : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: color.withValues(alpha: 0.35), width: 2),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SvgPicture.asset(
                      AssetsPath.getBodyImage("$partName.svg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22),
                    ),
                  ),
                  child: Text(
                    partName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
