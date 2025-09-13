// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  final List<_ExperienceItem> _experienceList = const [
    _ExperienceItem(
      title: 'Software Engineer',
      company: 'Compuart-sd',
      period: '2021 - 2025',
      description:
          'Translated client requirements into software. Managed full development lifecycle and collaborated with teams.',
    ),
    _ExperienceItem(
      title: 'IT Officer',
      company: 'Nissan',
      period: '2020 - 2021',
      description:
          'Provided tech support and IT solutions including website setup and network troubleshooting.',
    ),
    _ExperienceItem(
      title: 'IT Support',
      company: 'National Petroleum Company',
      period: 'May 2021 - August 2021',
      description:
          'Provided IT support and assisted in internal network troubleshooting and setup.',
    ),
    _ExperienceItem(
      title: 'IT Specialist',
      company: 'Ideals Solution Company',
      period: '2019 - 2020',
      description:
          'Maintained IT systems and supported software installations and user training.',
    ),
    _ExperienceItem(
      title: 'IT Officer',
      company: 'Greater Nile Petroleum Operating Company',
      period: '2018 - 2019',
      description:
          'Oversaw infrastructure and offered IT solutions to ensure smooth operations.',
    ),
  ];

  final List<Color> darkCardColors = const [
    Color(0xFF1e3a8a), // Indigo
    Color(0xFF047857), // Emerald
    Color(0xFF92400e), // Amber
    Color(0xFF7c3aed), // Violet
    Color(0xFF9d174d), // Rose
  ];

  final List<Color> lightCardColors = const [
    Color(0xFFdbeafe), // Light Indigo
    Color(0xFFd1fae5), // Light Emerald
    Color(0xFFfde68a), // Light Amber
    Color(0xFFddd6fe), // Light Violet
    Color(0xFFfbcfe8), // Light Rose
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColors = isDark ? darkCardColors : lightCardColors;

    return Container(
      color: isDark ? const Color(0xFF0f172a) : Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Experience',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 24 : 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2962FF), // أزرق ملكي
              shadows: [
                Shadow(
                  blurRadius: 5,
                  color: const Color(0xFF2962FF)
                      .withOpacity(0.4), // ظل خفيف بنفس اللون
                  offset: const Offset(2, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Column(
            children: List.generate(_experienceList.length, (index) {
              final item = _experienceList[index];
              final color = cardColors[index % cardColors.length];
              return _buildAnimatedExperienceCard(
                  item, index, color, isMobile, isDark);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedExperienceCard(
    _ExperienceItem item,
    int index,
    Color bgColor,
    bool isMobile,
    bool isDark,
  ) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 600 + index * 150),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: bgColor.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : Colors.teal.shade100,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  FontAwesomeIcons.briefcase,
                  color: Colors.teal,
                  size: 20,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 16 : 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${item.company} • ${item.period}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      height: 1.5,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExperienceItem {
  final String title;
  final String company;
  final String period;
  final String description;

  const _ExperienceItem({
    required this.title,
    required this.company,
    required this.period,
    required this.description,
  });
}
