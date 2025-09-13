// ignore_for_file: deprecated_member_use, unused_element

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  final List<_Skill> skills = [
    _Skill('Flutter', Icons.flutter_dash, Colors.blue),
    _Skill('Dart', Icons.code, Colors.lightBlue),
    _Skill('Firebase', FontAwesomeIcons.fire, Colors.orange),
    _Skill('PHP', FontAwesomeIcons.php, Colors.purple),
    _Skill('HTML', FontAwesomeIcons.html5, Colors.deepOrange),
    _Skill('CSS', FontAwesomeIcons.css3Alt, Colors.blueAccent),
    _Skill('JavaScript', FontAwesomeIcons.js, Colors.amber),
    _Skill('Google Cloud', FontAwesomeIcons.google, Colors.red),
    _Skill('Linux', FontAwesomeIcons.linux, Colors.yellow),
    _Skill('Windows', FontAwesomeIcons.windows, Colors.blue),
  ];

  late AnimationController _controller;
  int _visibleSkillCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _visibleSkillCount = skills.length);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSkillCard(_Skill skill, bool visible, bool isDark, int index) {
    final double wave = sin((_controller.value * 2 * pi) + (index * 0.6)) * 6;
    final double scale =
        1 + (sin((_controller.value * 2 * pi) + (index * 0.8)) * 0.05);

    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: const Duration(milliseconds: 400),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Transform.translate(
          offset: Offset(0, wave),
          child: Transform.scale(
            scale: scale,
            child: _HoverCard(
              isDark: isDark,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF1e293b), const Color(0xFF0f172a)]
                        : [Colors.white, Colors.grey.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    width: 1.5,
                    color: skill.color.withOpacity(0.6),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: skill.color.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            skill.color.withOpacity(0.9),
                            skill.color.withOpacity(0.4),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: skill.color.withOpacity(0.6),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(skill.icon, size: 35, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        skill.name,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black87,
                          letterSpacing: 1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount;
    double childAspectRatio;

    if (screenWidth < 500) {
      crossAxisCount = 1;
      childAspectRatio = 3.0;
    } else if (screenWidth < 800) {
      crossAxisCount = 2;
      childAspectRatio = 3.5;
    } else {
      crossAxisCount = 3;
      childAspectRatio = 3.8;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          color: isDark ? const Color(0xFF0f172a) : Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Skills',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2962FF),
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      blurRadius: 6,
                      color: const Color(0xFF2962FF).withOpacity(0.5),
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              GridView.count(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  skills.length,
                  (index) => _buildSkillCard(
                      skills[index], index < _visibleSkillCount, isDark, index),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Skill {
  final String name;
  final IconData icon;
  final Color color;
  _Skill(this.name, this.icon, this.color);
}

class _HoverCard extends StatefulWidget {
  final Widget child;
  final bool isDark;
  const _HoverCard({required this.child, required this.isDark, super.key});

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      transform:
          _hovering ? (Matrix4.identity()..scale(1.05)) : Matrix4.identity(),
      decoration: BoxDecoration(
        boxShadow: _hovering
            ? [
                BoxShadow(
                  color: widget.isDark
                      ? Colors.tealAccent.withOpacity(0.4)
                      : Colors.teal.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                )
              ]
            : [],
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: widget.child,
      ),
    );
  }
}
