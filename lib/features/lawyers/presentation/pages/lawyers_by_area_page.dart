import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/view_status.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/adolat_loader.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../catalog/presentation/widgets/lawyer_card.dart';
import '../../../law_areas/domain/entities/law_area.dart';
import '../../domain/entities/lawyer.dart';
import '../bloc/lawyers_by_area_bloc.dart';
import '../../../../core/router/app_route_names.dart';

class LawyersByAreaPage extends StatefulWidget {
  const LawyersByAreaPage({super.key, required this.area});

  final LawArea area;

  @override
  State<LawyersByAreaPage> createState() => _LawyersByAreaPageState();
}

class _LawyersByAreaPageState extends State<LawyersByAreaPage> {
  String _sortFilter = 'default'; // default, rating, online, experience, price_low

  void _showSortSheet(BuildContext context) async {
    final selected = await showMaterialModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Material(
        color: Theme.of(ctx).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderStrong,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GlobalText(
                text: 'Saralash',
                translate: false,
                fontSize: 16.5,
                fontWeight: FontWeight.w700,
                color: Theme.of(ctx).colorScheme.onSurface,
              ),
              const SizedBox(height: 14),
              _sortOption(ctx, 'Asl holati', 'default'),
              const Divider(),
              _sortOption(ctx, 'Reyting bo\'yicha (yuqoridan)', 'rating'),
              const Divider(),
              _sortOption(ctx, 'Onlayn birinchi', 'online'),
              const Divider(),
              _sortOption(ctx, 'Tajriba bo\'yicha', 'experience'),
              const Divider(),
              _sortOption(ctx, 'Arzon narx birinchi', 'price_low'),
            ],
          ),
        ),
      ),
    );

    if (selected != null) {
      setState(() {
        _sortFilter = selected;
      });
    }
  }

  Widget _sortOption(BuildContext ctx, String label, String key) {
    final isSelected = _sortFilter == key;
    final isDark = Theme.of(ctx).brightness == Brightness.dark;
    final activeColor = isDark ? AppColors.gold : AppColors.navy;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: GlobalText(
        text: label,
        translate: false,
        fontSize: 14,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        color: isSelected ? activeColor : Theme.of(ctx).colorScheme.onSurface,
      ),
      trailing: isSelected 
          ? Icon(CupertinoIcons.checkmark_alt_circle_fill, color: activeColor) 
          : null,
      onTap: () => Navigator.pop(ctx, key),
    );
  }

  List<Lawyer> _getSortedLawyers(List<Lawyer> lawyers) {
    final list = List<Lawyer>.from(lawyers);
    if (_sortFilter == 'rating') {
      list.sort((a, b) => b.rating.compareTo(a.rating));
    } else if (_sortFilter == 'online') {
      list.sort((a, b) => (b.isOnline ? 1 : 0).compareTo(a.isOnline ? 1 : 0));
    } else if (_sortFilter == 'experience') {
      list.sort((a, b) => b.experienceYears.compareTo(a.experienceYears));
    } else if (_sortFilter == 'price_low') {
      list.sort((a, b) => a.pricePerSession.compareTo(b.pricePerSession));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LawyersByAreaBloc>()..add(LawyersByAreaStarted(widget.area.id)),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: GlobalAppBar(
          title: GlobalText(
            text: '${widget.area.name} advokatlari',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          actionWidget: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: const Icon(CupertinoIcons.sort_down, color: AppColors.white),
              onPressed: () => _showSortSheet(context),
            ),
          ),
        ),
        body: BlocBuilder<LawyersByAreaBloc, LawyersByAreaState>(
          builder: (context, state) {
            if (state.status.isLoading || state.status.isInitial) {
              return const Center(child: AdolatLoader());
            }

            if (state.status.isFailure) {
              return Center(
                child: GlobalText(
                  text: state.error ?? 'Xatolik yuz berdi',
                  color: Colors.red,
                ),
              );
            }

            if (state.lawyers.isEmpty) {
              return const Center(
                child: GlobalText(
                  text: 'Ushbu yo\'nalishda faol advokatlar topilmadi',
                  color: AppColors.textMuted,
                ),
              );
            }

            final sortedLawyers = _getSortedLawyers(state.lawyers);

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: sortedLawyers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final lawyer = sortedLawyers[index];
                return LawyerCard(
                  lawyer: lawyer,
                  onOpenProfile: () => context.push(AppRouteNames.lawyerProfile, extra: lawyer),
                  onConsult: () => context.push(AppRouteNames.checkout, extra: lawyer),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
