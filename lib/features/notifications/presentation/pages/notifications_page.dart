import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/global_text.dart';

/// Bildirishnomalar sahifasi — alohida screen.
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  static const _notifications = [
    _NotifData(
      title: 'To\'lov tasdiqlandi',
      desc: 'Konsultatsiya uchun to\'lov qabul qilindi. Advokat tez orada bog\'lanadi.',
      time: 'Bugun, 14:32',
      icon: CupertinoIcons.creditcard_fill,
      color: AppColors.online,
    ),
    _NotifData(
      title: 'Tungi rejim faollashtirildi',
      desc: 'Ilova sozlamalarida tungi rejim sozlandi.',
      time: 'Kecha, 22:15',
      icon: CupertinoIcons.moon_fill,
      color: AppColors.gold,
    ),
    _NotifData(
      title: 'Yangi maqola chiqdi',
      desc: 'Huquqiy ko\'rsatmalarda "Turar joy huquqi" yangilandi.',
      time: '20-Iyul, 09:30',
      icon: CupertinoIcons.doc_text_fill,
      color: AppColors.navy,
    ),
    _NotifData(
      title: 'Advokat javob berdi',
      desc: 'Sizning konsultatsiya so\'rovingizga Sardor Aliyev javob berdi.',
      time: '19-Iyul, 16:45',
      icon: CupertinoIcons.chat_bubble_2_fill,
      color: AppColors.online,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: GlobalAppBar(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        title: GlobalText(
          text: 'Bildirishnomalar',
          translate: false,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: onSurface,
        ),
        actionWidget: TextButton(
          onPressed: () {},
          child: const GlobalText(
            text: 'Barchasini o\'qish',
            translate: false,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.gold,
          ),
        ),
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(CupertinoIcons.bell_slash, size: 40, color: AppColors.gold),
                  ),
                  const SizedBox(height: 18),
                  GlobalText(
                    text: 'Hozircha bildirishnomalar yo\'q',
                    translate: false,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: onSurface,
                  ),
                  const SizedBox(height: 6),
                  const GlobalText(
                    text: 'Yangiliklar va xabarlar shu yerda ko\'rinadi',
                    translate: false,
                    fontSize: 12.5,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
            )
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: _notifications.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final notif = _notifications[index];
                return AppCard(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: notif.color.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(notif.icon, size: 18, color: notif.color),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GlobalText(
                              text: notif.title,
                              translate: false,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: onSurface,
                            ),
                            const SizedBox(height: 4),
                            GlobalText(
                              text: notif.desc,
                              translate: false,
                              fontSize: 12,
                              color: AppColors.textMuted,
                              height: 1.4,
                            ),
                            const SizedBox(height: 6),
                            GlobalText(
                              text: notif.time,
                              translate: false,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isDark ? AppColors.darkTextSecondary : AppColors.textHint,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class _NotifData {
  const _NotifData({
    required this.title,
    required this.desc,
    required this.time,
    required this.icon,
    required this.color,
  });

  final String title;
  final String desc;
  final String time;
  final IconData icon;
  final Color color;
}
