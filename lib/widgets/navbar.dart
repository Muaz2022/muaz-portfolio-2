import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Navbar extends StatelessWidget {
  final Function(String) onNavItemClicked;
  final VoidCallback onToggleTheme;
  final bool isDarkMode;
  final Uri _githubUrl = Uri.parse('https://github.com/Muaz2022');

  Navbar({
    super.key,
    required this.onNavItemClicked,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  void _launchGitHub() async {
    if (await canLaunchUrl(_githubUrl)) {
      await launchUrl(_githubUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    final navItems = [
      'Home',
      'About',
      'Skills',
      'Education',
      'Projects',
      'Experience',
      'Contact'
    ];
    final isMobile = MediaQuery.of(context).size.width < 800;
    const royalBlue = Color(0xFF2962FF);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo / الاسم مع تأثير بسيط
          Text(
            'Muaz Majdi',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: royalBlue,
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: royalBlue.withOpacity(0.5),
                  offset: const Offset(2, 2),
                ),
              ],
            ),
          ),

          if (!isMobile)
            Row(
              children: [
                ...navItems.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextButton(
                        onPressed: () => onNavItemClicked(item),
                        child: Text(
                          item,
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )),
                IconButton(
                  icon: Icon(
                    isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: royalBlue,
                  ),
                  tooltip: isDarkMode
                      ? 'Switch to Light Mode'
                      : 'Switch to Dark Mode',
                  onPressed: onToggleTheme,
                ),
                ElevatedButton(
                  onPressed: _launchGitHub,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: royalBlue),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    'GitHub',
                    style: TextStyle(color: royalBlue),
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: royalBlue,
                  ),
                  tooltip: isDarkMode
                      ? 'Switch to Light Mode'
                      : 'Switch to Dark Mode',
                  onPressed: onToggleTheme,
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.menu, color: Colors.tealAccent),
                  color: isDarkMode ? null : Colors.black,
                  onSelected: (value) {
                    if (value == 'GitHub') {
                      _launchGitHub();
                    } else if (value == 'ToggleTheme') {
                      onToggleTheme();
                    } else {
                      onNavItemClicked(value);
                    }
                  },
                  itemBuilder: (context) => [
                    ...navItems.map((item) => PopupMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              color: isDarkMode ? null : Colors.white,
                            ),
                          ),
                        )),
                    PopupMenuItem(
                      value: 'GitHub',
                      child: Text(
                        'GitHub',
                        style: TextStyle(
                          color: isDarkMode ? null : Colors.white,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'ToggleTheme',
                      child: Text(
                        isDarkMode ? 'Light Mode' : 'Dark Mode',
                        style: TextStyle(
                          color: isDarkMode ? null : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
