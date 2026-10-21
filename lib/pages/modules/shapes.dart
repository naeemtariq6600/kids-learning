import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:learn/widgets/drawer.dart';

class ShapeItem {
  final String name;
  final String sides;
  final String funFact;
  final Color color;
  final CustomPainter painter;

  ShapeItem({
    required this.name,
    required this.sides,
    required this.funFact,
    required this.color,
    required this.painter,
  });
}

class ShapesPage extends StatefulWidget {
  const ShapesPage({super.key});

  @override
  State<ShapesPage> createState() => _ShapesPageState();
}

class _ShapesPageState extends State<ShapesPage> {
  final FlutterTts _flutterTts = FlutterTts();

  late final List<ShapeItem> shapes;

  @override
  void initState() {
    super.initState();
    shapes = [
      ShapeItem(
        name: "Circle",
        sides: "0 Sides",
        funFact: "A circle is perfectly round, like a coin or the sun!",
        color: const Color(0xFFE91E63),
        painter: _CirclePainter(const Color(0xFFE91E63)),
      ),
      ShapeItem(
        name: "Square",
        sides: "4 Equal Sides",
        funFact: "All four sides of a square are exactly the same length!",
        color: const Color(0xFF2196F3),
        painter: _SquarePainter(const Color(0xFF2196F3)),
      ),
      ShapeItem(
        name: "Triangle",
        sides: "3 Sides & 3 Angles",
        funFact: "A slice of pizza is shaped just like a triangle!",
        color: const Color(0xFFFF9800),
        painter: _TrianglePainter(const Color(0xFFFF9800)),
      ),
      ShapeItem(
        name: "Rectangle",
        sides: "4 Sides (2 Long, 2 Short)",
        funFact: "A door, smartphone, and books are rectangles!",
        color: const Color(0xFF4CAF50),
        painter: _RectanglePainter(const Color(0xFF4CAF50)),
      ),
      ShapeItem(
        name: "Star",
        sides: "5 Points",
        funFact: "Twinkle twinkle little star, shining in the night sky!",
        color: const Color(0xFFFFC107),
        painter: _StarPainter(const Color(0xFFFFC107)),
      ),
      ShapeItem(
        name: "Diamond",
        sides: "4 Slanted Sides",
        funFact: "Also known as a rhombus, like a flying kite!",
        color: const Color(0xFF9C27B0),
        painter: _DiamondPainter(const Color(0xFF9C27B0)),
      ),
      ShapeItem(
        name: "Heart",
        sides: "Curved Shape",
        funFact: "The heart shape is a universal symbol of love and friendship!",
        color: const Color(0xFFF44336),
        painter: _HeartPainter(const Color(0xFFF44336)),
      ),
      ShapeItem(
        name: "Oval",
        sides: "0 Sides (Egg Shape)",
        funFact: "An oval is an elongated circle, just like an egg!",
        color: const Color(0xFF00BCD4),
        painter: _OvalPainter(const Color(0xFF00BCD4)),
      ),
      ShapeItem(
        name: "Pentagon",
        sides: "5 Sides",
        funFact: "A pentagon has five straight edges, like a little house!",
        color: const Color(0xFF3F51B5),
        painter: _PentagonPainter(const Color(0xFF3F51B5)),
      ),
      ShapeItem(
        name: "Hexagon",
        sides: "6 Sides",
        funFact: "Honeycombs made by bees are shaped like hexagons!",
        color: const Color(0xFF009688),
        painter: _HexagonPainter(const Color(0xFF009688)),
      ),
    ];
  }

  Future<void> _speak(String text) async {
    try {
      await _flutterTts.stop();
      await _flutterTts.setSpeechRate(0.42);
      await _flutterTts.setPitch(1.1);
      await _flutterTts.speak(text);
    } catch (_) {}
  }

