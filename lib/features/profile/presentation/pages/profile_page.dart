import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/gradient_avatar.dart';
import '../../../theme/presentation/bloc/theme_bloc.dart';

/// "Profil" tabi — foydalanuvchi ma'lumotlari va sozlamalar.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const _userName = 'Jasur Rahimov';
  static const _phone = '+998 90 ••• •• 67';

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
                text: 'Profil',
                fontFamily: 'Newsreader',
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            _ProfileHeader(name: _userName, phone: _phone),
            const SizedBox(height: 20),
            _MenuSection(
              title: 'Faoliyat',
              items: [
                _MenuData(Icons.gavel_rounded, 'Konsultatsiyalarim'),
                _MenuData(Icons.description_outlined, 'Hujjatlarim'),
                _MenuData(Icons.favorite_border_rounded, 'Saqlangan advokatlar'),
              ],
            ),
            const SizedBox(height: 16),
            _SettingsSection(),
            const SizedBox(height: 16),
            _MenuSection(
              title: 'Boshqa',
              items: [
                _MenuData(Icons.help_outline_rounded, 'Yordam markazi'),
                _MenuData(Icons.shield_outlined, 'Maxfiylik siyosati'),
                _MenuData(Icons.logout_rounded, 'Chiqish', danger: true),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: GlobalText(
                text: 'Adolat · v1.0.0',
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.name, required this.phone});

  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          GradientAvatar(name: name, size: 60, borderColor: AppColors.navy),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(
                  text: name,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
                const SizedBox(height: 3),
                GlobalText(
                  text: phone,
                  fontSize: 13,
                  color: AppColors.white.withValues(alpha: 0.6),
                ),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.edit_outlined,
                size: 16, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}

class _MenuData {
  const _MenuData(this.icon, this.label, {this.danger = false});

  final IconData icon;
  final String label;
  final bool danger;
}

class _MenuSection extends StatelessWidget {
  const _MenuSection({required this.title, required this.items});

  final String title;
  final List<_MenuData> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: GlobalText(
            text: title,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.textMuted,
            letterSpacing: 0.4,
          ),
        ),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                _MenuTile(data: items[i]),
                if (i < items.length - 1)
                  const Divider(height: 1, indent: 56),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.data});

  final _MenuData data;

  @override
  Widget build(BuildContext context) {
    final color = data.danger
        ? AppColors.danger
        : Theme.of(context).colorScheme.onSurface;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(data.icon, size: 20, color: color),
              const SizedBox(width: 16),
              Expanded(
                child: GlobalText(
                  text: data.label,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              if (!data.danger)
                const Icon(Icons.chevron_right_rounded,
                    color: AppColors.textHint),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  void _showLanguageDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GlobalText(
                text: 'Tilni tanlang / Выберите язык',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: GlobalText(
                  text: "O'zbekcha",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                trailing: context.locale.languageCode == 'uz'
                    ? const Icon(Icons.check, color: AppColors.gold)
                    : null,
                onTap: () {
                  context.setLocale(const Locale('uz', 'UZ'));
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                title: GlobalText(
                  text: "Русский",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                trailing: context.locale.languageCode == 'ru'
                    ? const Icon(Icons.check, color: AppColors.gold)
                    : null,
                onTap: () {
                  context.setLocale(const Locale('ru', 'RU'));
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: GlobalText(
            text: 'Sozlamalar',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.textMuted,
            letterSpacing: 0.4,
          ),
        ),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.dark_mode_outlined,
                      size: 20,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GlobalText(
                        text: 'Tungi rejim',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    BlocBuilder<ThemeBloc, ThemeMode>(
                      builder: (context, mode) => Switch.adaptive(
                        value: mode == ThemeMode.dark,
                        activeTrackColor: AppColors.gold,
                        onChanged: (_) =>
                            context.read<ThemeBloc>().add(const ThemeToggled()),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, indent: 56),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _showLanguageDialog(context),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Icon(
                          Icons.language_rounded,
                          size: 20,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GlobalText(
                            text: 'Til',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        GlobalText(
                          text: context.locale.languageCode == 'ru'
                              ? 'Русский'
                              : 'O\'zbekcha',
                          fontSize: 13,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right_rounded,
                            color: AppColors.textHint),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
