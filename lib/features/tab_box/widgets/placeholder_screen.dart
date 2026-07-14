import 'package:flutter/material.dart';
import 'package:legal_tech/core/constants/app_colors.dart';
import 'package:legal_tech/core/widgets/global_text.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const PlaceholderScreen({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.cB8001F.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 64, color: AppColors.cB8001F),
            ),
            const SizedBox(height: 16),
            GlobalText(
              text: title,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(height: 8),
            const GlobalText(
              text: "Bu sahifa tez orada ishga tushiriladi.",
              fontSize: 14,
              color: AppColors.c757575,
            ),
          ],
        ),
      ),
    );
  }
}
