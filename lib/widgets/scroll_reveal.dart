import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollReveal extends StatefulWidget {
  const ScrollReveal({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> fade;
  late final Animation<Offset> slide;

  bool started = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    fade = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutCubic,
    );

    slide = Tween<Offset>(
      begin: const Offset(0, 0.09),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('reveal-${identityHashCode(this)}'),
      onVisibilityChanged: (info) {
        if (!started && info.visibleFraction > 0.08) {
          started = true;
          controller.forward();
        }
      },
      child: FadeTransition(
        opacity: fade,
        child: SlideTransition(
          position: slide,
          child: widget.child,
        ),
      ),
    );
  }
}
