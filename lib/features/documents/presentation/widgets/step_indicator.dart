import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/global_text.dart';
import '../bloc/document_generator_bloc.dart';

/// Hujjat generatoridagi 3 bosqichli qadam indikatori.
class StepIndicator extends StatelessWidget {
  const StepIndicator({super.key, required this.current});

  final DocumentStep current;

  int get _index => switch (current) {
        DocumentStep.type => 0,
        DocumentStep.data => 1,
        DocumentStep.done => 2,
      };

  @override
  Widget build(BuildContext context) {
    const labels = ['Turi', 'Ma\'lumotlar', 'Tayyor'];
    return Row(
      children: [
        for (int i = 0; i < labels.length; i++) ...[
          _StepDot(index: i, current: _index, label: labels[i]),
          if (i < labels.length - 1)
            Expanded(
              child: Container(
                height: 1.5,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                color: i < _index
                    ? AppColors.navy
                    : AppColors.navy.withValues(alpha: 0.15),
              ),
            ),
        ],
      ],
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({
    required this.index,
    required this.current,
    required this.label,
  });

  final int index;
  final int current;
  final String label;

  @override
  Widget build(BuildContext context) {
    final done = index < current;
    final active = index == current;

    final Color circleColor;
    final Color textColor;
    if (done) {
      circleColor = AppColors.online;
      textColor = AppColors.online;
    } else if (active) {
      circleColor = AppColors.navy;
      textColor = AppColors.navy;
    } else {
      circleColor = const Color(0xFFE4E0D7);
      textColor = AppColors.textHint;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
          child: done
              ? const Icon(Icons.check, size: 12, color: AppColors.white)
              : GlobalText(
                  text: '${index + 1}',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: active ? AppColors.white : AppColors.textHint,
                ),
        ),
        const SizedBox(width: 7),
        GlobalText(
          text: label,
          fontSize: 11,
          fontWeight: active || done ? FontWeight.w700 : FontWeight.w600,
          color: textColor,
        ),
      ],
    );
  }
}
