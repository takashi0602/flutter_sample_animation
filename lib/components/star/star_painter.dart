import 'package:flutter/material.dart';

class StarPainter extends CustomPainter {
  final Path path;
  final double progress;

  StarPainter(this.path, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // パスのメトリクスを取得
    final pathMetrics = path.computeMetrics();
    final pathMetric = pathMetrics.first;

    // 進行度に応じたパスの長さ
    final drawLength = pathMetric.length * progress;

    // 進行度に応じたパスの長さまでを抽出したパスを追加
    final drawPath = Path();
    drawPath.addPath(
      pathMetric.extractPath(0, drawLength),
      Offset.zero,
    );

    // パスのペイント（スタイル）
    final pathPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(drawPath, pathPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
