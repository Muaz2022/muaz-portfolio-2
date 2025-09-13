import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDarkMode ? const Color(0xFF112240) : Colors.white;
    final textColor = isDarkMode ? Colors.white70 : Colors.black87;
    const royalBlue = Color(0xFF2962FF); // الأزرق الملكي
    final iconColor = isDarkMode ? Colors.tealAccent : Colors.teal;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Text(
            'About Me',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 24 : 32,
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
          const SizedBox(height: 10),

          // Line
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: royalBlue,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: royalBlue.withOpacity(0.5),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Text + image
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: isMobile ? 0 : 40,
                    bottom: isMobile ? 30 : 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'I am a passionate IT specialist and Flutter developer with experience in mobile and web development using Flutter, Firebase, and cloud technologies.\n\nI enjoy building elegant and responsive applications. A highly skilled IT professional with a strong background in:\n\n• Installing & troubleshooting Windows, Mac, Linux\n• Network OS sharing & system cloning\n• Tools: Google Cloud, AOMEI Backupper, REDO Backup\n• Mobile/Web Development: Flutter, Dart, Firebase',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: textColor,
                          height: 1.8,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Contact info
                      Row(
                        children: [
                          Icon(Icons.email, color: iconColor),
                          const SizedBox(width: 8),
                          Text(
                            'moaazmagdi11@gmail.com',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: iconColor),
                          const SizedBox(width: 8),
                          Text(
                            'Saudi Arabia, Riyadh - 14272',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {
                          launchUrl(Uri.parse(
                              'https://drive.google.com/file/d/1wVKqJqe-ZAhouvIliRd_gYNuVbHsgV1Q/view?usp=drivesdk'));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: royalBlue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Resume',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Image
              if (!isMobile)
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                      image: const DecorationImage(
                        image:
                            AssetImage('lib/assets/images/muaz_portfolio1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
