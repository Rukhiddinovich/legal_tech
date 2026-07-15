import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/view_status.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/global_button.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/global_text_field.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/document_field.dart';
import '../../domain/entities/document_template.dart';
import '../bloc/document_generator_bloc.dart';
import '../widgets/step_indicator.dart';

/// 05 — Hujjat generatori (3 bosqichli wizard).
class DocumentGeneratorPage extends StatelessWidget {
  const DocumentGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DocumentGeneratorBloc>(
      create: (_) => sl<DocumentGeneratorBloc>()..add(const DocumentGeneratorStarted()),
      child: const _GeneratorView(),
    );
  }
}

class _GeneratorView extends StatelessWidget {
  const _GeneratorView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              const _Header(),
              Expanded(
                child: BlocBuilder<DocumentGeneratorBloc,
                    DocumentGeneratorState>(
                  buildWhen: (p, c) =>
                      p.step != c.step ||
                      p.status != c.status ||
                      p.templates != c.templates ||
                      p.selectedTemplate != c.selectedTemplate,
                  builder: (context, state) {
                    if (state.status.isLoading || state.status.isInitial) {
                      return const Center(
                        child:
                            CircularProgressIndicator(color: AppColors.navy),
                      );
                    }
                    return switch (state.step) {
                      DocumentStep.type => _TypeStep(templates: state.templates),
                      DocumentStep.data =>
                        _DataStep(template: state.selectedTemplate!),
                      DocumentStep.done =>
                        _DoneStep(template: state.selectedTemplate!),
                    };
                  },
                ),
              ),
            ],
          ),
          const _BottomBar(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    return Container(
      padding: EdgeInsets.fromLTRB(AppSpacing.xl, topPad + 14, AppSpacing.xl, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _BackCircle(
                onTap: () {
                  final bloc = context.read<DocumentGeneratorBloc>();
                  if (bloc.state.step == DocumentStep.data) {
                    bloc.add(const DocumentBackRequested());
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              const SizedBox(width: 14),
              GlobalText(
                text: 'Hujjat generatori',
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<DocumentGeneratorBloc, DocumentGeneratorState>(
            buildWhen: (p, c) => p.step != c.step,
            builder: (context, state) => StepIndicator(current: state.step),
          ),
        ],
      ),
    );
  }
}

class _BackCircle extends StatelessWidget {
  const _BackCircle({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.chipBg,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          width: 38,
          height: 38,
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 15,
            color: AppColors.navyText,
          ),
        ),
      ),
    );
  }
}

// ── STEP 1: Turi ─────────────────────────────────────────────────
class _TypeStep extends StatelessWidget {
  const _TypeStep({required this.templates});

