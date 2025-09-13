// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor =
        isDarkMode ? const Color(0xFF112240) : Colors.grey.shade200;
    final iconColor = isDarkMode ? Colors.white70 : Colors.black87;
    final accentColor = Colors.tealAccent.shade400;
    final textColor = isDarkMode ? Colors.white70 : Colors.black87;
    final textAccentColor = isDarkMode ? Colors.blueAccent : Colors.blueAccent;

    return Container(
      color: backgroundColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 24,
            alignment: WrapAlignment.center,
            children: [
              IconButton(
                icon: FaIcon(FontAwesomeIcons.github, color: iconColor),
                onPressed: () => _launchURL('https://github.com/Muaz2022'),
                tooltip: 'GitHub',
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.linkedin, color: iconColor),
                onPressed: () => _launchURL(
                    'https://www.linkedin.com/in/muaz-majdi-781bb0270'),
                tooltip: 'LinkedIn',
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.instagram, color: iconColor),
                onPressed: () =>
                    _launchURL('https://www.instagram.com/m3vz_mvgdi'),
                tooltip: 'Instagram',
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.facebook, color: iconColor),
                onPressed: () =>
                    _launchURL('https://www.facebook.com/share/19HbJiRdpG/'),
                tooltip: 'Facebook',
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "Muaz :) Portfolio",
            style: GoogleFonts.poppins(
              color: textAccentColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Thank you for visiting my personal portfolio website. Connect with me over socials.',
            style: GoogleFonts.poppins(
              color: textColor,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Keep Rising 🚀. Connect with me over live chat!',
            style: GoogleFonts.poppins(
              color: textAccentColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            '© 2025 Muaz Majdi. All rights reserved.',
            style: GoogleFonts.poppins(
              color: textColor.withOpacity(0.7),
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
