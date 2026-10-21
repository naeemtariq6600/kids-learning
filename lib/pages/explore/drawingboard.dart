import 'package:flutter/material.dart';

class DrawingBoardPage extends StatelessWidget {
  const DrawingBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DrawingBoard();
  }
}

class DrawingBoard extends StatefulWidget {
  const DrawingBoard({Key? key}) : super(key: key);

  @override
  DrawingBoardState createState() => DrawingBoardState();
}

class DrawingBoardState extends State<DrawingBoard> {
  Color _selectedColor = const Color(0xFF673AB7);
  double _strokeWidth = 6.0;
  bool _isEraser = false;

  // Each stroke is a list of points
  final List<List<DrawingPoint>> _strokes = [];
  List<DrawingPoint> _currentStroke = [];

  final List<Color> _colors = const [
    Color(0xFFE91E63), // Pink
    Color(0xFFF44336), // Red
    Color(0xFFFF9800), // Orange
    Color(0xFFFFEB3B), // Yellow
    Color(0xFF4CAF50), // Green
    Color(0xFF00BCD4), // Cyan
    Color(0xFF2196F3), // Blue
    Color(0xFF673AB7), // Purple
    Color(0xFF795548), // Brown
    Color(0xFF212121), // Black
  ];

  void _undo() {
    if (_strokes.isNotEmpty) {
      setState(() {
        _strokes.removeLast();
      });
    }
  }

  void _clear() {
    setState(() {
      _strokes.clear();
      _currentStroke.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final canvasBg = isDark ? const Color(0xFF181822) : const Color(0xFFFAFAFE);
    final eraserColor = canvasBg;

    return Scaffold(
      backgroundColor: canvasBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Magic Canvas 🎨",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo_rounded),
            tooltip: "Undo",
            onPressed: _strokes.isNotEmpty ? _undo : null,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            tooltip: "Clear All",
            onPressed: _strokes.isNotEmpty ? _clear : null,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          // Drawing Canvas
          GestureDetector(
            onPanStart: (details) {
              setState(() {
                _currentStroke = [
                  DrawingPoint(
                    details.localPosition,
                    Paint()
                      ..color = _isEraser ? eraserColor : _selectedColor
                      ..isAntiAlias = true
                      ..strokeWidth = _isEraser ? _strokeWidth * 2.5 : _strokeWidth
                      ..strokeCap = StrokeCap.round
                      ..strokeJoin = StrokeJoin.round,
                  ),
                ];
                _strokes.add(_currentStroke);
              });
            },
            onPanUpdate: (details) {
              setState(() {
                _currentStroke.add(
                  DrawingPoint(
                    details.localPosition,
                    Paint()
                      ..color = _isEraser ? eraserColor : _selectedColor
                      ..isAntiAlias = true
                      ..strokeWidth = _isEraser ? _strokeWidth * 2.5 : _strokeWidth
                      ..strokeCap = StrokeCap.round
                      ..strokeJoin = StrokeJoin.round,
                  ),
                );
              });
            },
            child: CustomPaint(
              painter: _StrokesPainter(_strokes),
              child: const SizedBox.expand(),
            ),
          ),

          // Floating Tools Card at bottom
          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF232330).withValues(alpha: 0.95)
                    : Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Slider + Eraser row
                  Row(
                    children: [
                      const Icon(Icons.line_weight_rounded, size: 20),
                      Expanded(
                        child: Slider(
                          min: 2,
                          max: 30,
                          value: _strokeWidth,
                          activeColor: _selectedColor,
                          onChanged: (val) => setState(() => _strokeWidth = val),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() => _isEraser = !_isEraser);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: _isEraser
                                ? Colors.deepOrange
                                : (isDark ? Colors.white12 : Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.auto_fix_high_rounded,
                                size: 18,
                                color: _isEraser
                                    ? Colors.white
                                    : (isDark ? Colors.white70 : Colors.black87),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "Eraser",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: _isEraser
                                      ? Colors.white
                                      : (isDark ? Colors.white70 : Colors.black87),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Color Palette Row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _colors.map((color) {
                        final isSelected = !_isEraser && _selectedColor == color;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColor = color;
                              _isEraser = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                            height: isSelected ? 40 : 32,
                            width: isSelected ? 40 : 32,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? Colors.white : Colors.transparent,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: color.withValues(alpha: isSelected ? 0.45 : 0.2),
                                  blurRadius: isSelected ? 8 : 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: isSelected
                                ? const Icon(Icons.check, color: Colors.white, size: 20)
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StrokesPainter extends CustomPainter {
  final List<List<DrawingPoint>> strokes;

  _StrokesPainter(this.strokes);

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      if (stroke.isEmpty) continue;
      if (stroke.length == 1) {
        canvas.drawCircle(stroke.first.offset, stroke.first.paint.strokeWidth / 2, stroke.first.paint);
      } else {
        for (int i = 0; i < stroke.length - 1; i++) {
          canvas.drawLine(stroke[i].offset, stroke[i + 1].offset, stroke[i].paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DrawingPoint {
  final Offset offset;
  final Paint paint;

  DrawingPoint(this.offset, this.paint);
}
