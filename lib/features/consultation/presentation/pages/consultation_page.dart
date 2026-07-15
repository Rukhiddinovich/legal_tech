import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/view_status.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/global_text_field.dart';
import '../../../../core/widgets/gradient_avatar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldAlt,
      body: Stack(
        children: [
          Column(
            children: [
              _ChatHeader(lawyer: widget.lawyer),
              Expanded(
                child: BlocConsumer<ConsultationBloc, ConsultationState>(
                  listenWhen: (p, c) => p.messages.length != c.messages.length,
                  listener: (context, state) => _scrollToBottom(),
                  builder: (context, state) {
                    if (state.status.isLoading || state.status.isInitial) {
                      return const Center(
                        child: CircularProgressIndicator(color: AppColors.navy),
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
              _InputBar(controller: _inputController, onSend: _send),
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

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({required this.lawyer});

  final Lawyer lawyer;

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;

    return Container(
      padding: EdgeInsets.fromLTRB(16, topPad + 10, 16, 14),
      color: AppColors.navy,
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
                    color: AppColors.white,
                  ),
                ),
              ),
              GradientAvatar(
                name: lawyer.fullName,
                size: 40,
                online: lawyer.isOnline,
                borderColor: AppColors.navy,
                fontSize: 13,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalText(
                      text: lawyer.fullName,
                      maxLines: 1,
                      isEllipsis: true,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                    GlobalText(
                      text: lawyer.isOnline ? 'onlayn' : 'oflayn',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: lawyer.isOnline
                          ? AppColors.online
                          : AppColors.textHint,
                    ),
                  ],
                ),
              ),
              _HeaderCircle(
                icon: Icons.call_outlined,
                background: AppColors.white.withValues(alpha: 0.12),
                iconColor: AppColors.white,
              ),
              const SizedBox(width: 8),
              _HeaderCircle(
                icon: Icons.videocam_outlined,
                background: AppColors.gold.withValues(alpha: 0.9),
                iconColor: AppColors.navyText,
              ),
            ],
          ),
          const SizedBox(height: 14),
          const _TimerBar(),
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
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Icon(icon, size: 18, color: iconColor),
    );
  }
}

class _TimerBar extends StatelessWidget {
  const _TimerBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsultationBloc, ConsultationState>(
      buildWhen: (p, c) =>
          p.remainingSeconds != c.remainingSeconds ||
          p.isLowTime != c.isLowTime,
      builder: (context, state) {
        final finished = state.isFinished;
        final accent = finished
            ? AppColors.danger
            : (state.isLowTime ? AppColors.danger : AppColors.gold);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
          decoration: BoxDecoration(
            color: AppColors.gold.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: AppColors.gold.withValues(alpha: 0.35)),
          ),
          child: Row(
            children: [
              Icon(Icons.access_time_rounded, size: 15, color: accent),
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
                    color: AppColors.gold.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: GlobalText(
                    text: '+ Uzaytirish',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
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
  const _InputBar({required this.controller, required this.onSend});

  final TextEditingController controller;
  final VoidCallback onSend;

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
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.chipBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, size: 18, color: AppColors.textMuted),
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
                maxLine: 4,
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
              child: const Icon(Icons.send_rounded, size: 17, color: AppColors.gold),
            ),
          ),
        ],
      ),
    );
  }
}
