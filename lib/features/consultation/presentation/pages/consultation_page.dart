import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/view_status.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_route_names.dart';
import '../../../../core/widgets/adolat_loader.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/global_text_field.dart';
import '../../../../core/widgets/gradient_avatar.dart';
import '../../../../core/widgets/global_button.dart';
import '../../../lawyers/domain/entities/lawyer.dart';
import '../bloc/consultation_bloc.dart';
import '../widgets/anti_contact_overlay.dart';
import '../widgets/message_bubble.dart';

/// 04 — Konsultatsiya chati (timer + xabarlar + anti-chetlab o'tish).
class ConsultationPage extends StatelessWidget {
  const ConsultationPage({super.key, required this.lawyer});

  final Lawyer lawyer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConsultationBloc>(
      create: (_) =>
          sl<ConsultationBloc>()..add(ConsultationStarted(lawyer.id)),
      child: _ConsultationView(lawyer: lawyer),
    );
  }
}

class _ConsultationView extends StatefulWidget {
  const _ConsultationView({required this.lawyer});

  final Lawyer lawyer;

  @override
  State<_ConsultationView> createState() => _ConsultationViewState();
}

class _ConsultationViewState extends State<_ConsultationView> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send() {
    final text = _inputController.text;
    if (text.trim().isEmpty) return;
    context.read<ConsultationBloc>().add(ConsultationMessageSent(text));
    _inputController.clear();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _simulateAttachment(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(CupertinoIcons.photo, color: AppColors.gold),
              title: const Text('Galereyadan rasm tanlash'),
              onTap: () {
                Navigator.pop(ctx);
                context.read<ConsultationBloc>().add(
                  const ConsultationMessageSent('📎 Biriktirilgan rasm: hujjat_nusxasi.jpg'),
                );
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.doc_text, color: AppColors.gold),
              title: const Text('Fayl / PDF yuklash'),
              onTap: () {
                Navigator.pop(ctx);
                context.read<ConsultationBloc>().add(
                  const ConsultationMessageSent('📎 Yuklangan fayl: sud_arizasi.pdf'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _endSession(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Seansni yakunlash'),
        content: const Text('Haqiqatan ham konsultatsiya seansini yakunlamoqchimisiz?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Bekor qilish'),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(ctx);
              context.pushReplacement(AppRouteNames.ratingPage, extra: widget.lawyer);
            },
            child: const Text('Yakunlash'),
          ),
        ],
      ),
    );
  }

  void _openDispute(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _DisputeModal(lawyer: widget.lawyer),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldAlt,
      appBar: GlobalAppBar(
        backgroundColor: AppColors.navy,
        elevation: 0,
        centerTitle: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          behavior: HitTestBehavior.opaque,
          child: const UnconstrainedBox(
            child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                CupertinoIcons.back,
                size: 18,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            GradientAvatar(
              name: widget.lawyer.fullName,
              size: 34,
              online: widget.lawyer.isOnline,
              borderColor: AppColors.navy,
              fontSize: 12,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GlobalText(
                    text: widget.lawyer.fullName,
                    maxLines: 1,
                    isEllipsis: true,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                  GlobalText(
                    text: widget.lawyer.isOnline ? 'onlayn' : 'oflayn',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: widget.lawyer.isOnline
                        ? AppColors.online
                        : AppColors.textHint,
                  ),
                ],
              ),
            ),
          ],
        ),
        actionWidget: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => context.push(
                  AppRouteNames.callPage,
                  extra: {'lawyer': widget.lawyer, 'isVideo': false},
                ),
                child: const _HeaderCircle(
                  icon: CupertinoIcons.phone,
                  background: Color(0x1FFFFFFF),
                  iconColor: AppColors.white,
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () => context.push(
                  AppRouteNames.callPage,
                  extra: {'lawyer': widget.lawyer, 'isVideo': true},
                ),
                child: const _HeaderCircle(
                  icon: CupertinoIcons.video_camera,
                  background: Color(0xE6FFD700), // Gold
                  iconColor: AppColors.navyText,
                ),
              ),
              const SizedBox(width: 10),
              // Yakunlash button
              GestureDetector(
                onTap: () => _endSession(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.danger,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const GlobalText(
                    text: 'Tugatish',
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomWidgets: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: _TimerBar(
              onDispute: () => _openDispute(context),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: BlocConsumer<ConsultationBloc, ConsultationState>(
                  listenWhen: (p, c) => p.messages.length != c.messages.length,
                  listener: (context, state) => _scrollToBottom(),
                  builder: (context, state) {
                    if (state.status.isLoading || state.status.isInitial) {
                      return const Center(
                        child: AdolatLoader(),
                      );
                    }
                    return ListView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
                      children: [
                        const _StartChip(),
                        ...state.messages.map(
                          (m) => MessageBubble(message: m),
                        ),
                      ],
                    );
                  },
                ),
              ),
              _InputBar(
                controller: _inputController,
                onSend: _send,
                onAttach: () => _simulateAttachment(context),
              ),
            ],
          ),
          BlocBuilder<ConsultationBloc, ConsultationState>(
            buildWhen: (p, c) => p.showBlockWarning != c.showBlockWarning,
            builder: (context, state) {
              if (!state.showBlockWarning) return const SizedBox.shrink();
              return AntiContactOverlay(
                blockedSnippet: state.blockedSnippet,
                onDismiss: () => context
                  .read<ConsultationBloc>()
                  .add(const ConsultationWarningDismissed()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HeaderCircle extends StatelessWidget {
  const _HeaderCircle({
    required this.icon,
    required this.background,
    required this.iconColor,
  });

  final IconData icon;
  final Color background;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Icon(icon, size: 15, color: iconColor),
    );
  }
}

class _TimerBar extends StatelessWidget {
  const _TimerBar({required this.onDispute});

  final VoidCallback onDispute;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsultationBloc, ConsultationState>(
      buildWhen: (p, c) =>
          p.remainingSeconds != c.remainingSeconds ||
          p.isLowTime != c.isLowTime,
      builder: (context, state) {
        final finished = state.isFinished;
        final isLow = state.remainingSeconds <= 300; // 5 mins
        final isVeryLow = state.remainingSeconds <= 60; // 1 min

        final accent = finished
            ? AppColors.danger
            : (isVeryLow 
                ? AppColors.danger 
                : (isLow ? Colors.orange : AppColors.gold));

        // Alert logic trigger (Push simulation using Snackbar)
        if (state.remainingSeconds == 300) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            toastification.show(
              context: context,
              type: ToastificationType.warning,
              style: ToastificationStyle.fillColored,
              title: const Text('Diqqat! Seans tugashiga 5 daqiqa qoldi.'),
              autoCloseDuration: const Duration(seconds: 4),
            );
          });
        } else if (state.remainingSeconds == 60) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            toastification.show(
              context: context,
              type: ToastificationType.error,
              style: ToastificationStyle.fillColored,
              title: const Text('Ogohlantirish! Seans tugashiga 1 daqiqa qoldi!'),
              autoCloseDuration: const Duration(seconds: 4),
            );
          });
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: accent.withValues(alpha: 0.35)),
          ),
          child: Row(
            children: [
              Icon(CupertinoIcons.clock, size: 14, color: accent),
              const SizedBox(width: 8),
              GlobalText(
                text: finished
                    ? 'Vaqt tugadi'
                    : '${state.remainingLabel} qoldi',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: accent,
              ),
              const Spacer(),
              // Nizo tugmasi
              GestureDetector(
                onTap: onDispute,
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(CupertinoIcons.exclamationmark_triangle_fill, size: 12, color: AppColors.danger),
                ),
              ),
              GestureDetector(
                onTap: () => context
                    .read<ConsultationBloc>()
                    .add(const ConsultationExtended()),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: GlobalText(
                    text: '+ 15 daq',
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StartChip extends StatelessWidget {
  const _StartChip();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.navy.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
        ),
        child: GlobalText(
          text: 'Konsultatsiya boshlandi · 14:32',
          fontSize: 11,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({
    required this.controller,
    required this.onSend,
    required this.onAttach,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttach;

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.paddingOf(context).bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(12, 11, 12, bottomPad + 10),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          // Attachment file button
          GestureDetector(
            onTap: onAttach,
            child: Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.chipBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(CupertinoIcons.paperclip, size: 18, color: AppColors.textMuted),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.chipBg,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GlobalTextField(
                controller: controller,
                hintText: 'Xabar yozing...',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                validator: (_) => null,
                fillColor: Colors.transparent,
                borderColor: Colors.transparent,
                textColor: AppColors.navyText,
                hintTextColor: AppColors.textHint,
                fontSize: 13,
                contentPadding: const EdgeInsets.symmetric(vertical: 11),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onSend,
            child: Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.navy,
                shape: BoxShape.circle,
              ),
              child: const Icon(CupertinoIcons.paperplane_fill, size: 17, color: AppColors.gold),
            ),
          ),
        ],
      ),
    );
  }
}

