import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/view_status.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_route_names.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/adolat_loader.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/global_text_field.dart';
import '../../../../core/widgets/gradient_avatar.dart';
import '../../../../core/widgets/online_dot.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../lawyers/domain/entities/lawyer.dart';
import '../bloc/catalog_bloc.dart';
import '../widgets/law_area_tile.dart';
import '../widgets/lawyer_card.dart';
import '../widgets/tool_card.dart';

/// 01 — Katalog & qidiruv (Bosh sahifa).
class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  static const _userName = 'Jasur Rahimov';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CatalogBloc>(
      create: (_) => sl<CatalogBloc>()..add(const CatalogStarted()),
      child: const _CatalogView(userName: _userName),
    );
  }
}

class _CatalogView extends StatelessWidget {
  const _CatalogView({required this.userName});

  final String userName;

  void _openProfile(BuildContext context, Lawyer lawyer) {
    context.push(AppRouteNames.lawyerProfile, extra: lawyer);
  }

  void _openCheckout(BuildContext context, Lawyer lawyer) {
    context.push(AppRouteNames.checkout, extra: lawyer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          _Header(userName: userName),
          Expanded(
            child: BlocBuilder<CatalogBloc, CatalogState>(
              builder: (context, state) {
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.xl,
                        22,
                        AppSpacing.xl,
                        24,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          SectionHeader(
                            title: 'Huquq sohalari',
                            actionLabel: 'Barchasi',
                            onAction: () {},
                          ),
                          const SizedBox(height: 13),
                          _AreasGrid(state: state),
                          const SizedBox(height: 16),
                          _ToolsRow(),
                          const SizedBox(height: 22),
                          _OnlineHeader(count: state.onlineCount),
                          const SizedBox(height: 13),
                          ..._buildLawyerList(context, state),
                        ]),
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

  List<Widget> _buildLawyerList(BuildContext context, CatalogState state) {
    if (state.status.isLoading || state.status.isInitial) {
      return const [
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: Center(child: AdolatLoader()),
        ),
      ];
    }
    if (state.lawyers.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Center(
            child: GlobalText(
              text: 'Advokat topilmadi',
              color: AppColors.textMuted,
            ),
          ),
        ),
      ];
    }
    return state.lawyers
        .map(
          (lawyer) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: LawyerCard(
              lawyer: lawyer,
              onOpenProfile: () => _openProfile(context, lawyer),
              onConsult: () => _openCheckout(context, lawyer),
            ),
          ),
        )
        .toList();
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;

    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xl,
        topPad + 14,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      decoration: const BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalText(
                      text: 'Assalomu alaykum,',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 3),
                    GlobalText(
                      text: userName,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
              GradientAvatar(
                name: userName,
                size: 44,
                borderColor: AppColors.navy,
              ),
            ],
          ),
          const SizedBox(height: 20),
          GlobalText(
            text: 'Bugun qanday huquqiy\nyordam kerak?',
            fontFamily: 'Newsreader',
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
            height: 1.25,
          ),
          const SizedBox(height: 18),
          _SearchField(),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalTextField(
      onChanged: (v) =>
          context.read<CatalogBloc>().add(CatalogSearchChanged(v)),
      hintText: 'Advokat yoki soha bo\'yicha qidiring',
      prefixIcon: const Icon(
        CupertinoIcons.search,
        size: 20,
        color: AppColors.textHint,
      ),
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.search,
      validator: (_) => null,
      fillColor: AppColors.white,
      borderColor: AppColors.white,
      borderRadius: 14,
      textColor: AppColors.navyText,
      hintTextColor: AppColors.textHint,
      fontSize: 14,
    );
  }
}

class _AreasGrid extends StatelessWidget {
  const _AreasGrid({required this.state});

  final CatalogState state;

  @override
  Widget build(BuildContext context) {
    if (state.areas.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(child: AdolatLoader()),
      );
    }
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 11,
      mainAxisSpacing: 11,
      childAspectRatio: 0.92,
      children: state.areas
          .map(
            (area) => LawAreaTile(
              area: area,
              selected: state.selectedAreaId == area.id,
              onTap: () =>
                  context.read<CatalogBloc>().add(CatalogAreaSelected(area.id)),
            ),
          )
          .toList(),
    );
  }
}

class _ToolsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        Expanded(
          child: ToolCard(
            icon: CupertinoIcons.doc,
            title: 'Hujjat generatori',
            subtitle: 'Shartnoma, ariza — PDF',
            dark: true,
            onTap: () => context.push(
              AppRouteNames.documentGenerator,
            ),
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: ToolCard(
            icon: CupertinoIcons.percent,
            title: 'Boj kalkulyatori',
            subtitle: 'Sud & notarius boji',
            dark: false,
            onTap: () =>
                context.push(AppRouteNames.feeCalculator),
          ),
        ),
      ],
    ),
    );
  }
}

class _OnlineHeader extends StatelessWidget {
  const _OnlineHeader({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return SectionHeader(
      title: 'Onlayn advokatlar',
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const OnlineDot(size: 7),
          const SizedBox(width: 6),
          GlobalText(
            text: '$count ta faol',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.online,
          ),
        ],
      ),
    );
  }
}
