import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_route_names.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/app_card.dart';

/// "Hujjatlar" tabi — hujjat vositalari va yaratilgan hujjatlar ro'yxati.
class DocumentsHubPage extends StatelessWidget {
  const DocumentsHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 14),
              child: GlobalText(
                text: 'Hujjatlar',
                fontFamily: 'Newsreader',
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _BigToolCard(
                    icon: CupertinoIcons.doc,
                    title: 'Hujjat generatori',
                    subtitle: 'Shartnoma, ariza — PDF',
                    dark: true,
                    onTap: () => context.push(
                      AppRouteNames.documentGenerator,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _BigToolCard(
                    icon: CupertinoIcons.percent,
                    title: 'Boj kalkulyatori',
                    subtitle: 'Sud & notarius boji',
                    dark: false,
                    onTap: () => context.push(
                      AppRouteNames.feeCalculator,
                    ),
                  ),
                ),
              ],
            ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 10),
              child: GlobalText(
                text: 'Yaratilgan hujjatlar',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            ..._recent.map((d) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _DocumentTile(title: d.$1, date: d.$2),
                )),
          ],
        ),
      ),
    );
  }

  static const List<(String, String)> _recent = [
    ('Da\'vo arizasi.pdf', 'Bugun, 14:20'),
    ('Oldi-sotdi shartnomasi.pdf', '12-iyul'),
    ('Ariza — hokimlik.pdf', '8-iyul'),
  ];
}

class _BigToolCard extends StatelessWidget {
  const _BigToolCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.dark,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool dark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = dark ? AppColors.navy : Theme.of(context).cardColor;
    final titleColor =
        dark ? AppColors.white : Theme.of(context).colorScheme.onSurface;
    final subColor =
        dark ? AppColors.white.withValues(alpha: 0.55) : AppColors.textMuted;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: dark ? null : Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: dark
                      ? AppColors.gold.withValues(alpha: 0.22)
                      : AppColors.goldSoft,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(icon, size: 20, color: AppColors.gold),
              ),
              const Spacer(),
              GlobalText(
                text: title,
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                color: titleColor,
              ),
              const SizedBox(height: 3),
              GlobalText(
                text: subtitle,
                fontSize: 11.5,
                color: subColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocumentTile extends StatelessWidget {
  const _DocumentTile({required this.title, required this.date});

  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return AppCard(
      padding: const EdgeInsets.all(14),
      onTap: () {},
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.danger.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(CupertinoIcons.doc_text_fill,
                size: 20, color: AppColors.danger),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(
                  text: title,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: onSurface,
                ),
                const SizedBox(height: 2),
                GlobalText(
                  text: date,
                  fontSize: 11.5,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
          const Icon(CupertinoIcons.arrow_down_to_line, color: AppColors.navy, size: 20),
        ],
      ),
    );
  }
}
