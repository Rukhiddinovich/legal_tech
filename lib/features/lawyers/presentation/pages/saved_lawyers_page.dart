import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_route_names.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../catalog/presentation/widgets/lawyer_card.dart';
import '../bloc/saved_lawyers_bloc.dart';

class SavedLawyersPage extends StatelessWidget {
  const SavedLawyersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: GlobalAppBar(
        title: const GlobalText(
          text: 'Saqlanganlar',
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: BlocBuilder<SavedLawyersBloc, SavedLawyersState>(
        builder: (context, state) {
          if (state.savedLawyers.isEmpty) {
            return const Center(
              child: GlobalText(
                text: 'Hozircha saqlangan advokatlar yo\'q',
                color: AppColors.textMuted,
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: state.savedLawyers.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final lawyer = state.savedLawyers[index];
              return LawyerCard(
                lawyer: lawyer,
                onOpenProfile: () => context.push(AppRouteNames.lawyerProfile, extra: lawyer),
                onConsult: () => context.push(AppRouteNames.checkout, extra: lawyer),
              );
            },
          );
        },
      ),
    );
  }
}
