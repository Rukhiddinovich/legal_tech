import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Pulslanuvchi onlayn (yashil) nuqta.
///
/// Dizayndagi `ad-pulse` animatsiyasining Flutter ekvivalenti.
class OnlineDot extends StatefulWidget {
  const OnlineDot({
    super.key,
    this.size = 9,
    this.color = AppColors.online,
    this.animate = true,
    this.ringColor,
  });

  final double size;
  final Color color;
  final bool animate;
  final Color? ringColor;

  @override
  State<OnlineDot> createState() => _OnlineDotState();
}

class _OnlineDotState extends State<OnlineDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  @override
  void initState() {
    super.initState();
    if (widget.animate) _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dot = Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: widget.color,
        shape: BoxShape.circle,
        boxShadow: widget.ringColor != null
            ? [
                BoxShadow(
                  color: widget.ringColor!,
                  blurRadius: 0,
                  spreadRadius: 3,
                ),
              ]
            : null,
      ),
    );

    if (!widget.animate) return dot;

    return FadeTransition(
      opacity: Tween<double>(begin: 1, end: 0.45).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: ScaleTransition(
        scale: Tween<double>(begin: 1, end: 0.82).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        ),
        child: dot,
      ),
    );
  }
}
