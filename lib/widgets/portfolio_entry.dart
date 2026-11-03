import 'dart:async';
import 'package:flutter/material.dart';

class PortfolioEntry extends StatefulWidget {
  const PortfolioEntry({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<PortfolioEntry> createState() => _PortfolioEntryState();
}

class _PortfolioEntryState extends State<PortfolioEntry>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> fade;
  late final Animation<double> scale;

  bool done = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    fade = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutCubic,
    );

    scale = Tween<double>(
      begin: 0.78,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );

    controller.forward();

    Timer(const Duration(milliseconds: 1800), () {
      if (mounted) {
        setState(() => done = true);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 700),
      child: done
          ? KeyedSubtree(
              key: const ValueKey('site'),
              child: widget.child,
            )
          : Scaffold(
              key: const ValueKey('loader'),
              backgroundColor: const Color(0xFF050505),
              body: Center(
                child: FadeTransition(
                  opacity: fade,
                  child: ScaleTransition(
                    scale: scale,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 108,
                          height: 108,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: const Color(0xFFC6A96B),
                              width: 1.4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFC6A96B)
                                    .withValues(alpha: 0.14),
                                blurRadius: 35,
                              ),
                            ],
                          ),
                          child: const Text(
                            'MS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        const Text(
                          'MANISH SAHU',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'FLUTTER DEVELOPER',
                          style: TextStyle(
                            color: Color(0xFFC6A96B),
                            fontSize: 9,
                            letterSpacing: 2.8,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const SizedBox(
                          width: 120,
                          child: LinearProgressIndicator(
                            minHeight: 2,
                            backgroundColor: Color(0xFF262626),
                            valueColor: AlwaysStoppedAnimation(
                              Color(0xFFC6A96B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
