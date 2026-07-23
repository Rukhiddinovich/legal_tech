import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/view_status.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/global_button.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/global_text_field.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/adolat_loader.dart';
import '../../../../core/utils/thousands_input_formatter.dart';
import '../../../../core/utils/passport_input_formatter.dart';
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
      appBar: GlobalAppBar(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        onBackTap: () {
          final bloc = context.read<DocumentGeneratorBloc>();
          if (bloc.state.step == DocumentStep.data) {
            bloc.add(const DocumentBackRequested());
          } else {
            Navigator.pop(context);
          }
        },
        title: GlobalText(
          text: 'Hujjat generatori',
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        bottomWidgets: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.xl, 0, AppSpacing.xl, 16),
            child: BlocBuilder<DocumentGeneratorBloc, DocumentGeneratorState>(
              buildWhen: (p, c) => p.step != c.step,
              builder: (context, state) => StepIndicator(current: state.step),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
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
                        child: AdolatLoader(),
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

// ── STEP 1: Hujjat Turlari Ro'yxati (Guruhlangan) ────────────────
class _TypeStep extends StatelessWidget {
  const _TypeStep({required this.templates});

  final List<DocumentTemplate> templates;

  void _showNotarialWarning(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            const Icon(CupertinoIcons.shield_slash_fill, color: AppColors.danger, size: 48),
            const SizedBox(height: 14),
            const GlobalText(
              text: 'Notarial tasdiq talab etiladi',
              fontSize: 16.5,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 8),
            const GlobalText(
              text: 'Ushbu ishonchnoma hujjati faqat notarius orqali rasmiylashtirilishi shart. Tizim orqali generatsiya qilib bo\'lmaydi.',
              fontSize: 13,
              color: AppColors.textMuted,
              textAlign: TextAlign.center,
              height: 1.45,
            ),
            const SizedBox(height: 24),
            GlobalButton(
              onTap: () {
                Navigator.pop(ctx);
                toastification.show(
                  context: context,
                  type: ToastificationType.info,
                  style: ToastificationStyle.fillColored,
                  title: const Text('Vakolat.uz portaliga yo\'naltirilmoqda...'),
                  autoCloseDuration: const Duration(seconds: 3),
                );
              },
              title: 'Vakolat.uz tizimiga o\'tish',
              color: AppColors.navy,
              textColor: Colors.white,
            ),
            const SizedBox(height: 10),
            GlobalButton(
              onTap: () => Navigator.pop(ctx),
              title: 'Orqaga',
              color: Theme.of(context).cardColor,
              textColor: Theme.of(context).colorScheme.onSurface,
              borderColor: AppColors.borderStrong,
            ),
          ],
        ),
      ),
    );
  }

  void _showPdfPreview(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => FractionallySizedBox(
        heightFactor: 0.85,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderStrong,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GlobalText(text: '$title (Namuna)', fontSize: 16, fontWeight: FontWeight.w700),
                  GestureDetector(
                    onTap: () => Navigator.pop(ctx),
                    child: const Icon(CupertinoIcons.xmark_circle_fill, color: AppColors.textMuted),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Dummy preview document
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.paperBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderStrong),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: GlobalText(
                            text: title.toUpperCase(),
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppColors.navyText,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const GlobalText(text: 'Ushbu bo\'limda hujjatning rasmiy namunasi keltirilgan. Hujjat generatsiya qilingandan so\'ng siz kiritgan ma\'lumotlar mos kataklarga to\'ldiriladi.', fontSize: 11, color: Colors.grey),
                        const SizedBox(height: 20),
                        _previewLine('1. Tomonlar ma\'lumotlari: F.I.SH., Pasport seriyasi va raqami'),
                        _previewLine('2. Kelishuv predmeti va shartlari'),
                        _previewLine('3. Majburiyatlar va nizolarni hal qilish tartibi'),
                        _previewLine('4. Tomonlarning imzolari va manzillari'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _previewLine(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalText(text: text, fontSize: 12, fontWeight: FontWeight.w700),
          const SizedBox(height: 6),
          Container(height: 6, width: double.infinity, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(3))),
          const SizedBox(height: 4),
          Container(height: 6, width: 200, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(3))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Grouping
    final arizalar = templates.where((t) => t.id == 'application').toList();
    final shartnomalar = templates.where((t) => t.id == 'contract').toList();
    final davoArizalar = templates.where((t) => t.id == 'claim').toList();

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 130),
      children: [
        _buildGroup(context, 'Arizalar', arizalar),
        const SizedBox(height: 14),
        _buildGroup(context, 'Shartnomalar', shartnomalar),
        const SizedBox(height: 14),
        _buildGroup(context, 'Sudga da\'vo arizalari', davoArizalar),
        const SizedBox(height: 14),
        
        // Notarial Hujjatlar Group
        const SectionHeader(title: 'Notarial hujjatlar'),
        const SizedBox(height: 10),
        AppCard(
          onTap: () => _showNotarialWarning(context),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.danger.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(CupertinoIcons.shield_slash, color: AppColors.danger, size: 20),
              ),
              const SizedBox(width: 13),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalText(
                      text: 'Ishonchnoma',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 2),
                    GlobalText(
                      text: 'Notarial tasdiq talab etiladi',
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
              const Icon(CupertinoIcons.chevron_right, color: AppColors.textHint, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGroup(BuildContext context, String groupTitle, List<DocumentTemplate> items) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: groupTitle),
        const SizedBox(height: 10),
        ...items.map(
          (t) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
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
                      color: isDark ? AppColors.gold.withValues(alpha: 0.15) : AppColors.goldSoft,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Icon(
                      CupertinoIcons.doc,
                      color: isDark ? AppColors.gold : AppColors.goldDark,
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
                  // Eye Icon for Preview
                  IconButton(
                    icon: const Icon(CupertinoIcons.eye, color: AppColors.goldDark, size: 18),
                    onPressed: () => _showPdfPreview(context, t.title),
                  ),
                  const Icon(
                    CupertinoIcons.chevron_right,
                    color: AppColors.textHint,
                    size: 16,
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

// ── STEP 2: Ma'lumot Kiritish Formasi (✓ Belglari bilan) ─────────
class _DataStep extends StatefulWidget {
  const _DataStep({required this.template});

  final DocumentTemplate template;

  @override
  State<_DataStep> createState() => _DataStepState();
}

class _DataStepState extends State<_DataStep> {
  final Map<String, String> _values = {};

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DocumentGeneratorBloc>();
    final halfFields = widget.template.fields.where((f) => f.halfWidth).toList();
    final fullFields = widget.template.fields.where((f) => !f.halfWidth).toList();

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 130),
      children: [
        // Type Card
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
                child: const Icon(CupertinoIcons.doc, color: AppColors.gold, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalText(
                      text: widget.template.title,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                    const SizedBox(height: 2),
                    GlobalText(
                      text: widget.template.subtitle,
                      fontSize: 11,
                      color: AppColors.white.withValues(alpha: 0.55),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => bloc.add(const DocumentBackRequested()),
                child: const GlobalText(
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

        // Full width inputs
        for (final field in fullFields) ...[
          _buildField(field),
          const SizedBox(height: 14),
        ],

        // Half width inputs
        if (halfFields.isNotEmpty) _buildHalfRow(halfFields),

        const SizedBox(height: 14),
        const Row(
          children: [
            Icon(CupertinoIcons.lock, size: 14, color: AppColors.textMuted),
            SizedBox(width: 8),
            Expanded(
              child: GlobalText(
                text: 'Ma\'lumotlaringiz shifrlangan holda saqlanadi',
                fontSize: 11.5,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildField(DocumentField field) {
    final bloc = context.read<DocumentGeneratorBloc>();
    final isNumber = field.type == DocumentFieldType.number;
    final isMultiline = field.type == DocumentFieldType.multiline;
    final isPassport = field.key == 'passport';

    final value = _values[field.key] ?? '';
    final isFilled = value.isNotEmpty;
    final isValid = !isPassport || value.length == 9;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(field.label),
        GlobalTextField(
          hintText: field.hint,
          onChanged: (val) {
            setState(() {
              if (isNumber) {
                _values[field.key] = val.replaceAll(RegExp(r'[^0-9]'), '');
              } else {
                _values[field.key] = val;
              }
            });
            bloc.add(DocumentValueChanged(field.key, val));
          },
          suffixIcon: isFilled
              ? (isValid 
                  ? const Icon(CupertinoIcons.checkmark_circle_fill, color: AppColors.online, size: 18)
                  : const Icon(CupertinoIcons.exclamationmark_circle_fill, color: AppColors.danger, size: 18))
              : null,
          textInputType: isNumber ? TextInputType.number : TextInputType.text,
          textInputAction: isMultiline ? TextInputAction.newline : TextInputAction.next,
          formatter: isNumber
              ? [FilteringTextInputFormatter.digitsOnly, ThousandsInputFormatter()]
              : isPassport
                  ? [PassportInputFormatter()]
                  : null,
          maxLine: isMultiline ? 4 : 1,
          validator: (val) {
            if (val == null || val.isEmpty) return "Maydonni to'ldiring";
            if (isPassport && val.length != 9) return "Pasport formati xato (masalan: AA1234567)";
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildHalfRow(List<DocumentField> fields) {
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
              Expanded(child: _buildField(left)),
              if (right != null) ...[
                const SizedBox(width: 11),
                Expanded(child: _buildField(right)),
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

// ── STEP 3: Hujjat Tayyor (Natija Sahifasi) ──────────────────────
class _DoneStep extends StatelessWidget {
  const _DoneStep({required this.template});

  final DocumentTemplate template;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
              CupertinoIcons.check_mark_circled_solid,
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
                  CupertinoIcons.doc_text_fill,
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
                    const GlobalText(
                      text: '48 KB · PDF hujjat',
                      fontSize: 11.5,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
              Icon(CupertinoIcons.arrow_down_to_line, color: isDark ? AppColors.white : AppColors.navy),
            ],
          ),
        ),
      ],
    );
  }
}

// ── BOTTOM BAR (PDF Yaratish & Yuklash & Ulashish) ───────────────
class _BottomBar extends StatefulWidget {
  const _BottomBar();

  @override
  State<_BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<_BottomBar> {
  bool _isGeneratingLocal = false;

  void _triggerGeneration(BuildContext context) {
    setState(() {
      _isGeneratingLocal = true;
    });
    // Wait 2 seconds and fire bloc event
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isGeneratingLocal = false;
        });
        context.read<DocumentGeneratorBloc>().add(const DocumentGenerateRequested());
      }
    });
  }

  void _shareDocument(BuildContext context) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      title: const Text('Ulashish oynasi ochildi (Share sheet)'),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
            child: _buildButtonContent(context, state),
          ),
        );
      },
    );
  }

  Widget _buildButtonContent(BuildContext context, DocumentGeneratorState state) {
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
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GlobalButton(
              title: 'Ulashish',
              onTap: () => _shareDocument(context),
              color: Theme.of(context).cardColor,
              textColor: Theme.of(context).colorScheme.onSurface,
              borderColor: AppColors.borderStrong,
              leftIcon: const Icon(CupertinoIcons.share, size: 18),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: GlobalButton(
              title: 'Yuklab olish',
              leftIcon: const Icon(
                CupertinoIcons.arrow_down_to_line,
                size: 18,
                color: AppColors.gold,
              ),
              onTap: () {
                toastification.show(
                  context: context,
                  type: ToastificationType.success,
                  style: ToastificationStyle.fillColored,
                  title: const Text('PDF yuklab olindi'),
                  autoCloseDuration: const Duration(seconds: 3),
                );
              },
              color: AppColors.navy,
              textColor: AppColors.white,
            ),
          ),
        ],
      );
    }

    if (_isGeneratingLocal) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.navy,
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AdolatLoader(size: 20, color: AppColors.gold),
            SizedBox(width: 10),
            GlobalText(text: 'PDF tayyorlanmoqda...', fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
          ],
        ),
      );
    }

    return GlobalButton(
      title: 'PDF hujjatni yaratish',
      leftIcon: const Icon(
        CupertinoIcons.cloud_download,
        size: 18,
        color: AppColors.gold,
      ),
      onTap: state.canGenerate
          ? () => _triggerGeneration(context)
          : null,
      color: AppColors.navy,
      textColor: AppColors.white,
    );
  }
}
