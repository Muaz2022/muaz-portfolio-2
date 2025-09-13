// ignore_for_file: duplicate_import, deprecated_member_use, unused_field, unused_import, unnecessary_null_comparison, library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onAboutPressed;

  const HeroSection({super.key, required this.onAboutPressed});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  Offset _mousePosition = Offset(-1000, -1000);
  late AnimationController _controller;
  late Animation<double> _animation;
  late List<_Dot> dots;
  final Uri _githubUrl = Uri.parse('https://github.com/Muaz2022');
  final int numberOfDots = 60;
  final double maxDistance = 120;
  Size? _screenSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenSize = MediaQuery.of(context).size;
      dots = List.generate(numberOfDots, (_) => _Dot.random(_screenSize!));

      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 6),
      )
        ..addListener(() {
          setState(() {
            for (final dot in dots) {
              dot.updatePosition(_screenSize!);
            }
          });
        })
        ..repeat();

      _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.linear),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchGitHub() async {
    if (await canLaunchUrl(_githubUrl)) {
      await launchUrl(_githubUrl);
    }
  }

  void _onHover(PointerEvent event) {
    setState(() {
      _mousePosition = event.localPosition;
    });
  }

  void _onExit(PointerEvent event) {
    setState(() {
      _mousePosition = Offset(-1000, -1000);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final backgroundGradient = Theme.of(context).brightness == Brightness.dark
        ? const LinearGradient(
            colors: [Color(0xFF0a192f), Color(0xFF112240)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        : const LinearGradient(
            colors: [Colors.white, Color(0xFFe0f7fa)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          );

    return MouseRegion(
      onHover: _onHover,
      onExit: _onExit,
      child: SizedBox(
        width: double.infinity,
        height: isMobile ? 600 : 600,
        child: Stack(
          children: [
            Container(decoration: BoxDecoration(gradient: backgroundGradient)),
            if (dots != null && _screenSize != null)
              CustomPaint(
                size: _screenSize!,
                painter: DotsPatternPainter(
                  dots,
                  _mousePosition,
                  maxDistance,
                  Theme.of(context).brightness == Brightness.dark,
                ),
              ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: isMobile
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildContent(isMobile, textColor!),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _buildContent(isMobile, textColor!),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContent(bool isMobile, Color textColor) {
    const royalBlue = Color(0xFF2962FF);

    return [
      Expanded(
        flex: 2,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hi there,',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 28 : 32,
                  fontWeight: FontWeight.w500,
                  color: royalBlue,
                ),
              ),
              const SizedBox(height: 10),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: [
                          royalBlue,
                          royalBlue.withOpacity(0.8),
                          Colors.white.withOpacity(0.8), // لمعان خفيف
                          royalBlue,
                          royalBlue.withOpacity(0.8),
                        ],
                        stops: [
                          (_animation.value - 0.3).clamp(0.0, 1.0),
                          (_animation.value - 0.1).clamp(0.0, 1.0),
                          _animation.value.clamp(0.0, 1.0),
                          (_animation.value + 0.1).clamp(0.0, 1.0),
                          (_animation.value + 0.3).clamp(0.0, 1.0),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      "I'm Muaz Majdi",
                      style: GoogleFonts.poppins(
                        fontSize:
                            MediaQuery.of(context).size.width < 800 ? 36 : 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              DefaultTextStyle(
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 16 : 20,
                  color: textColor.withOpacity(0.7),
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  pause: const Duration(milliseconds: 1000),
                  animatedTexts: [
                    TyperAnimatedText('Flutter Developer |'),
                    TyperAnimatedText('Website Designer |'),
                    TyperAnimatedText('IT Specialist |'),
                    TyperAnimatedText('Software Engineer |'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _launchGitHub,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: royalBlue),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Visit My GitHub',
                  style: TextStyle(color: Color(0xFF00BCD4) // Cyan-like
                      ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: isMobile
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.github, color: textColor),
                    iconSize: 30,
                    onPressed: () => launchUrl(Uri.parse(
                        'https://github.com/Muaz2022?tab=repositories')),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.linkedin,
                        color: Color(0xFF0A66C2)),
                    iconSize: 30,
                    onPressed: () => launchUrl(Uri.parse(
                        'https://www.linkedin.com/in/muaz-majdi-781bb0270')),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.instagram,
                        color: Color(0xFFE1306C)),
                    iconSize: 30,
                    onPressed: () => launchUrl(
                        Uri.parse('https://www.instagram.com/m3vz_mvgdi')),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.facebook,
                        color: Color(0xFF1877F2)),
                    iconSize: 30,
                    onPressed: () => launchUrl(Uri.parse(
                        'https://www.facebook.com/share/19HbJiRdpG/')),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Align(
                alignment: isMobile ? Alignment.center : Alignment.centerLeft,
                child: TextButton(
                  onPressed: widget.onAboutPressed,
                  child: const Text(
                    'More About Me ↓',
                    style: TextStyle(
                      color: royalBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 40, height: 40),
      Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.asset(
              'lib/assets/images/muaz_portfolio.jpg',
              width: isMobile ? 180 : 300,
              height: isMobile ? 180 : 300,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ];
  }
}

class _Dot {
  Offset position;
  Offset velocity;
  static final Random _random = Random();

  _Dot.random(Size size)
      : position = Offset(
          _random.nextDouble() * size.width,
          _random.nextDouble() * size.height,
        ),
        velocity = Offset(
          (_random.nextDouble() - 0.5) * 0.5,
          (_random.nextDouble() - 0.5) * 0.5,
        );

  void updatePosition(Size size) {
    position += velocity;

    if (position.dx < 0 || position.dx > size.width) {
      velocity = Offset(-velocity.dx, velocity.dy);
    }
    if (position.dy < 0 || position.dy > size.height) {
      velocity = Offset(velocity.dx, -velocity.dy);
    }
  }
}

class DotsPatternPainter extends CustomPainter {
  final List<_Dot> dots;
  final Offset mousePosition;
  final double maxDistance;
  final bool isDarkMode;

  DotsPatternPainter(
      this.dots, this.mousePosition, this.maxDistance, this.isDarkMode);

  @override
  void paint(Canvas canvas, Size size) {
    const royalBlue = Color(0xFF2962FF);
    final dotColor = isDarkMode
        ? Colors.white.withOpacity(0.4)
        : Colors.black.withOpacity(0.4);
    final lineColor = isDarkMode
        ? Colors.white.withOpacity(0.15)
        : Colors.black.withOpacity(0.15);
    final mouseLineColor = royalBlue.withOpacity(0.25);

    final dotPaint = Paint()..color = dotColor;
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 1;
    final mouseLinePaint = Paint()
      ..color = mouseLineColor
      ..strokeWidth = 1;

    for (final dot in dots) {
      canvas.drawCircle(dot.position, 3, dotPaint);
    }

    for (int i = 0; i < dots.length; i++) {
      for (int j = i + 1; j < dots.length; j++) {
        final dist = (dots[i].position - dots[j].position).distance;
        if (dist < maxDistance) {
          final alpha = (1 - dist / maxDistance) * 0.15;
          linePaint.color = lineColor.withOpacity(alpha);
          canvas.drawLine(dots[i].position, dots[j].position, linePaint);
        }
      }
    }

    for (final dot in dots) {
      final dist = (dot.position - mousePosition).distance;
      if (dist < maxDistance) {
        final alpha = (1 - dist / maxDistance) * 0.3;
        mouseLinePaint.color = mouseLineColor.withOpacity(alpha);
        canvas.drawLine(dot.position, mousePosition, mouseLinePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DotsPatternPainter oldDelegate) {
    return true;
  }
}
