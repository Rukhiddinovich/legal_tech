import 'package:flutter/cupertino.dart';
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
      icon: CupertinoIcons.house,
      activeIcon: CupertinoIcons.house_fill,
      label: 'Bosh',
    ),
    NavItem(
      icon: CupertinoIcons.doc,
      activeIcon: CupertinoIcons.doc_fill,
      label: 'Hujjatlar',
    ),
    NavItem(
      icon: CupertinoIcons.chat_bubble,
      activeIcon: CupertinoIcons.chat_bubble_fill,
      label: 'Chat',
    ),
    NavItem(
      icon: CupertinoIcons.creditcard,
      activeIcon: CupertinoIcons.creditcard_fill,
      label: 'Hamyon',
    ),
    NavItem(
      icon: CupertinoIcons.person,
      activeIcon: CupertinoIcons.person_fill,
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
            extendBody: true,
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
