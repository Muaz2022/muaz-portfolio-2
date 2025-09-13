// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  final List<_EducationItem> _educationList = const [
    _EducationItem(
      title: "Bachelor's Degree in Computer Science",
      institution: "Omdurman Islamic University",
      year: "2015 - 2020",
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI2MdWz22McnpVV8ugQTnWeydZuzhRcWaPtA&s',
    ),
    _EducationItem(
      title: "Website Development",
      institution: "Zero & One Company",
      year: "2021 - 2022",
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/2721/2721274.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark ? const Color(0xFF0f172a) : Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '🎓 Education',
            style: GoogleFonts.poppins(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2962FF),
              shadows: [
                Shadow(
                  blurRadius: 8,
                  color: const Color(0xFF2962FF).withOpacity(0.6),
                  offset: const Offset(2, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Column(
            children: _educationList
                .map((edu) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: _HoverEducationCard(
                        child: _buildEducationCard(edu, isDark),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(_EducationItem edu, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF112240), const Color(0xFF0f172a)]
              : [Colors.white, Colors.grey.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.tealAccent.withOpacity(0.2)
              : Colors.teal.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // صورة مع Glow
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.tealAccent.withOpacity(0.5)
                      : Colors.teal.withOpacity(0.5),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(edu.imageUrl),
              radius: 38,
              backgroundColor:
                  isDark ? Colors.teal.withOpacity(0.2) : Colors.teal.shade50,
            ),
          ),
          const SizedBox(width: 20),
          // النصوص
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.school,
                        size: 20, color: Color(0xFF2962FF)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        edu.title,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  edu.institution,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  edu.year,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.tealAccent : Colors.teal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EducationItem {
  final String title;
  final String institution;
  final String year;
  final String imageUrl;

  const _EducationItem({
    required this.title,
    required this.institution,
    required this.year,
    required this.imageUrl,
  });
}

/// كارد مع أنيميشن hover
class _HoverEducationCard extends StatefulWidget {
  final Widget child;
  const _HoverEducationCard({required this.child});

  @override
  State<_HoverEducationCard> createState() => _HoverEducationCardState();
}

class _HoverEducationCardState extends State<_HoverEducationCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      transform:
          _hovering ? (Matrix4.identity()..scale(1.03)) : Matrix4.identity(),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: widget.child,
      ),
    );
  }
}