  final List<DocumentTemplate> templates;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 130),
      children: [
        const SectionHeader(title: 'Hujjat turini tanlang'),
        const SizedBox(height: 12),
        ...templates.map(
          (t) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              onTap: () => context
                  .read<DocumentGeneratorBloc>()
                  .add(DocumentTemplateSelected(t)),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.goldSoft,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Icon(
                      Icons.description_outlined,
                      color: AppColors.goldDark,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalText(
                          text: t.title,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        const SizedBox(height: 2),
                        GlobalText(
                          text: t.subtitle,
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textHint,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── STEP 2: Ma'lumotlar ──────────────────────────────────────────
class _DataStep extends StatelessWidget {
  const _DataStep({required this.template});

  final DocumentTemplate template;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DocumentGeneratorBloc>();
    final halfFields = template.fields.where((f) => f.halfWidth).toList();
    final fullFields = template.fields.where((f) => !f.halfWidth).toList();

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 130),
      children: [
        // Tanlangan hujjat turi
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  color: AppColors.gold,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalText(
                      text: template.title,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                    const SizedBox(height: 2),
                    GlobalText(
                      text: template.subtitle,
                      fontSize: 11,
                      color: AppColors.white.withValues(alpha: 0.55),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => bloc.add(const DocumentBackRequested()),
                child: GlobalText(
                  text: 'O\'zgartirish',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // To'liq kenglikdagi maydonlar
        for (final field in fullFields) ...[
          _Field(
              field: field,
              onChanged: (v) => bloc.add(DocumentValueChanged(field.key, v))),
          const SizedBox(height: 14),
        ],

        // Yarim kenglikdagi maydonlar (juft-juft)
        if (halfFields.isNotEmpty) _HalfRow(fields: halfFields, bloc: bloc),

        const SizedBox(height: 14),
        Row(
          children: [
            const Icon(Icons.lock_outline_rounded, size: 14, color: AppColors.textMuted),
            const SizedBox(width: 8),
            Expanded(
              child: GlobalText(
                text: 'Ma\'lumotlaringiz shifrlangan holda saqlanadi',
                fontSize: 11.5,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _PreviewCard(),
      ],
    );
  }
}

class _HalfRow extends StatelessWidget {
  const _HalfRow({required this.fields, required this.bloc});

  final List<DocumentField> fields;
  final DocumentGeneratorBloc bloc;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (int i = 0; i < fields.length; i += 2) {
      final left = fields[i];
      final right = i + 1 < fields.length ? fields[i + 1] : null;
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _Field(
                  field: left,
                  onChanged: (v) => bloc.add(DocumentValueChanged(left.key, v)),
                ),
              ),
              if (right != null) ...[
                const SizedBox(width: 11),
                Expanded(
                  child: _Field(
                    field: right,
                    onChanged: (v) => bloc.add(DocumentValueChanged(right.key, v)),
                  ),
                ),
              ] else
                const Expanded(child: SizedBox()),
            ],
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.field, required this.onChanged});

  final DocumentField field;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final isNumber = field.type == DocumentFieldType.number;
    final isMultiline = field.type == DocumentFieldType.multiline;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(field.label),
        GlobalTextField(
          hintText: field.hint,
          onChanged: onChanged,
          textInputType: isNumber ? TextInputType.number : TextInputType.text,
          textInputAction:
              isMultiline ? TextInputAction.newline : TextInputAction.next,
          formatter:
              isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
          maxLine: isMultiline ? 4 : 1,
          validator: (_) => null,
        ),
      ],
    );
  }
}

class _PreviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 72,
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.paperBg,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 4,
                  width: 30,
                  margin: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                ..._lines(3, 0.18),
                const SizedBox(height: 3),
                ..._lines(3, 0.1),
              ],
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(
                  text: 'Jonli ko\'rib chiqish',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(height: 3),
                GlobalText(
                  text: 'Yuridik jihatdan to\'g\'ri shablon asosida',
                  fontSize: 11.5,
                  color: AppColors.textMuted,
                  height: 1.45,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _lines(int count, double opacity) {
    return List.generate(
      count,
      (i) => Container(
        height: 2.5,
        margin: const EdgeInsets.only(bottom: 3),
        decoration: BoxDecoration(
          color: AppColors.navy.withValues(alpha: opacity),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

// ── STEP 3: Tayyor ───────────────────────────────────────────────
class _DoneStep extends StatelessWidget {
  const _DoneStep({required this.template});

  final DocumentTemplate template;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 130),
      children: [
        Center(
          child: Container(
            width: 88,
            height: 88,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.online.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: AppColors.online,
              size: 52,
            ),
          ),
        ),
        const SizedBox(height: 22),
        GlobalText(
          text: 'Hujjat tayyor!',
          textAlign: TextAlign.center,
          fontFamily: 'Newsreader',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        const SizedBox(height: 10),
        GlobalText(
          text: '${template.title} yuridik jihatdan to\'g\'ri shablon asosida '
              'yaratildi. Uni PDF ko\'rinishida yuklab olishingiz mumkin.',
          textAlign: TextAlign.center,
          fontSize: 13,
          color: AppColors.textSecondary,
          height: 1.6,
        ),
        const SizedBox(height: 24),
        AppCard(
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.danger.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.picture_as_pdf_rounded,
                  color: AppColors.danger,
                  size: 22,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalText(
                      text: '${template.title}.pdf',
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(height: 2),
                    GlobalText(
                      text: '48 KB · PDF hujjat',
                      fontSize: 11.5,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.download_rounded, color: AppColors.navy),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Pastki panel ─────────────────────────────────────────────────
class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.paddingOf(context).bottom;

    return BlocBuilder<DocumentGeneratorBloc, DocumentGeneratorState>(
      buildWhen: (p, c) =>
          p.step != c.step ||
          p.isGenerating != c.isGenerating ||
          p.canGenerate != c.canGenerate,
      builder: (context, state) {
        if (state.step == DocumentStep.type) return const SizedBox.shrink();

        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 14, 16, bottomPad + 14),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: const Border(top: BorderSide(color: AppColors.divider)),
            ),
            child: _buildButton(context, state),
          ),
        );
      },
    );
  }

  Widget _buildButton(BuildContext context, DocumentGeneratorState state) {
    final bloc = context.read<DocumentGeneratorBloc>();

    if (state.step == DocumentStep.done) {
      return Row(
        children: [
          Expanded(
            child: GlobalButton(
              title: 'Yangi hujjat',
              onTap: () => bloc.add(const DocumentReset()),
              color: Theme.of(context).cardColor,
              textColor: Theme.of(context).colorScheme.onSurface,
              borderColor: AppColors.borderStrong,
              radius: 16,
              fontFamily: 'Manrope',
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            flex: 2,
            child: GlobalButton(
              title: 'Yuklab olish',
              leftIcon: const Icon(
                Icons.download_rounded,
                size: 18,
                color: AppColors.gold,
              ),
              onTap: () {},
              color: AppColors.navy,
              textColor: AppColors.white,
              radius: 16,
              fontFamily: 'Manrope',
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      );
    }

    if (state.isGenerating) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.navy,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.4,
            valueColor: AlwaysStoppedAnimation(AppColors.gold),
          ),
        ),
      );
    }

    return GlobalButton(
      title: 'PDF hujjatni yaratish',
      leftIcon: const Icon(
        Icons.file_download_outlined,
        size: 18,
        color: AppColors.gold,
      ),
      onTap: state.canGenerate
          ? () => bloc.add(const DocumentGenerateRequested())
          : null,
      color: AppColors.navy,
      textColor: AppColors.white,
      radius: 16,
      fontFamily: 'Manrope',
      fontSize: 15,
      fontWeight: FontWeight.w700,
    );
  }
}
