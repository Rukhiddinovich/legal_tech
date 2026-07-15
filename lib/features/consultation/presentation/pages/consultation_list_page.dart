import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/router/app_route_names.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/gradient_avatar.dart';
import '../../../lawyers/domain/entities/lawyer.dart';
import '../../../lawyers/domain/usecases/get_lawyers.dart';

/// "Chat" tabi — foydalanuvchining faol konsultatsiyalari ro'yxati.
class ConsultationListPage extends StatefulWidget {
  const ConsultationListPage({super.key});

  @override
  State<ConsultationListPage> createState() => _ConsultationListPageState();
}

class _ConsultationListPageState extends State<ConsultationListPage> {
  late final Future<Either<Failure, List<Lawyer>>> _future =
      sl<GetLawyers>()(const NoParams());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
              child: GlobalText(
                text: 'Suhbatlar',
                fontFamily: 'Newsreader',
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Expanded(
              child: FutureBuilder<Either<Failure, List<Lawyer>>>(
                future: _future,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.navy),
                    );
                  }
                  final lawyers = snapshot.data!.getOrElse(() => const []);
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    itemCount: lawyers.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, i) =>
                        _ConversationTile(lawyer: lawyers[i]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({required this.lawyer});

  final Lawyer lawyer;

  static const _previews = [
    'Vasiyat bo\'lmasa, meros qonun bo\'yicha teng bo\'linadi.',
    'Hujjatlarni tayyorlab yubordim, ko\'rib chiqing.',
    'Ertaga soat 15:00 da bo\'shmisiz?',
    'Savolingizga javob berdim, rahmat!',
    'Shartnoma namunasini yubordim.',
  ];

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final preview = _previews[lawyer.id.hashCode.abs() % _previews.length];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: () => Navigator.pushNamed(
          context,
          AppRouteNames.consultation,
          arguments: lawyer,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Row(
            children: [
              GradientAvatar(
                name: lawyer.fullName,
                size: 50,
                online: lawyer.isOnline,
                borderColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GlobalText(
                            text: lawyer.fullName,
                            maxLines: 1,
                            isEllipsis: true,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: onSurface,
                          ),
                        ),
                        GlobalText(
                          text: '14:3${lawyer.id.hashCode.abs() % 9}',
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    GlobalText(
                      text: preview,
                      maxLines: 1,
                      isEllipsis: true,
                      fontSize: 12.5,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
