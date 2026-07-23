import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/view_status.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/adolat_loader.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../catalog/presentation/widgets/lawyer_card.dart';
import '../../../law_areas/domain/entities/law_area.dart';
import '../bloc/lawyers_by_area_bloc.dart';

import 'package:go_router/go_router.dart';
import '../../../../core/router/app_route_names.dart';

class LawyersByAreaPage extends StatelessWidget {
  const LawyersByAreaPage({super.key, required this.area});

  final LawArea area;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LawyersByAreaBloc>()..add(LawyersByAreaStarted(area.id)),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: GlobalAppBar(
          title: GlobalText(
            text: '${area.name} advokatlari',
            fontSize: 16,
            fontWeight: FontWeight.w700,
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

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: state.lawyers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final lawyer = state.lawyers[index];
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
