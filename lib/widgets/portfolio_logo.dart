import 'package:flutter/material.dart';

class PortfolioLogo extends StatelessWidget {
  const PortfolioLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 43,
          height: 43,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF111111),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: const Color(0xFFC6A96B),
            ),
          ),
          child: const Text(
            'MS',
            style: TextStyle(
              color: Color(0xFFF5F5F5),
              fontSize: 17,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'MANISH SAHU',
              style: TextStyle(
                color: Color(0xFFF5F5F5),
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'FLUTTER DEVELOPER',
              style: TextStyle(
                color: Color(0xFFC6A96B),
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
