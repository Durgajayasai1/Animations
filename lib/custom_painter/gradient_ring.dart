import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class GradientRing extends StatefulWidget {
  const GradientRing({super.key});

  @override
  State<GradientRing> createState() => GradientRingState();
}

class GradientRingState extends State<GradientRing> {
  double rotationAngle = 0.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startRotation();
    });
    super.initState();
  }

  void startRotation() {
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        rotationAngle += pi / 100;
        if (rotationAngle >= 2 * pi) {
          rotationAngle -= 2 * pi;
        }
      });
      startRotation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> segments = [
      {
        'label': 'Shopping',
        'colors': [Colors.deepOrangeAccent, Colors.orange.shade400],
        'icon': Iconsax.shopping_cart,
      },
      {
        'label': 'Food',
        'colors': [Colors.lightGreen, Colors.blue.shade400],
        'icon': Iconsax.coffee,
      },
      {
        'label': 'Transport',
        'colors': [Colors.blue, Colors.purple.shade400],
        'icon': Iconsax.gas_station,
      },
      {
        'label': 'Rent',
        'colors': [Colors.purple, Colors.deepPurple.shade400],
        'icon': Iconsax.home_1,
      },
    ];
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            title: Text(
              "flutter_devote",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "\$ 1800.0",
                    style: GoogleFonts.bebasNeue(
                        color: Colors.white, fontSize: 35),
                  ),
                  Text(
                    "Available Balance",
                    style: GoogleFonts.poppins(color: Colors.grey[300]),
                  ),
                ],
              ),
              Center(
                child: AnimatedRotation(
                  turns: -rotationAngle / (2 * pi),
                  duration: const Duration(milliseconds: 0),
                  child: CustomPaint(
                    size: const Size(200, 200),
                    painter: GradientRingPainter(segments: segments),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: segments.map((segment) {
              return Column(
                children: [
                  Icon(
                    segment['icon'],
                    color: segment['colors'][1],
                    size: 30,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    segment['label'],
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

// class GradientRingPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     double strokeWidth = 20.0;
//     double radius = (size.width - strokeWidth) / 2;

//     Rect rect = Rect.fromCircle(
//       center: Offset(size.width / 2, size.height / 2),
//       radius: radius,
//     );

//     // 1. Draw the static background ring
//     Paint backgroundPaint = Paint()
//       ..color = Colors.grey.withOpacity(0.2) // Background color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth;

//     canvas.drawCircle(
//       Offset(size.width / 2, size.height / 2),
//       radius,
//       backgroundPaint,
//     );

//     // 2. Draw the rotating gradient ring
//     Paint gradientPaint = Paint()
//       ..shader = SweepGradient(
//         startAngle: 0,
//         endAngle: 2 * pi,
//         colors: [
//           Colors.purple,
//           Colors.blue,
//           Colors.cyan,
//           Colors.green,
//           Colors.purple,
//         ],
//         stops: [0.0, 0.3, 0.6, 0.8, 1.0],
//       ).createShader(rect)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth
//       ..strokeCap = StrokeCap.round;

//     canvas.drawArc(
//       rect,
//       pi / 4, // Start angle
//       3 * pi / 2, // Sweep angle
//       false,
//       gradientPaint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// class GradientRingPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     double strokeWidth = 40.0;
//     double radius = (size.width - strokeWidth) / 1.5;

//     Rect rect = Rect.fromCircle(
//       center: Offset(size.width / 2, size.height / 2),
//       radius: radius,
//     );

//     // Static background ring
//     Paint backgroundPaint = Paint()
//       ..color = Colors.grey.withValues(alpha: 0.2)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth;

//     canvas.drawCircle(
//       Offset(size.width / 2, size.height / 2),
//       radius,
//       backgroundPaint,
//     );

//     // Segments data: [start angle, sweep angle, gradient]
//     List<Map<String, dynamic>> segments = [
//       {
//         'startAngle': pi / 4,
//         'sweepAngle': pi / 6,
//         'colors': [Colors.green, Colors.lightGreen],
//       },
//       {
//         'startAngle': pi / 4 + pi / 6,
//         'sweepAngle': pi / 6,
//         'colors': [Colors.lightGreen, Colors.blue],
//       },
//       {
//         'startAngle': pi / 4 + 2 * pi / 6,
//         'sweepAngle': pi / 6,
//         'colors': [Colors.blue, Colors.purple],
//       },
//       {
//         'startAngle': pi / 4 + 3 * pi / 6,
//         'sweepAngle': pi / 6,
//         'colors': [Colors.purple, Colors.deepPurple],
//       },
//     ];

//     // Draw segmented arcs
//     for (var segment in segments) {
//       Paint segmentPaint = Paint()
//         ..shader = SweepGradient(
//           startAngle: segment['startAngle'],
//           endAngle: segment['startAngle'] + segment['sweepAngle'],
//           colors: segment['colors'],
//         ).createShader(rect)
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = strokeWidth
//         ..strokeCap = StrokeCap.round;

//       canvas.drawArc(
//         rect,
//         segment['startAngle'],
//         segment['sweepAngle'],
//         false,
//         segmentPaint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

class GradientRingPainter extends CustomPainter {
  final List<Map<String, dynamic>> segments;

  GradientRingPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 40.0;
    double radius = (size.width - strokeWidth) / 1.5;

    Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    );

    // Static background ring
    Paint backgroundPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius,
      backgroundPaint,
    );

    // Calculate start angles for segments
    double startAngle = pi / 4; // Starting angle
    double sweepAngle = (2 * pi - pi / 2) / segments.length; // Divide equally

    for (var segment in segments) {
      Paint segmentPaint = Paint()
        ..shader = SweepGradient(
          startAngle: startAngle,
          endAngle: startAngle + sweepAngle,
          colors: segment['colors'],
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle,
        false,
        segmentPaint,
      );

      startAngle += sweepAngle; // Update start angle for next segment
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
