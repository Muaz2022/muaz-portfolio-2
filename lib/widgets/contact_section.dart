// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  ContactSection({super.key});

  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'moaazmagdi11@gmail.com',
    queryParameters: {'subject': 'Portfolio Contact'},
  );

  final Uri _whatsappLaunchUri = Uri.parse('https://wa.me/966542313516');

  Future<void> _launchEmail() async {
    if (await canLaunchUrl(_emailLaunchUri)) {
      await launchUrl(_emailLaunchUri);
    }
  }

  Future<void> _launchWhatsApp() async {
    if (await canLaunchUrl(_whatsappLaunchUri)) {
      await launchUrl(_whatsappLaunchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor =
        isDark ? const Color(0xFF0f172a) : Colors.grey[100]!;
    final cardColor = isDark ? const Color(0xFF112240) : Colors.white;
    final titleColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.white70 : Colors.black54;

    return Container(
      color: backgroundColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Contact Me',
            style: GoogleFonts.poppins(
              fontSize: 28,
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
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildContactCard(
                icon: FontAwesomeIcons.solidEnvelope,
                title: 'Email',
                subtitle: 'moaazmagdi11@gmail.com',
                color: const Color(0xFF2962FF)
                    .withOpacity(0.4), // ظل خفيف بنفس اللون
                onTap: _launchEmail,
                cardColor: cardColor,
                titleColor: titleColor,
                subtitleColor: subtitleColor,
              ),
              _buildContactCard(
                icon: FontAwesomeIcons.whatsapp,
                title: 'WhatsApp',
                subtitle: '+966542313516',
                color: Colors.greenAccent,
                onTap: _launchWhatsApp,
                cardColor: cardColor,
                titleColor: titleColor,
                subtitleColor: subtitleColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    required Color cardColor,
    required Color titleColor,
    required Color subtitleColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: 280,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.robotoMono(
                      fontSize: 13,
                      height: 1.4,
                      color: subtitleColor,
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
