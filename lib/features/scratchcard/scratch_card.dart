import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; 
import 'package:confetti/confetti.dart'; 

class ScratchCard extends StatefulWidget {
  final Widget hiddenChild;
  final Color overlayColor;
  final double strokeWidth;
  final int requiredScratches;

  const ScratchCard({
    super.key,
    required this.hiddenChild,
    this.overlayColor = Colors.grey,
    this.strokeWidth = 20.0,
    this.requiredScratches = 60,
  });

  @override
  _ScratchCardState createState() => _ScratchCardState();
}

class _ScratchCardState extends State<ScratchCard> {
  final List<Offset?> _points = [];
  int _scratchCount = 0;
  bool _scratched = false;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        children: [
          
          Visibility(
            visible: _scratched,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade200,
                    Colors.purple.shade300,
                    Colors.pink.shade200,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: widget.hiddenChild,
              ),
            ),
          ),
          
          
          Visibility(
            visible: !_scratched,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  _points.add(renderBox.globalToLocal(details.globalPosition));
                  _scratchCount++;
                  if (_scratchCount >= widget.requiredScratches) {
                    _scratched = true;
                    _confettiController.play();
                  }
                });
              },
              onPanEnd: (details) {
                _points.add(null);
              },
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size.infinite,
                    painter: _ScratchCardPainter(
                      points: _points,
                      color: widget.overlayColor,
                      strokeWidth: widget.strokeWidth,
                    ),
                  ),
                  
                  
                  Positioned.fill(
                    child: Shimmer.fromColors(
                      baseColor: widget.overlayColor.withOpacity(0.6),
                      highlightColor: Colors.white.withOpacity(0.6),
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  
                  
                  const Center(
                    child: Text(
                      'Scratch Here',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          
          Visibility(
            visible: _scratched,
            child: Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: -pi / 2,
                colors:const [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.yellow,
                ],
                numberOfParticles: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScratchCardPainter extends CustomPainter {
  final List<Offset?> points;
  final Color color;
  final double strokeWidth;

  _ScratchCardPainter({
    required this.points,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_ScratchCardPainter oldDelegate) {
    return true;
  }
}
