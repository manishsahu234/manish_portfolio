import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/contact_section.dart';
import 'widgets/portfolio_logo.dart';
import 'widgets/scroll_reveal.dart';

const bg = Color(0xFF050505);
const sectionBg = Color(0xFF0B0B0B);
const panel = Color(0xFF121212);
const border = Color(0xFF262626);
const accent = Color(0xFFC6A96B);
const white = Color(0xFFF5F5F5);
const muted = Color(0xFF929292);

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manish Sahu | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        fontFamily: 'Figtree',
        colorScheme: const ColorScheme.dark(
          primary: accent,
          secondary: accent,
          surface: panel,
        ),
        dividerColor: border,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: panel,
          hintStyle: const TextStyle(color: muted),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: accent),
          ),
        ),
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final Map<String, GlobalKey> keys = {
    for (final item in [
      'About',
      'Skills',
      'Experience',
      'Projects',
      'Contact',
    ])
      item: GlobalKey(),
  };

  static const skills = [
    'Flutter',
    'Dart',
    'BLoC',
    'Provider',
    'Firebase',
    'REST API Integration',
    'Google Maps',
    'Offline-first Architecture',
    'JSON Parsing',
    'SQLite / Local Database',
    'Responsive UI',
    'Git',
    'GitHub',
    'CI/CD',
    'Push Notifications',
    'Hardware Integration',
    'PDF Generation',
    'Excel Import / Export',
    'Syncfusion Charts',
  ];

  Widget _profilePhoto() {
    return GestureDetector(
      onTap: () {
        showDialog<void>(
          context: context,
          barrierColor: Colors.black.withValues(alpha: 0.85),
          builder: (dialogContext) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(24),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 420,
                      maxHeight: 550,
                    ),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: panel,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: accent,
                        width: 1.2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: InteractiveViewer(
                        child: Image.asset(
                          'assets/images/profile.jpg',
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) {
                            return const SizedBox(
                              height: 300,
                              child: Center(
                                child: Text(
                                  'Profile image unavailable',
                                  style: TextStyle(color: white),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    icon: const Icon(
                      Icons.close,
                      color: white,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: panel,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 120,
          height: 120,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: accent, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.18),
                blurRadius: 25,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/profile.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: panel,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.person,
                    color: accent,
                    size: 55,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void go(String name) {
    final context = keys[name]?.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> open(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;

    return Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _nav(wide),
              _hero(wide),
              _wrap(
                'About',
                ScrollReveal(
                  child: _section(
                    'PROFESSIONAL SUMMARY',
                    'Building scalable applications with Flutter and Dart.',
                    'Software developer specializing in Flutter application development, with experience building cross-platform mobile applications and enterprise solutions. Skilled in developing responsive user interfaces, integrating REST APIs, implementing state management, Firebase services, offline-first functionality and real-time data synchronization. Focused on writing maintainable code and delivering reliable, user-friendly applications.',
                  ),
                ),
              ),
              _wrap(
                'Skills',
                ScrollReveal(child: _skills()),
                color: sectionBg,
              ),
              _wrap(
                'Experience',
                ScrollReveal(child: _experience()),
              ),
              _wrap(
                'Projects',
                ScrollReveal(child: _projects(wide)),
                color: sectionBg,
              ),
              _wrap(
                'Contact',
                ScrollReveal(child: _contact()),
              ),
              const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  '© 2026 Manish Sahu · Built with Flutter',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: muted,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nav(bool wide) {
    return Container(
      color: bg,
      padding: EdgeInsets.symmetric(
        horizontal: wide ? 60 : 20,
        vertical: 18,
      ),
      child: Row(
        children: [
          const PortfolioLogo(),
          const Spacer(),
          if (wide)
            Wrap(
              spacing: 4,
              children: keys.keys.map((name) {
                return TextButton(
                  onPressed: () => go(name),
                  child: Text(
                    name,
                    style: const TextStyle(color: white),
                  ),
                );
              }).toList(),
            )
          else
            PopupMenuButton<String>(
              color: panel,
              icon: const Icon(Icons.menu, color: white),
              onSelected: go,
              itemBuilder: (_) => keys.keys.map((name) {
                return PopupMenuItem(
                  value: name,
                  child: Text(name),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _hero(bool wide) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: wide ? 70 : 24,
        vertical: wide ? 110 : 72,
      ),
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.9, -0.8),
          radius: 1.15,
          colors: [
            Color(0xFF211D16),
            bg,
            bg,
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profilePhoto(),
              const SizedBox(height: 28),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, size: 8, color: accent),
                  SizedBox(width: 10),
                  Text(
                    'AVAILABLE FOR SELECT OPPORTUNITIES',
                    style: TextStyle(
                      color: accent,
                      fontSize: 10,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Hi, I’m Manish.\nI build apps that scale.',
                style: TextStyle(
                  fontSize: wide ? 68 : 43,
                  height: 1.05,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -2,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'FLUTTER DEVELOPER  ·  DART  ·  BLoC  ·  FIREBASE',
                style: TextStyle(
                  color: accent,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 650),
                child: Text(
                  'I create polished cross-platform applications, from responsive interfaces to offline-first workflows and real-world integrations.',
                  style: TextStyle(
                    color: muted,
                    fontSize: 17,
                    height: 1.8,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton.icon(
                    onPressed: () => go('Projects'),
                    icon: const Icon(Icons.arrow_downward),
                    label: const Text('Explore projects'),
                    style: FilledButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: bg,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 19,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => go('Contact'),
                    icon: const Icon(Icons.arrow_outward),
                    label: const Text('Contact me'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: white,
                      side: const BorderSide(color: border),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 19,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 45),
              const Wrap(
                spacing: 40,
                runSpacing: 20,
                children: [
                  _Metric('Flutter', 'APP DEVELOPMENT'),
                  _Metric('BLoC', 'STATE MANAGEMENT'),
                  _Metric('Cross-platform', 'MOBILE APPLICATIONS'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _wrap(
    String name,
    Widget child, {
    Color color = bg,
  }) {
    return Container(
      key: keys[name],
      color: color,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 26,
              vertical: 76,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _section(
    String eyebrow,
    String title,
    String body,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _eyebrow(eyebrow),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Text(
            body,
            style: const TextStyle(
              color: muted,
              height: 1.9,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _skills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _eyebrow('TECHNICAL TOOLKIT'),
        const SizedBox(height: 16),
        const Text(
          'Tools I work with',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: skills.map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: panel,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: border),
              ),
              child: Text(
                skill,
                style: const TextStyle(
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _experience() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _eyebrow('PROFESSIONAL EXPERIENCE'),
        const SizedBox(height: 16),
        const Text(
          'Work Experience',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 28),
        _infoCard(
          'Senior Consultant',
          'Emergys',
          'Client: SmartQ | Enterprise Application Development',
          'Developing and maintaining cross-platform enterprise applications using Flutter and Dart. Contributing to application architecture, responsive UI development, state management using BLoC, REST API integration, Firebase services and offline-first capabilities. Working on operational workflows, reporting, hardware integrations and application performance improvements.',
        ),
      ],
    );
  }

  Widget _infoCard(
    String role,
    String company,
    String subtitle,
    String detail,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            company.toUpperCase(),
            style: const TextStyle(
              color: accent,
              fontSize: 11,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            role,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(color: muted),
          ),
          const SizedBox(height: 15),
          Text(
            detail,
            style: const TextStyle(
              color: muted,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _projects(bool wide) {
    final data = [
      (
        '01',
        'Pulse · SmartQ',
        'Enterprise cafeteria operations platform featuring audits, compliance tracking, vendor management, P&L analysis, MIS reporting and AI-powered feedback. Developed application features using Flutter, Dart, BLoC and Firebase.',
        ['Flutter', 'Dart', 'BLoC', 'Firebase', 'REST APIs']
      ),
      (
        '02',
        'Lens',
        'Enterprise application modernization project focused on delivering responsive mobile experiences, business workflows and API integrations.',
        ['Flutter', 'Dart', 'BLoC', 'REST APIs']
      ),
      (
        '03',
        'Insights',
        'Business intelligence and operational reporting application featuring data visualization, reporting workflows and enterprise insights.',
        ['Flutter', 'Dart', 'Syncfusion Charts', 'APIs']
      ),
      (
        '04',
        'SQLens',
        'Enterprise application focused on data management, business workflows and reporting capabilities.',
        ['Flutter', 'Dart', 'REST APIs', 'Integration']
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _eyebrow('SELECTED WORK'),
        const SizedBox(height: 16),
        const Text(
          'Projects & product work',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'A selection of enterprise projects and areas of contribution.',
          style: TextStyle(color: muted),
        ),
        const SizedBox(height: 28),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: wide ? 2 : 1,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            mainAxisExtent: 255,
          ),
          itemBuilder: (_, index) {
            return _ProjectCard(data: data[index]);
          },
        ),
        const SizedBox(height: 14),
        const Text(
          'Publish only project details and screenshots you are authorized to share.',
          style: TextStyle(
            color: Color(0xFF666666),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _contact() {
    return Column(
      children: [
        _eyebrow('LET’S CONNECT'),
        const SizedBox(height: 16),
        const Text(
          'Have a Flutter role in mind?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 650),
          child: Text(
            'I’m interested in opportunities where I can build reliable products and contribute to strong engineering teams.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: muted,
              height: 1.8,
            ),
          ),
        ),
        const SizedBox(height: 26),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: [
            _contactButton(
              'LinkedIn',
              Icons.work_outline,
              () => open(
                'https://www.linkedin.com/in/manishkumar-sahu-400751151/',
              ),
            ),
            _contactButton(
              'GitHub',
              Icons.code,
              () => open('https://github.com/manishsahu234'),
            ),
            _contactButton(
              'Email me',
              Icons.email_outlined,
              () => open('mailto:manishsahu363@gmail.com'),
            ),
          ],
        ),
        const SizedBox(height: 32),
        const ContactSection(),
      ],
    );
  }

  Widget _contactButton(
    String label,
    IconData icon,
    VoidCallback action,
  ) {
    return OutlinedButton.icon(
      onPressed: action,
      icon: Icon(icon, size: 17),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: white,
        side: const BorderSide(color: border),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 17,
        ),
      ),
    );
  }

  Widget _eyebrow(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: accent,
        letterSpacing: 2.4,
        fontSize: 11,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.data});

  final (String, String, String, List<String>) data;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final d = widget.data;

    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(
          0,
          hover ? -6 : 0,
          0,
        ),
        padding: const EdgeInsets.all(23),
        decoration: BoxDecoration(
          color: hover ? const Color(0xFF191713) : panel,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: hover ? accent : border,
          ),
          boxShadow: hover
              ? [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.08),
                    blurRadius: 24,
                  ),
                ]
              : const [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  d.$1,
                  style: const TextStyle(
                    color: accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.north_east,
                  color: hover ? accent : muted,
                  size: 18,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              d.$2,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Text(
                d.$3,
                style: const TextStyle(
                  color: muted,
                  fontSize: 13,
                  height: 1.7,
                ),
              ),
            ),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: d.$4.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF211D16),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      color: accent,
                      fontSize: 10,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric(this.value, this.label);

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: white,
            fontSize: 32,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            color: muted,
            fontSize: 10,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
