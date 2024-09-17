import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_sample_animation/components/star/star_painter.dart';

class StarPathAnimation extends StatefulWidget {
  const StarPathAnimation({super.key});

  @override
  State<StarPathAnimation> createState() => _StarPathAnimationState();
}

class _StarPathAnimationState extends State<StarPathAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Path _starPath;

  @override
  void initState() {
    super.initState();

    // アニメーションコントローラを初期化し繰り返し再生する
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _starPath = _createStarPath(5, 150, 65, const Offset(150, 150));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          painter: StarPainter(_starPath, _controller.value),
          size: const Size(300, 300),
        );
      },
    );
  }

  // 星形のパスを作成する関数
  Path _createStarPath(
    int points,
    double outerRadius,
    double innerRadius,
    Offset center,
  ) {
    final angle = pi / points;
    final path = Path();
    for (var i = 0; i < points * 2 + 1; i++) {
      final r = (i % 2 == 0) ? outerRadius : innerRadius;
      final a = angle * i - pi / 2;
      final x = center.dx + r * cos(a);
      final y = center.dy + r * sin(a);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    return path;
  }
}
