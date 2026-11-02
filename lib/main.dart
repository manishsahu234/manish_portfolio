import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const PortfolioApp());

const bg = Color(0xFF080B14);
const panel = Color(0xFF111827);
const accent = Color(0xFF8B5CF6);
const cyan = Color(0xFF22D3EE);

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manish Sahu | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(seedColor: accent, brightness: Brightness.dark),
        textTheme: ThemeData.dark().textTheme.apply(bodyColor: const Color(0xFFE5E7EB), displayColor: Colors.white),
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatelessWidget {
  const PortfolioHome({super.key});

  static const skills = ['Flutter', 'Dart', 'BLoC', 'Provider', 'Firebase', 'REST APIs', 'Google Maps', 'Offline-first apps', 'Git', 'CI/CD'];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final wide = width >= 850;
    return Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _nav(context, wide),
            _hero(context, wide),
            _section('ABOUT ME', 'Building useful products with thoughtful engineering',
              'I am a Flutter-focused software developer with experience building cross-platform mobile applications. I enjoy turning complex business workflows into reliable, responsive and user-friendly experiences. My work includes state management, API integrations, offline capabilities, reporting and hardware-connected workflows.'),
            _skills(),
            _experience(),
            _projects(wide),
            _contact(),
            const Padding(padding: EdgeInsets.all(28), child: Text('© 2026 Manish Sahu • Built with Flutter', textAlign: TextAlign.center, style: TextStyle(color: Colors.white38))),
          ]),
        ),
      ),
    );
  }

  Widget _nav(BuildContext context, bool wide) => Padding(
    padding: const EdgeInsets.symmetric(horizontal:  widePadding, vertical: 22),
    child: Row(children: [
      const Text('MS.', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: cyan)),
      const Spacer(),
      if (wide) ...[
        _navLink(context, 'About', 'about'), _navLink(context, 'Skills', 'skills'), _navLink(context, 'Experience', 'experience'), _navLink(context, 'Projects', 'projects'), _navLink(context, 'Contact', 'contact'),
      ] else const Text('FLUTTER DEVELOPER', style: TextStyle(letterSpacing: 1.4, color: Colors.white60, fontSize: 11)),
    ]),
  );

  Widget _navLink(BuildContext context, String label, String id) => TextButton(
    onPressed: () => Scrollable.ensureVisible(_keys[id]!.currentContext!, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut),
    child: Text(label, style: const TextStyle(color: Colors.white70)),
  );

  static const double widePadding = 42;
  static final Map<String, GlobalKey> _keys = {for (final id in ['about','skills','experience','projects','contact']) id: GlobalKey()};

  Widget _hero(BuildContext context, bool wide) => Container(
    padding: EdgeInsets.symmetric(horizontal: wide ? 72 : 26, vertical: wide ? 100 : 68),
    decoration: const BoxDecoration(gradient: RadialGradient(center: Alignment.topRight, radius: 1.25, colors: [Color(0xFF25204A), bg, bg])),
    child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1100), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.circle, size: 9, color: Color(0xFF34D399)), SizedBox(width: 9), Text('OPEN TO SENIOR FLUTTER OPPORTUNITIES', style: TextStyle(color: Color(0xFF9CA3AF), letterSpacing: 1.6, fontSize: 11, fontWeight: FontWeight.w700))]),
      const SizedBox(height: 28),
      Text('Hi, I’m Manish.\nI build apps that scale.', style: TextStyle(fontSize: wide ? 62 : 42, height: 1.08, fontWeight: FontWeight.w900, letterSpacing: -2)),
      const SizedBox(height: 22),
      const Text('Flutter Developer • Dart • BLoC • Firebase', style: TextStyle(color: cyan, fontSize: 17, fontWeight: FontWeight.w600)),
      const SizedBox(height: 18),
       ConstrainedBox(constraints: const BoxConstraints(maxWidth: 650), child: const Text('I create polished cross-platform applications, from responsive interfaces to offline-first workflows and real-world integrations.', style: TextStyle(color: Colors.white60, fontSize: 16, height: 1.7))),
      const SizedBox(height: 32),
      Wrap(spacing: 14, runSpacing: 12, children: [
        FilledButton.icon(onPressed: () => _scroll('projects'), icon: const Icon(Icons.arrow_downward), label: const Text('Explore projects')),
        OutlinedButton.icon(onPressed: () => _scroll('contact'), icon: const Icon(Icons.mail_outline), label: const Text('Contact me')),
      ]),
      const SizedBox(height: 60),
      Wrap(spacing: 36, runSpacing: 20, children: const [
        _Metric(value: '3.5+', label: 'Years Flutter*'), _Metric(value: '1.3+', label: 'Years Mendix*'), _Metric(value: '4', label: 'Featured projects'),
      ]),
      const SizedBox(height: 12),
      const Text('*Experience figures supplied for this portfolio draft; verify before publishing.', style: TextStyle(color: Colors.white30, fontSize: 10)),
    ]))),
  );

  Widget _section(String eyebrow, String title, String body) => Container(
    key: _keys['about'], padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 76),
    child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1000), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _eyebrow(eyebrow), const SizedBox(height: 14), Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)), const SizedBox(height: 18), Text(body, style: const TextStyle(color: Colors.white60, height: 1.8, fontSize: 16)),
    ]))),
  );

  Widget _skills() => Container(key: _keys['skills'], color: const Color(0xFF0D1220), padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 72), child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1000), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _eyebrow('TECHNICAL TOOLKIT'), const SizedBox(height: 14), const Text('Tools I work with', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)), const SizedBox(height: 28),
    Wrap(spacing: 12, runSpacing: 12, children: skills.map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13), decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)), child: Text(s, style: const TextStyle(fontWeight: FontWeight.w600)))).toList()),
  ]))));

  Widget _experience() => Container(key: _keys['experience'], padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 76), child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1000), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _eyebrow('CAREER'), const SizedBox(height: 14), const Text('Experience', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)), const SizedBox(height: 28),
    _infoCard('Senior Consultant', 'Emergys', 'Client: SmartQ • Project: Pulse', 'Worked on enterprise application development for cafeteria and food-service operations. Focus areas include Flutter UI, application workflows, integrations, offline support and operational reporting.'),
    const SizedBox(height: 14),
    _infoCard('Earlier development experience', 'Mendix', 'Low-code application development', 'Contributed to business application development and gained experience with enterprise workflows before focusing on Flutter.'),
  ]))));

  Widget _projects(bool wide) => Container(key: _keys['projects'], color: const Color(0xFF0D1220), padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 76), child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1000), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _eyebrow('SELECTED WORK'), const SizedBox(height: 14), const Text('Projects & product work', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)), const SizedBox(height: 12), const Text('A selection of enterprise projects and areas of contribution.', style: TextStyle(color: Colors.white60)), const SizedBox(height: 28),
    GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: wide ? 2 : 1, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: wide ? 1.45 : 1.7, children: [
      _project('01', 'Pulse • SmartQ', 'Enterprise cafeteria operations platform covering audits, compliance, vendor workflows, reporting, P&L insights and feedback.', ['Flutter', 'Dart', 'BLoC', 'Firebase']),
      _project('02', 'Lens', 'Enterprise application migration from Mendix to Flutter, with a focus on modern mobile experiences.', ['Flutter', 'REST APIs', 'BLoC']),
      _project('03', 'Insights', 'Business insights and operational reporting experience as part of an enterprise application modernization effort.', ['Flutter', 'Charts', 'API integration']),
      _project('04', 'SQLens', 'Enterprise data and analytics application work. Add verified feature details and screenshots before publishing.', ['Flutter', 'Dart', 'Integration']),
    ]),
    const SizedBox(height: 12), const Text('Project descriptions are intentionally high-level. Publish only details and screenshots you are authorized to share.', style: TextStyle(color: Colors.white30, fontSize: 11)),
  ]))));

  Widget _contact() => Container(key: _keys['contact'], padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 80), child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 850), child: Column(children: [
    _eyebrow('LET’S CONNECT'), const SizedBox(height: 14), const Text('Have a Flutter role in mind?', textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)), const SizedBox(height: 16), const Text('I’m interested in opportunities where I can build reliable products and contribute to strong engineering teams.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white60, height: 1.7)), const SizedBox(height: 28),
    Wrap(alignment: WrapAlignment.center, spacing: 12, runSpacing: 12, children: [
      OutlinedButton.icon(onPressed: () => _open('https://www.linkedin.com/in/manishkumar-sahu-400751151/'), icon: const Icon(Icons.work_outline), label: const Text('LinkedIn')),
      OutlinedButton.icon(onPressed: () => _open('https://github.com/REPLACE_WITH_USERNAME'), icon: const Icon(Icons.code), label: const Text('GitHub — update link')),
      OutlinedButton.icon(onPressed: () => _open('mailto:YOUR_EMAIL@example.com'), icon: const Icon(Icons.email_outlined), label: const Text('Email — update address')),
    ]), const SizedBox(height: 20), const Text('Add your email, GitHub profile and resume PDF before publishing.', style: TextStyle(color: Colors.white30, fontSize: 11)),
  ]))));

  Widget _eyebrow(String text) => Text(text, style: const TextStyle(color: cyan, letterSpacing: 2, fontSize: 11, fontWeight: FontWeight.bold));
  Widget _infoCard(String role, String company, String subtitle, String detail) => Container(width: double.infinity, padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(company.toUpperCase(), style: const TextStyle(color: cyan, letterSpacing: 1.4, fontSize: 11, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(role, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(subtitle, style: const TextStyle(color: Colors.white54)), const SizedBox(height: 12), Text(detail, style: const TextStyle(color: Colors.white70, height: 1.6))]));
  Widget _project(String number, String name, String description, List<String> tags) => Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(number, style: const TextStyle(color: accent, fontWeight: FontWeight.w900, fontSize: 13)), const SizedBox(height: 10), Text(name, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)), const SizedBox(height: 10), Expanded(child: Text(description, style: const TextStyle(color: Colors.white60, height: 1.55, fontSize: 13))), Wrap(spacing: 7, runSpacing: 7, children: tags.map((t) => Chip(label: Text(t, style: const TextStyle(fontSize: 10)), visualDensity: VisualDensity.compact, backgroundColor: const Color(0xFF20243A), side: BorderSide.none)).toList())]));

  static void _scroll(String id) { final context = _keys[id]?.currentContext; if (context != null) Scrollable.ensureVisible(context, duration: const Duration(milliseconds: 500)); }
  static Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.value, required this.label});
  final String value, label;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.white)), const SizedBox(height: 4), Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12))]);
}