class _DisputeModal extends StatefulWidget {
  const _DisputeModal({required this.lawyer});

  final Lawyer lawyer;

  @override
  State<_DisputeModal> createState() => _DisputeModalState();
}

class _DisputeModalState extends State<_DisputeModal> {
  String _selectedReason = 'Advokat javob bermadi';
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitDispute() {
    Navigator.pop(context);
    toastification.show(
      context: context,
      type: ToastificationType.warning,
      style: ToastificationStyle.fillColored,
      title: const Text('Arbitrajda nizo ochildi. Seans va chat tarixi moderatorlar tomonidan ko\'rib chiqiladi.'),
      autoCloseDuration: const Duration(seconds: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.paddingOf(context).bottom + 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
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
            text: 'Nizo ochish / Shikoyat qilish',
            fontSize: 16.5,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          const SizedBox(height: 14),
          const GlobalText(text: 'Shikoyat sababi:', fontSize: 13, fontWeight: FontWeight.w600),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedReason,
            items: ['Advokat javob bermadi', 'Sifatsiz maslahat', 'Boshqa']
                .map((r) => DropdownMenuItem(value: r, child: GlobalText(text: r, fontSize: 13.5)))
                .toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  _selectedReason = val;
                });
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
          const SizedBox(height: 14),
          const GlobalText(text: 'Qo\'shimcha izoh:', fontSize: 13, fontWeight: FontWeight.w600),
          const SizedBox(height: 6),
          GlobalTextField(
            controller: _commentController,
            hintText: 'Muammoni batafsil tasvirlang...',
            maxLine: 3,
            textColor: isDark ? AppColors.white : AppColors.navyText,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            validator: (_) => null,
          ),
          const SizedBox(height: 20),
          GlobalButton(
            onTap: _submitDispute,
            title: 'Nizo Yuborish',
            color: AppColors.danger,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
