import 'package:flutter/material.dart';

class ScratchCard extends StatefulWidget {
  final Widget hiddenChild; 
  final Color overlayColor;
  final double strokeWidth;
  final int requiredScratches; 

  const ScratchCard({
    Key? key,
    required this.hiddenChild,
    this.overlayColor = Colors.grey,
    this.strokeWidth = 20.0,
    this.requiredScratches = 60, 
  }) : super(key: key);

  @override
  _ScratchCardState createState() => _ScratchCardState();
}

class _ScratchCardState extends State<ScratchCard> {
  List<Offset?> _points = [];
  int _scratchCount = 0;
  bool _scratched = false; 

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        children: [
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
                  }
                });
              },
              onPanEnd: (details) {
                _points.add(null);
              },
              child: CustomPaint(
                size: Size.infinite, 
                painter: _ScratchCardPainter(
                  points: _points,
                  color: widget.overlayColor,
                  strokeWidth: widget.strokeWidth,
                ),
              ),
            ),
          ),
          
          Visibility(
            visible: _scratched, 
            child: Container(
              color: Colors.transparent, 
              child: Center(
                child: widget.hiddenChild,
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
