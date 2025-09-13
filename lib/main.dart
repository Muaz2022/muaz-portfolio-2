// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'widgets/navbar.dart';
import 'widgets/hero_section.dart';
import 'widgets/about_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/projects_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/footer.dart';
import 'widgets/education_section.dart';
import 'widgets/experience.dart';

void main() {
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatefulWidget {
  const MyPortfolio({super.key});

  @override
  State<MyPortfolio> createState() => _MyPortfolioState();
}

class _MyPortfolioState extends State<MyPortfolio> {
  final scrollController = ScrollController();
  bool isDarkMode = true;

  final sectionKeys = {
    'Home': GlobalKey(),
    'About': GlobalKey(),
    'Skills': GlobalKey(),
    'Education': GlobalKey(),
    'Projects': GlobalKey(),
    'Experience': GlobalKey(),
    'Contact': GlobalKey(),
  };

  void scrollToSection(String section) {
    final keyContext = sectionKeys[section]?.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muaz Majdi Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0f172a),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0f172a),
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: Column(
          children: [
            // يمكنك تعديل Navbar لتستقبل زر التبديل
            Navbar(
              onNavItemClicked: scrollToSection,
              onToggleTheme: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
              isDarkMode: isDarkMode,
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Container(
                      key: sectionKeys['Home'],
                      child: HeroSection(
                        onAboutPressed: () => scrollToSection('About'),
                      ),
                    ),
                    Container(
                        key: sectionKeys['About'], child: const AboutSection()),
                    Container(
                        key: sectionKeys['Skills'],
                        child: const SkillsSection()),
                    Container(
                        key: sectionKeys['Education'],
                        child: const EducationSection()),
                    Container(
                        key: sectionKeys['Projects'],
                        child: const ProjectsSection()),
                    Container(
                        key: sectionKeys['Experience'],
                        child: const ExperienceSection()),
                    Container(
                        key: sectionKeys['Contact'], child: ContactSection()),
                    const Footer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
