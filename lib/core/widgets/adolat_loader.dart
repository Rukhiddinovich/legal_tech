import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AdolatLoader extends StatefulWidget {
  const AdolatLoader({
    super.key,
    this.size = 36.0,
    this.color,
  });

  final double size;
  final Color? color;

  @override
  State<AdolatLoader> createState() => _AdolatLoaderState();
}

class _AdolatLoaderState extends State<AdolatLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = widget.color ?? AppColors.gold;
    // Inner ring matches the branding contrast
    final secondaryColor = widget.color != null
        ? widget.color!.withValues(alpha: 0.5)
        : (isDark ? AppColors.white.withValues(alpha: 0.3) : AppColors.navy);

    return Center(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Outer ring rotating clockwise
                Transform.rotate(
                  angle: _controller.value * 2 * 3.14159,
                  child: SizedBox(
                    width: widget.size,
                    height: widget.size,
                    child: CircularProgressIndicator(
                      value: 0.25,
                      strokeWidth: widget.size * 0.08,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                // Inner ring rotating counter-clockwise
                Transform.rotate(
                  angle: -_controller.value * 2 * 3.14159,
                  child: SizedBox(
                    width: widget.size * 0.6,
                    height: widget.size * 0.6,
                    child: CircularProgressIndicator(
                      value: 0.25,
                      strokeWidth: widget.size * 0.06,
                      valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
