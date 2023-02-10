import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

const _cardRadius = 8.0;

class TypingCard extends StatelessWidget {
  final String text;
  final IconData? icon;

  const TypingCard({
    super.key,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(_cardRadius),
      ),
      child: Row(
        children: [
          if (icon != null)
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 40,
                )),
          AnimatedTextKit(animatedTexts: [
            TypewriterAnimatedText(
              text,
              textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
              speed: const Duration(milliseconds: 100),
            ),
          ]),
        ],
      ),
    );
  }
}
