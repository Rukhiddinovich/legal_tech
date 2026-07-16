import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../catalog/presentation/pages/catalog_page.dart';
import '../../../consultation/presentation/pages/consultation_list_page.dart';
import '../../../documents/presentation/pages/documents_hub_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../wallet/presentation/pages/wallet_page.dart';
import '../bloc/tab_bloc.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  static const _pages = <Widget>[
    CatalogPage(),
    DocumentsHubPage(),
    ConsultationListPage(),
    WalletPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBloc>(
      create: (_) => TabBloc(),
      child: BlocBuilder<TabBloc, int>(
        builder: (context, state) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: IndexedStack(
              index: state.clamp(0, 4),
              children: _pages,
            ),
            bottomNavigationBar: DecoratedBox(
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? AppColors.black : AppColors.navy)
                        .withValues(alpha: isDark ? 0.45 : 0.04),
                    blurRadius: 20,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: _BottomTabItem(
                          index: 0,
                          icon: CupertinoIcons.house,
                          activeIcon: CupertinoIcons.house_fill,
                          label: "Bosh",
                          selectedIndex: state,
                          onTap: (index) {
                            context.read<TabBloc>().add(TabSelected(index));
                          },
                        ),
                      ),
                      Expanded(
                        child: _BottomTabItem(
                          index: 1,
                          icon: CupertinoIcons.doc,
                          activeIcon: CupertinoIcons.doc_fill,
                          label: "Hujjatlar",
                          selectedIndex: state,
                          onTap: (index) {
                            context.read<TabBloc>().add(TabSelected(index));
                          },
                        ),
                      ),
                      Expanded(
                        child: _BottomTabItem(
                          index: 2,
                          icon: CupertinoIcons.chat_bubble,
                          activeIcon: CupertinoIcons.chat_bubble_fill,
                          label: "Chat",
                          selectedIndex: state,
                          onTap: (index) {
                            context.read<TabBloc>().add(TabSelected(index));
                          },
                        ),
                      ),
                      Expanded(
                        child: _BottomTabItem(
                          index: 3,
                          icon: CupertinoIcons.creditcard,
                          activeIcon: CupertinoIcons.creditcard_fill,
                          label: "Hamyon",
                          selectedIndex: state,
                          onTap: (index) {
                            context.read<TabBloc>().add(TabSelected(index));
                          },
                        ),
                      ),
                      Expanded(
                        child: _BottomTabItem(
                          index: 4,
                          icon: CupertinoIcons.person,
                          activeIcon: CupertinoIcons.person_fill,
                          label: "Profil",
                          selectedIndex: state,
                          onTap: (index) {
                            context.read<TabBloc>().add(TabSelected(index));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BottomTabItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _BottomTabItem({
    required this.index,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selected = index == selectedIndex;
    final activeColor = isDark
        ? (selected ? AppColors.gold : AppColors.textMuted)
        : (selected ? AppColors.navy : AppColors.textHint);

    return ZoomTapAnimation(
      onTap: () => onTap(index),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? activeIcon : icon,
              size: 22,
              color: activeColor,
            ),
            const SizedBox(height: 4),
            GlobalText(
              text: label,
              maxLines: 1,
              isEllipsis: true,
              fontSize: 9,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: activeColor,
            ),
          ],
        ),
      ),
    );
  }
}