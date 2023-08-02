import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  int giveRotation(int index) {
    switch (index) {
      case 0:
        return 0;
      case 1:
        return 1;
      case 2:
        return 3;
      case 3:
        return 2;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Center(
            child: Transform.scale(
              scale: 2,
              child: GridView.builder(
                itemCount: 4,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return RotatedBox(
                    quarterTurns: giveRotation(index),
                    child: CustomPaint(
                      painter: HalftonePatternPainter(
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HalftonePatternPainter extends CustomPainter {
  final Color color;
  HalftonePatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (double x = 0; x < 1 + 0.01; x += 0.04) {
      for (double y = 0; y < 1; y += 0.04) {
        double radius = (x * y) * 5;
        canvas.drawCircle(
            Offset(size.width * x, size.height * y), radius, paint);
      }
    }

    canvas.drawCircle(Offset(size.width, size.height), 5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
