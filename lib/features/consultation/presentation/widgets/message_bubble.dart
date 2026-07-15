import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/global_text.dart';
import '../../domain/entities/chat_message.dart';

/// Chat pufakchasi (mijoz — o'ngda navy, advokat — chapda oq).
class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final mine = message.isMine;

    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
        decoration: BoxDecoration(
          color: mine ? AppColors.navy : AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(mine ? 16 : 4),
            bottomRight: Radius.circular(mine ? 4 : 16),
          ),
          boxShadow: mine
              ? null
              : [
                  BoxShadow(
                    color: AppColors.navy.withValues(alpha: 0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            GlobalText(
              text: message.text,
              fontSize: 13,
              color: mine ? AppColors.white : const Color(0xFF17212B),
              height: 1.5,
            ),
            const SizedBox(height: 4),
            GlobalText(
              text: message.timeLabel,
              fontSize: 10,
              color: mine
                  ? AppColors.white.withValues(alpha: 0.5)
                  : AppColors.textHint,
            ),
          ],
        ),
      ),
    );
  }
}
