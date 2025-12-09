import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingo_buddy/presentation/screens/onboarding_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int index = 0;

  /// ---- SLIDE DATA MODEL ----
  final List<Map<String, dynamic>> slides = [
    {
      "title": "AHOY!",
      "subtitle": "Welcome aboard!",
      "description":
          "Learn Language as you sail\nthrough islands of adventure!",
      "name": "HOPPIE",
      "image": "assets/images/frog.png",
      "shadowColor": Colors.black,
      "shadowBlur": 20.0,
      "shadowSpread": 3.0,
      "buttonInner": const Color(0xFF8FE067),
      "buttonOuter": const Color(0xFF071A2E),
      "buttonOutline": Colors.white,
      "iconColor": Colors.white,
    },
    {
      "title": "FOCUS!",
      "subtitle": "Your Mind!",
      "description":
          "Master words, unlock\ntreasures and level up your\njourney.",
      "name": "MOKSH",
      "image": "assets/images/monk.png",
      "shadowColor": const Color(0xFF3E2A1C),
      "shadowBlur": 20.0,
      "shadowSpread": 3.0,
      "buttonInner": const Color(0xFF724424),
      "buttonOuter": const Color(0xFF071A2E),
      "buttonOutline": Colors.white,
      "iconColor": Colors.white,
    },
    {
      "title": "PREPARE!",
      "subtitle": "For the Quest!",
      "description":
          "Face tougher challenges,\nearn rare rewards & rise as a\ntrue language warrior.",
      "name": "REON",
      "image": "assets/images/old_man.png",
      "shadowColor": const Color(0xFF253347),
      "shadowBlur": 28.0,
      "shadowSpread": 4.0,
      "buttonInner": Colors.white,
      "buttonOuter": const Color(0xFF071A2E),
      "buttonOutline": Colors.black,
      "iconColor": Colors.black,
    },
  ];

  void next() {
    if (index < slides.length - 1) {
      setState(() => index++);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FinalWelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = slides[index];
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF071A2E),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          /// ------------ MAIN UI CONTENT ------------
          Column(
            children: [
              SizedBox(height: size.height * 0.08),

              // Text Widget for TITLE: AnimatedSwitcher for Slide/Fade
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(
                        0.0,
                        0.5,
                      ), // Start from slightly below
                      end: Offset.zero,
                    ).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Text(
                  data["title"],
                  key: ValueKey<int>(index), // <-- Unique key for animation
                  style: GoogleFonts.varelaRound(
                    fontSize: size.height * 0.04,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.008),

              // Text Widget for SUBTITLE: AnimatedSwitcher for Fade
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Text(
                  data["subtitle"],
                  key: ValueKey<int>(index), // <-- Unique key for animation
                  style: GoogleFonts.poppins(
                    fontSize: size.height * 0.028,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.04),

              // Text Widget for DESCRIPTION: AnimatedSwitcher for Slide/Fade
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.10),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 0.5),
                            end: Offset.zero,
                          ).animate(animation),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                  child: Text(
                    data["description"],
                    key: ValueKey<int>(index), // <-- Unique key for animation
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: size.height * 0.020,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.4,
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.05),

              /// ------------ CHARACTER + ANIMATED TRANSITIONS (FIXED) ------------
              Column(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    // Custom transition logic for character images
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      // Check if the child is the NEW (incoming) widget
                      if (child.key == ValueKey<int>(index)) {
                        // Index 1 (Moksh) - Scale/Zoom In Transition
                        if (index == 1) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        }
                        // Index 2 (Reon) - Slide Up Transition
                        else if (index == 2) {
                          return Center(
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(
                                  0.0,
                                  1.0,
                                ), // Start from bottom
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        }
                        // Default/Index 0 (Hoppie) - Fade Transition
                        else {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        }
                      }
                      // If the child is the OLD (outgoing) widget:
                      // Use a fast FadeTransition to make it disappear quickly,
                      // preventing it from visually sliding out as the new one slides in.
                      else {
                        return FadeTransition(
                          opacity: ReverseAnimation(animation),
                          child: child,
                        );
                      }
                    },
                    child: Image.asset(
                      data["image"],
                      key: ValueKey<int>(
                        index,
                      ), // <-- Unique key is crucial for logic
                      height: size.height * 0.21,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Container (Shadow) is correctly commented out
                  SizedBox(height: size.height * 0.08),

                  // Character Name Text: AnimatedSwitcher for Fade
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                    child: Text(
                      data["name"],
                      key: ValueKey<int>(index), // <-- Unique key for animation
                      style: GoogleFonts.poppins(
                        fontSize: size.height * 0.026,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              /// ------------BOTTOM SECTION------------
              Positioned(
                bottom: 0,
                left: -5.0,
                right: -5.0,
                child: Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    // OVAL HILL
                    ClipPath(
                      clipper: BottomCurveClipper(),
                      child: Container(
                        height: size.height * 0.20,
                        width: size.width,
                        color: const Color(0xFF8FE067),
                      ),
                    ),

                    /// NEXT BUTTON
                    Positioned(
                      top: -size.height * 0.045,
                      child: GestureDetector(
                        onTap: next,
                        child: Container(
                          width: size.height * 0.13,
                          height: size.height * 0.13,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: data["buttonOuter"],
                          ),
                          child: Center(
                            child: Container(
                              width: size.height * 0.085,
                              height: size.height * 0.085,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: data["buttonOutline"],
                                  width: 1,
                                ),
                                color: data["buttonInner"],
                              ),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: data["iconColor"],
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.35);

    path.quadraticBezierTo(size.width / 2, -60, size.width, size.height * 0.35);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
