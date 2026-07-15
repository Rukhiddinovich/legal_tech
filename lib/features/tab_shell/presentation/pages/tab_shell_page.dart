import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../catalog/presentation/pages/catalog_page.dart';
import '../../../consultation/presentation/pages/consultation_list_page.dart';
import '../../../documents/presentation/pages/documents_hub_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../wallet/presentation/pages/wallet_page.dart';
import '../bloc/tab_bloc.dart';
import '../widgets/bottom_nav_bar.dart';

/// Ilovaning asosiy qobig'i — 5 tabli pastki navigatsiya.
class TabShellPage extends StatelessWidget {
  const TabShellPage({super.key});

  static const _pages = <Widget>[
    CatalogPage(),
    DocumentsHubPage(),
    ConsultationListPage(),
    WalletPage(),
    ProfilePage(),
  ];

  static const _items = <NavItem>[
    NavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Bosh',
    ),
    NavItem(
      icon: Icons.description_outlined,
      activeIcon: Icons.description_rounded,
      label: 'Hujjatlar',
    ),
    NavItem(
      icon: Icons.chat_bubble_outline_rounded,
      activeIcon: Icons.chat_bubble_rounded,
      label: 'Chat',
    ),
    NavItem(
      icon: Icons.account_balance_wallet_outlined,
      activeIcon: Icons.account_balance_wallet_rounded,
      label: 'Hamyon',
    ),
    NavItem(
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      label: 'Profil',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBloc>(
      create: (_) => TabBloc(),
      child: BlocBuilder<TabBloc, int>(
        builder: (context, index) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: IndexedStack(index: index, children: _pages),
            bottomNavigationBar: BottomNavBar(
              items: _items,
              currentIndex: index,
              onTap: (i) => context.read<TabBloc>().add(TabSelected(i)),
            ),
          );
        },
      ),
    );
  }
}
