// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  final List<Map<String, dynamic>> projects = const [
    {
      'name': 'Flutter Portfolio',
      'description':
          'A personal portfolio website developed using Flutter Web and Firebase Hosting, showcasing my skills, projects, and contact details.',
      'url': 'https://muaz-portfoio.web.app/',
      'screenshots': ['lib/assets/images/portfoio.jpg'],
    },
    {
      'name': 'Dlinks Engineering Company',
      'description':
          'A corporate website built for Dlinks Engineering Company, specialized in building residential properties.',
      'url': 'https://dlinks-sd.com/',
      'screenshots': ['lib/assets/images/dlink.jpg'],
    },
    {
      'name': 'E-Commerce App',
      'description':
          'A complete E-Commerce mobile application developed using Flutter with Firebase Firestore, Authentication, and Storage.',
      'url': 'https://github.com/Muaz2022/Auto-Motors-screenshots',
      'screenshots': [
        'lib/assets/images/shop1.jpg',
        'lib/assets/images/shop2.jpg',
        'lib/assets/images/shop3.jpg',
        'lib/assets/images/shop4.jpg',
        'lib/assets/images/shop6.jpg',
        'lib/assets/images/shop10.jpg',
      ],
    },
    {
      'name': 'Training Center System',
      'description':
          'A Training Center management system with a website for students and a desktop app for admins. Built with PHP and Java Windows App.',
      'url': 'https://github.com/Muaz2022/Traning-Center-System.git',
      'screenshots': [
        'lib/assets/images/Traning1.jpg',
        'lib/assets/images/Traning2.jpg',
      ],
    },
  ];

  void _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0f172a) : Colors.grey[50]!;
    final cardColor = isDark ? const Color(0xFF1e293b) : Colors.white;
    final textColor = isDark ? Colors.white70 : Colors.black87;
    final titleColor = const Color(0xFF2962FF);

    return Container(
      color: backgroundColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '💻 My Projects',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: titleColor,
              letterSpacing: 1.2,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: titleColor.withOpacity(0.5),
                  offset: const Offset(2, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              double childAspectRatio;

              if (constraints.maxWidth < 600) {
                crossAxisCount = 1;
                childAspectRatio = 0.95;
              } else if (constraints.maxWidth < 900) {
                crossAxisCount = 2;
                childAspectRatio = 0.85;
              } else {
                crossAxisCount = 4;
                childAspectRatio = 0.75;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: projects.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: childAspectRatio,
                ),
                itemBuilder: (context, index) {
                  final project = projects[index];
                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(milliseconds: 600 + index * 150),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 40 * (1 - value)),
                        child: Opacity(opacity: value, child: child),
                      );
                    },
                    child: _ProjectCard(
                      project: project,
                      cardColor: cardColor,
                      textColor: textColor,
                      titleColor: titleColor,
                      onLaunch: () => _launchURL(context, project['url']),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final Color cardColor;
  final Color textColor;
  final Color titleColor;
  final VoidCallback onLaunch;

  const _ProjectCard({
    required this.project,
    required this.cardColor,
    required this.textColor,
    required this.titleColor,
    required this.onLaunch,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hover = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    if ((widget.project['screenshots'] as List).length > 1) {
      Future.delayed(const Duration(seconds: 3), _nextImage);
    }
  }

  void _nextImage() {
    if (!mounted) return;
    setState(() {
      _currentIndex =
          (_currentIndex + 1) % (widget.project['screenshots'] as List).length;
    });
    Future.delayed(const Duration(seconds: 3), _nextImage);
  }

  void _showFullImage(String imagePath) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenshots = widget.project['screenshots'] as List;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: widget.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hover
                ? widget.titleColor.withOpacity(0.6)
                : widget.titleColor.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color:
                  _hover ? widget.titleColor.withOpacity(0.3) : Colors.black12,
              blurRadius: _hover ? 18 : 8,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.project['name'],
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: widget.titleColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.project['description'],
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: widget.textColor,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            if (screenshots.isNotEmpty)
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _showFullImage(screenshots[_currentIndex]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 300),
                        scale: _hover ? 1.03 : 1,
                        child: Image.asset(
                          screenshots[_currentIndex],
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      screenshots.length,
                      (i) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == _currentIndex
                              ? widget.titleColor
                              : widget.titleColor.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: widget.onLaunch,
                icon: const Icon(Icons.open_in_new, size: 18),
                label: const Text("Visit"),
                style: TextButton.styleFrom(
                  foregroundColor: widget.titleColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
