import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalWelcomeScreen extends StatefulWidget {
  const FinalWelcomeScreen({super.key});

  @override
  State<FinalWelcomeScreen> createState() => _FinalWelcomeScreenState();
}

class _FinalWelcomeScreenState extends State<FinalWelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  double _containerSize = 0.0;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Total animation duration
    );

    // Fade and Scale animation for the Title Text ("JOURNEY! Awaits!")
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.0,
        0.7,
        curve: Curves.easeOut,
      ), // Text animates in the first 70% of the time
    );

    // Start the animation sequence
    _controller.forward().then((_) {
      // After the fade-in, trigger the circular container's size animation
      setState(() {
        _containerSize = 1.0; // Set to full size
        _isInitialized = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF071A2E),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.08),

              /// ---- Title (Animated Fade In) ----
              ScaleTransition(
                scale: _fadeAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      Text(
                        "JOURNEY!",
                        style: GoogleFonts.poppins(
                          fontSize: size.height * 0.055,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.6,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Awaits!",
                        style: GoogleFonts.poppins(
                          fontSize: size.height * 0.030,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.05),

              /// ---- Character Circle (Animated Container) ----
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                width: size.height * 0.30 * (_containerSize == 1.0 ? 1.0 : 0.0),
                height:
                    size.height * 0.30 * (_containerSize == 1.0 ? 1.0 : 0.0),

                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    center: Alignment(0, -0.18),
                    radius: 1.18,
                    colors: [Color(0xFF1C354B), Color(0xFF071A2E)],
                    stops: [0.12, 1.0],
                  ),
                ),

                child: ClipOval(
                  child: Transform.translate(
                    offset: const Offset(
                      0,
                      35,
                    ), // 👈 moves character down to touch bottom
                    child: Image.asset(
                      "assets/images/frog.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),

              /// ---- App Name (Visible after container animation) ----
              FadeTransition(
                opacity: _controller,
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFF5AEAFF), // Bright cyan start
                          Color(0xFFFFFFFF), // White end
                        ],
                      ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                  child: Text(
                    "LingoBreeze",
                    style: GoogleFonts.poppins(
                      fontSize: size.height * 0.032,
                      fontWeight: FontWeight.w600,
                      color: Colors.white, // required as placeholder
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.06),

              /// ---- CTA Button (Visible after container animation) ----
              AnimatedOpacity(
                opacity: _isInitialized ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () {
                    print("Next → Home Screen");
                  },
                  child: Container(
                    width: size.width * 0.60,
                    height: size.height * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.18),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Lets Get Started",
                      style: GoogleFonts.poppins(
                        fontSize: size.height * 0.022,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF071A2E),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
