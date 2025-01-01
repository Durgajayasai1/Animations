import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class NewYear extends StatefulWidget {
  const NewYear({super.key});

  @override
  State<NewYear> createState() => NewYearState();
}

class NewYearState extends State<NewYear> with TickerProviderStateMixin {
  late AnimationController _yearController;
  late AnimationController _fadeController;
  late Animation<Offset> _outgoingAnimation;
  late Animation<Offset> _incomingAnimation;
  late Animation<double> _fadeAnimation;
  bool showFadeText = false;

  @override
  void initState() {
    super.initState();

    _yearController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _outgoingAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(0.0, -1.0),
    ).animate(
        CurvedAnimation(parent: _yearController, curve: Curves.easeInOut));

    _incomingAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(
        CurvedAnimation(parent: _yearController, curve: Curves.easeInOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _yearController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showFadeText = true;
        });
        _fadeController.forward();
      }
    });

    _yearController.forward();
  }

  @override
  void dispose() {
    _yearController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (showFadeText)
            Positioned.fill(
              child: Opacity(
                opacity: 0.5,
                child: Lottie.asset(
                  'assets/lottie/fireworks.json',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showFadeText)
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [Colors.blue, Colors.purple, Colors.deepOrange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        "HAPPY NEW YEAR!",
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "202",
                      style: GoogleFonts.poppins(
                        fontSize: 60,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Stack(
                      children: [
                        if (!showFadeText)
                          SlideTransition(
                            position: _outgoingAnimation,
                            child: Text(
                              "4",
                              style: GoogleFonts.poppins(
                                fontSize: 60,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        SlideTransition(
                          position: _incomingAnimation,
                          child: Text(
                            "5",
                            style: GoogleFonts.poppins(
                              fontSize: 60,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
