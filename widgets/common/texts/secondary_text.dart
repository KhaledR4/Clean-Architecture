import 'package:flutter/material.dart';

class SecondaryTextInCard extends StatelessWidget {
  final String text;
  const SecondaryTextInCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Text(text,
    style: textTheme.labelSmall!.copyWith(
      color: Colors.grey
      ),
    );
  }
}