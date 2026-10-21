import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:learn/models/colours_model.dart';
import 'package:learn/utils/assets_path.dart';

class ColoursPage extends StatefulWidget {
  const ColoursPage({Key? key}) : super(key: key);

  @override
  State<ColoursPage> createState() => _ColoursPageState();
}

class _ColoursPageState extends State<ColoursPage> {
  final FlutterTts _flutterTts = FlutterTts();

  final List<Colours> colours = [
    Colours(
      name: 'Red',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.red),
      bgColor: const Color(0xFFEF5350),
      fontColor: Colors.white,
    ),
    Colours(
      name: 'Blue',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.blue),
      bgColor: const Color(0xFF42A5F5),
      fontColor: Colors.white,
    ),
    Colours(
      name: 'Yellow',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.yellow),
      bgColor: const Color(0xFFFFCA28),
      fontColor: Colors.black87,
    ),
    Colours(
      name: 'Green',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.green),
      bgColor: const Color(0xFF66BB6A),
      fontColor: Colors.white,
    ),
    Colours(
      name: 'Orange',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.orange),
      bgColor: const Color(0xFFFFA726),
      fontColor: Colors.white,
    ),
    Colours(
      name: 'Pink',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.pink),
      bgColor: const Color(0xFFEC407A),
      fontColor: Colors.white,
    ),
    Colours(
      name: 'Violet',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.violet),
      bgColor: const Color(0xFFAB47BC),
      fontColor: Colors.white,
    ),
    Colours(
      name: 'Brown',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.brown),
      bgColor: const Color(0xFF8D6E63),
      fontColor: Colors.white,
    ),
    Colours(
      name: 'Black',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.black),
      bgColor: const Color(0xFF37474F),
      fontColor: Colors.white,
    ),
    Colours(
      name: 'White',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.white),
      bgColor: const Color(0xFFB0BEC5),
      fontColor: Colors.black87,
    ),
  ];

  Future<void> _speak(String text) async {
    try {
      await _flutterTts.stop();
      await _flutterTts.setSpeechRate(0.42);
      await _flutterTts.setPitch(1.1);
      await _flutterTts.speak(text);
    } catch (_) {}
  }

  void _showColourCard(int initialIndex) {
    int index = initialIndex;
    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            final colour = colours[index];
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 420, maxHeight: 520),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colour.bgColor, colour.bgColor.withValues(alpha: 0.85)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: colour.bgColor.withValues(alpha: 0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${index + 1} / ${colours.length}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(ctx),
                          icon: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: SvgPicture.asset(
                          colour.jpgAsset,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      colour.name,
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton.filledTonal(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withValues(alpha: 0.25),
                            padding: const EdgeInsets.all(12),
                          ),
                          onPressed: () {
                            setDialogState(() {
                              index = (index - 1 + colours.length) % colours.length;
                            });
                            _speak(colours[index].name);
                          },
                          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 28),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: colour.bgColor,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 4,
                          ),
                          onPressed: () => _speak(colour.name),
                          icon: const Icon(Icons.volume_up_rounded, size: 26),
                          label: const Text(
                            "Listen",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        IconButton.filledTonal(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withValues(alpha: 0.25),
                            padding: const EdgeInsets.all(12),
                          ),
                          onPressed: () {
                            setDialogState(() {
                              index = (index + 1) % colours.length;
                            });
                            _speak(colours[index].name);
                          },
                          icon: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 28),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFFAF7FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Colours 🎨",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFAB47BC), Color(0xFF42A5F5)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.palette_rounded, color: Colors.white, size: 30),
                    SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        "Tap any color to hear pronunciation and explore flashcards!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.86,
                ),
                itemCount: colours.length,
                itemBuilder: (context, index) {
                  final colour = colours[index];
                  return GestureDetector(
                    onTap: () {
                      _speak(colour.name);
                      _showColourCard(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E1E26) : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: colour.bgColor.withValues(alpha: 0.35),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: colour.bgColor.withValues(alpha: 0.15),
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
                                colour.jpgAsset,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                            decoration: BoxDecoration(
                              color: colour.bgColor.withValues(alpha: 0.15),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(22),
                                bottomRight: Radius.circular(22),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    color: colour.bgColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 1.5),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  colour.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    color: isDark ? Colors.white : Colors.black87,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Icon(
                                  Icons.volume_up_rounded,
                                  size: 18,
                                  color: colour.bgColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
