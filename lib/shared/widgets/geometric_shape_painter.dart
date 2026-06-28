import 'package:flutter/material.dart';

// CustomPainter for floating 3D geometric shapes on hero project card
// Draws abstract triangles and rhombus to match the dashboard design mockup
class GeometricShapePainter extends CustomPainter {
  const GeometricShapePainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Purple/blue triangle — top left area
    final paint1 = Paint()
      ..color = const Color(0xFF6366F1).withAlpha(178)
      ..style = PaintingStyle.fill;

    final tri1 = Path()
      ..moveTo(60, 40)
      ..lineTo(120, 80)
      ..lineTo(30, 100)
      ..close();
    canvas.drawPath(tri1, paint1);

    // Green triangle — center right
    final paint2 = Paint()
      ..color = const Color(0xFF4ADE80).withAlpha(153)
      ..style = PaintingStyle.fill;

    final tri2 = Path()
      ..moveTo(100, 20)
      ..lineTo(170, 70)
      ..lineTo(130, 110)
      ..close();
    canvas.drawPath(tri2, paint2);

    // Purple rhombus — center
    final paint3 = Paint()
      ..color = const Color(0xFF8B5CF6).withAlpha(128)
      ..style = PaintingStyle.fill;

    final rhombus = Path()
      ..moveTo(140, 40)
      ..lineTo(185, 80)
      ..lineTo(140, 120)
      ..lineTo(95, 80)
      ..close();
    canvas.drawPath(rhombus, paint3);

    // Pink triangle — bottom right
    final paint4 = Paint()
      ..color = const Color(0xFFF472B6).withAlpha(128)
      ..style = PaintingStyle.fill;

    final tri3 = Path()
      ..moveTo(160, 90)
      ..lineTo(205, 115)
      ..lineTo(170, 145)
      ..close();
    canvas.drawPath(tri3, paint4);

    // Small blue accent triangle — top right
    final paint5 = Paint()
      ..color = const Color(0xFF60A5FA).withAlpha(100)
      ..style = PaintingStyle.fill;

    final tri4 = Path()
      ..moveTo(185, 20)
      ..lineTo(210, 50)
      ..lineTo(165, 55)
      ..close();
    canvas.drawPath(tri4, paint5);
  }

  @override
  bool shouldRepaint(GeometricShapePainter oldDelegate) => false;
}