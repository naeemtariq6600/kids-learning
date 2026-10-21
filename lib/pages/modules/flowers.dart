import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:learn/models/flower_model.dart';
import 'package:learn/utils/assets_path.dart';
import 'flowers_test.dart';

class FlowerPage extends StatefulWidget {
  const FlowerPage({super.key});

  @override
  State<FlowerPage> createState() => _FlowerPageState();
}

class _FlowerPageState extends State<FlowerPage> {
  final FlutterTts _flutterTts = FlutterTts();

  final List<Flower> flowers = [
    Flower(
      name: "Rose",
      resource: AssetsPath.getFlowerImage(Flowers.rose),
      background: const Color(0xFFE91E63),
    ),
    Flower(
      name: "Sunflower",
      resource: AssetsPath.getFlowerImage(Flowers.sunflower),
      background: const Color(0xFFFFA000),
    ),
    Flower(
      name: "Lily",
      resource: AssetsPath.getFlowerImage(Flowers.lily),
      background: const Color(0xFF4CAF50),
    ),
    Flower(
      name: "Marigold",
      resource: AssetsPath.getFlowerImage(Flowers.marigold),
      background: const Color(0xFFFF9800),
    ),
    Flower(
      name: "Carnation",
      resource: AssetsPath.getFlowerImage(Flowers.carnation),
      background: const Color(0xFFF06292),
    ),
    Flower(
      name: "Daffodil",
      resource: AssetsPath.getFlowerImage(Flowers.daffodil),
      background: const Color(0xFFFFD54F),
    ),
    Flower(
      name: "Daisy",
      resource: AssetsPath.getFlowerImage(Flowers.daisy),
      background: const Color(0xFF26A69A),
    ),
    Flower(
      name: "Poppy",
      resource: AssetsPath.getFlowerImage(Flowers.poppy),
      background: const Color(0xFFE53935),
    ),
    Flower(
      name: "Tulip",
      resource: AssetsPath.getFlowerImage(Flowers.tulip),
      background: const Color(0xFFEC407A),
    ),
    Flower(
      name: "Lavender",
      resource: AssetsPath.getFlowerImage(Flowers.lavender),
      background: const Color(0xFF7E57C2),
    ),
    Flower(
      name: "Hibiscus",
      resource: AssetsPath.getFlowerImage(Flowers.hibiscus),
      background: const Color(0xFFD81B60),
    ),
  ];

  Future<void> _speak(String text) async {
    try {
      await _flutterTts.stop();
      await _flutterTts.setSpeechRate(0.4);
      await _flutterTts.setPitch(1.1);
      await _flutterTts.speak(text);
    } catch (_) {}
  }

  void _showFlowerCard(int initialIndex) {
    int index = initialIndex;
    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            final flower = flowers[index];
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 420, maxHeight: 520),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      flower.background,
                      flower.background.withValues(alpha: 0.82),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: flower.background.withValues(alpha: 0.4),
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
                            "${index + 1} / ${flowers.length}",
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
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: SvgPicture.asset(
                          flower.resource,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      flower.name,
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
                              index = (index - 1 + flowers.length) % flowers.length;
                            });
                            _speak(flowers[index].name);
                          },
                          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 28),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: flower.background,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 4,
                          ),
                          onPressed: () => _speak(flower.name),
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
                              index = (index + 1) % flowers.length;
                            });
                            _speak(flowers[index].name);
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
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFFFF7F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Flowers 🌸",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.pinkAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: IconButton(
              icon: const Icon(Icons.quiz_rounded, color: Colors.pinkAccent),
              tooltip: "Flower Quiz",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FlowersTestPage()),
                );
              },
            ),
          ),
        ],
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
                    colors: [Color(0xFFF06292), Color(0xFFBA68C8)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.local_florist_rounded, color: Colors.white, size: 30),
                    SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        "Tap any flower to see flashcard and hear its name!",
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
                itemCount: flowers.length,
                itemBuilder: (context, index) {
                  final flower = flowers[index];
                  return GestureDetector(
                    onTap: () {
                      _speak(flower.name);
                      _showFlowerCard(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E1E26) : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: flower.background.withValues(alpha: 0.3),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: flower.background.withValues(alpha: 0.12),
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
                              child: Hero(
                                tag: "flower_${flower.name}",
                                child: SvgPicture.asset(
                                  flower.resource,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                            decoration: BoxDecoration(
                              color: flower.background.withValues(alpha: 0.14),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(22),
                                bottomRight: Radius.circular(22),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  flower.name,
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
                                  color: flower.background,
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