  void _showShapeCard(int initialIndex) {
    int index = initialIndex;
    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            final shape = shapes[index];
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 420, maxHeight: 560),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [shape.color, shape.color.withValues(alpha: 0.85)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: shape.color.withValues(alpha: 0.45),
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
                            "${index + 1} / ${shapes.length}",
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
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: CustomPaint(
                            size: const Size(140, 140),
                            painter: shape.painter,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      shape.name,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        shape.sides,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      shape.funFact,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
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
                              index = (index - 1 + shapes.length) % shapes.length;
                            });
                            _speak("${shapes[index].name}. ${shapes[index].sides}");
                          },
                          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 28),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: shape.color,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 4,
                          ),
                          onPressed: () => _speak("${shape.name}. ${shape.sides}. ${shape.funFact}"),
                          icon: const Icon(Icons.volume_up_rounded, size: 26),
                          label: const Text(
                            "Pronounce",
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
                              index = (index + 1) % shapes.length;
                            });
                            _speak("${shapes[index].name}. ${shapes[index].sides}");
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
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF5F9FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Shapes 🔷",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
        ),
      ),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00B0FF), Color(0xFF651FFF)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.category_rounded, color: Colors.white, size: 30),
                    SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        "Learn and tap 2D geometric shapes to discover their sides and facts!",
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
                itemCount: shapes.length,
                itemBuilder: (context, index) {
                  final shape = shapes[index];
                  return GestureDetector(
                    onTap: () {
                      _speak(shape.name);
                      _showShapeCard(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E1E26) : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: shape.color.withValues(alpha: 0.3),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: shape.color.withValues(alpha: 0.12),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: CustomPaint(
                                size: const Size(80, 80),
                                painter: shape.painter,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                            decoration: BoxDecoration(
                              color: shape.color.withValues(alpha: 0.12),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(22),
                                bottomRight: Radius.circular(22),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  shape.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    color: isDark ? Colors.white : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  shape.sides,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: shape.color,
                                  ),
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

// Custom Shape Painters
class _CirclePainter extends CustomPainter {
  final Color color;
  _CirclePainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2.2, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SquarePainter extends CustomPainter {
  final Color color;
  _SquarePainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final r = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: size.width * 0.85, height: size.width * 0.85),
      const Radius.circular(12),
    );
    canvas.drawRRect(r, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(size.width / 2, size.height * 0.1)
      ..lineTo(size.width * 0.9, size.height * 0.9)
      ..lineTo(size.width * 0.1, size.height * 0.9)
      ..close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RectanglePainter extends CustomPainter {
  final Color color;
  _RectanglePainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final r = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: size.width * 0.9, height: size.height * 0.58),
      const Radius.circular(10),
    );
    canvas.drawRRect(r, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StarPainter extends CustomPainter {
  final Color color;
  _StarPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double outerR = size.width / 2.2;
    final double innerR = outerR * 0.45;
    for (int i = 0; i < 10; i++) {
      final double r = i.isEven ? outerR : innerR;
      final double angle = -math.pi / 2 + (i * math.pi / 5);
      final double x = cx + r * math.cos(angle);
      final double y = cy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DiamondPainter extends CustomPainter {
  final Color color;
  _DiamondPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(size.width / 2, size.height * 0.08)
      ..lineTo(size.width * 0.92, size.height / 2)
      ..lineTo(size.width / 2, size.height * 0.92)
      ..lineTo(size.width * 0.08, size.height / 2)
      ..close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HeartPainter extends CustomPainter {
  final Color color;
  _HeartPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    final width = size.width;
    final height = size.height;
    path.moveTo(width / 2, height * 0.85);
    path.cubicTo(
      width * 0.05, height * 0.55,
      width * 0.05, height * 0.15,
      width / 2, height * 0.35,
    );
    path.cubicTo(
      width * 0.95, height * 0.15,
      width * 0.95, height * 0.55,
      width / 2, height * 0.85,
    );
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _OvalPainter extends CustomPainter {
  final Color color;
  _OvalPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: size.width * 0.65, height: size.height * 0.9),
      paint,
    );
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PentagonPainter extends CustomPainter {
  final Color color;
  _PentagonPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double r = size.width / 2.3;
    for (int i = 0; i < 5; i++) {
      final double angle = -math.pi / 2 + (i * 2 * math.pi / 5);
      final double x = cx + r * math.cos(angle);
      final double y = cy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HexagonPainter extends CustomPainter {
  final Color color;
  _HexagonPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double r = size.width / 2.3;
    for (int i = 0; i < 6; i++) {
      final double angle = (i * 2 * math.pi / 6);
      final double x = cx + r * math.cos(angle);
      final double y = cy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
