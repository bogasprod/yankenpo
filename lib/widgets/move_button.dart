// lib/widgets/move_button.dart
import 'package:flutter/material.dart';
import '../models/move.dart';

class MoveButton extends StatelessWidget {
  final Move move;
  final VoidCallback onTap;
  final double size;

  const MoveButton({
    Key? key,
    required this.move,
    required this.onTap,
    this.size = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        move.assetPath,
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}
