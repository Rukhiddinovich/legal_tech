import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_route_names.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/global_text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  
  late final Animation<double> _glowScale;
  late final Animation<double> _glowOpacity;
  
  late final Animation<double> _taglineOpacity;
  late final Animation<double> _progressValue;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Glow ring pulsing in size and fading out
    _glowScale = Tween<double>(begin: 0.6, end: 1.4).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
      ),
    );
    
    _glowOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 0.15), weight: 30),
      TweenSequenceItem(tween: Tween<double>(begin: 0.15, end: 0.0), weight: 70),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6),
      ),
    );

    // Logo animations
    _logoScale = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.6, curve: Curves.easeOutBack),
      ),
    );
    
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.5, curve: Curves.easeIn),
      ),
    );

    // Tagline animation
    _taglineOpacity = Tween<double>(begin: 0.0, end: 0.7).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
      ),
    );

    // Progress bar animation
    _progressValue = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.95, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    // Navigate to next screen after completion
    Future.delayed(const Duration(milliseconds: 2300), _goNext);
  }

  void _goNext() {
    if (!mounted) return;
    context.go(AppRouteNames.tabShell);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Premium dark radial gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: [
                  Color(0xFF1E3A54), // Glow center
                  Color(0xFF0C1721), // Mid dark navy
                  Color(0xFF060B10), // Ultra dark edge
                ],
                stops: [0.0, 0.6, 1.0],
              ),
            ),
          ),
          
          // 2. Center logo with pulsing ambient glow ring behind it
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Glow ring
                    Transform.scale(
                      scale: _glowScale.value,
                      child: Opacity(
                        opacity: _glowOpacity.value,
                        child: Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.gold,
                              width: 2.0,
                            ),
                            gradient: RadialGradient(
                              colors: [
                                AppColors.gold.withValues(alpha: 0.2),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // Main Logo
                    Transform.scale(
                      scale: _logoScale.value,
                      child: Opacity(
                        opacity: _logoOpacity.value,
                        child: Image.asset(
                          'assets/images/legal_tech_transparent_logo.png',
                          width: 180,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          
          // 3. Bottom contents (Tagline, Custom slim loading bar)
          Positioned(
            bottom: 60,
            left: 40,
            right: 40,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Tagline
                    Opacity(
                      opacity: _taglineOpacity.value,
                      child: Column(
                        children: [
                          GlobalText(
                            text: 'ADOLAT',
                            fontFamily: 'Newsreader',
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                            letterSpacing: 4,
                          ),
                          const SizedBox(height: 6),
                          GlobalText(
                            text: 'HUQUQIY YORDAM EKOTIZIMI',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.gold,
                            letterSpacing: 2.5,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    
                    // Custom slim loading bar
                    Opacity(
                      opacity: _logoOpacity.value, // matches logo fade
                      child: Column(
                        children: [
                          Container(
                            height: 3,
                            width: 140,
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.centerLeft,
                            child: FractionallySizedBox(
                              widthFactor: _progressValue.value,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.gold,
                                      Color(0xFFE9C481),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.gold.withValues(alpha: 0.4),
                                      blurRadius: 4,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          GlobalText(
                            text: 'Yuklanmoqda...',
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white.withValues(alpha: 0.4),
                            letterSpacing: 1.2,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
