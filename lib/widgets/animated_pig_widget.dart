import 'package:flutter/material.dart';

class AnimatedPigWidget extends StatefulWidget {
  final String mood; // 'happy' or 'sad'
  const AnimatedPigWidget({super.key, required this.mood});

  @override
  State<AnimatedPigWidget> createState() => _AnimatedPigWidgetState();
}

class _AnimatedPigWidgetState extends State<AnimatedPigWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _legAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
    _legAnim = Tween<double>(begin: -0.3, end: 0.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _legAnim,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(40, 32),
          painter: _PigPainter(
            mood: widget.mood,
            legAngle: _legAnim.value,
          ),
        );
      },
    );
  }
}

class _PigPainter extends CustomPainter {
  final String mood;
  final double legAngle;
  _PigPainter({required this.mood, required this.legAngle});

  @override
  void paint(Canvas canvas, Size size) {
    // Use pink for happy, grey for sad
    final bodyPaint = Paint()
      ..color = mood == 'happy' ? Colors.pink[200]! : Colors.grey[400]!;
    final darkPaint = Paint()
      ..color = mood == 'happy' ? Colors.pink[400]! : Colors.grey[600]!;
    final blackPaint = Paint()..color = Colors.black;

    // Body
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width / 2, size.height / 2 + 4), width: 28, height: 16),
      bodyPaint,
    );

    // Head
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width / 2, size.height / 2 - 4), width: 18, height: 14),
      bodyPaint,
    );

    // Ears
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width / 2 - 7, size.height / 2 - 12), width: 5, height: 7),
      bodyPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width / 2 + 7, size.height / 2 - 12), width: 5, height: 7),
      bodyPaint,
    );

    // Nose
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width / 2, size.height / 2 - 2), width: 8, height: 5),
      darkPaint,
    );
    canvas.drawCircle(Offset(size.width / 2 - 2, size.height / 2 - 2), 1, blackPaint);
    canvas.drawCircle(Offset(size.width / 2 + 2, size.height / 2 - 2), 1, blackPaint);

    // Eyes
    canvas.drawCircle(Offset(size.width / 2 - 4, size.height / 2 - 6), 1.2, blackPaint);
    canvas.drawCircle(Offset(size.width / 2 + 4, size.height / 2 - 6), 1.2, blackPaint);

    // Smile or sad mouth
    final mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    if (mood == 'happy') {
      canvas.drawArc(
        Rect.fromCenter(center: Offset(size.width / 2, size.height / 2 - 1), width: 7, height: 4),
        0.1, 3.0, false, mouthPaint,
      );
    } else {
      canvas.drawArc(
        Rect.fromCenter(center: Offset(size.width / 2, size.height / 2 + 2), width: 7, height: 4),
        3.2, 2.3, false, mouthPaint,
      );
    }

    // Legs (animated)
      final legPaint = Paint()
      ..color = mood == 'happy' ? Colors.pink[400]! : Colors.grey[700]!
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    // Four legs, two animated forward, two backward
    final yLeg = size.height / 2 + 10;
    canvas.save();
    canvas.translate(size.width / 2 - 7, yLeg);
    canvas.rotate(legAngle);
    canvas.drawLine(Offset.zero, Offset(0, 7), legPaint);
    canvas.restore();

    canvas.save();
    canvas.translate(size.width / 2 + 7, yLeg);
    canvas.rotate(-legAngle);
    canvas.drawLine(Offset.zero, Offset(0, 7), legPaint);
    canvas.restore();

    canvas.save();
    canvas.translate(size.width / 2 - 3, yLeg);
    canvas.rotate(-legAngle);
    canvas.drawLine(Offset.zero, Offset(0, 7), legPaint);
    canvas.restore();

    canvas.save();
    canvas.translate(size.width / 2 + 3, yLeg);
    canvas.rotate(legAngle);
    canvas.drawLine(Offset.zero, Offset(0, 7), legPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _PigPainter oldDelegate) =>
      oldDelegate.legAngle != legAngle || oldDelegate.mood != mood;
}