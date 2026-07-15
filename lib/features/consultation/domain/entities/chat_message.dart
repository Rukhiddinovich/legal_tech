import 'package:equatable/equatable.dart';

/// Chat xabari.
///
/// [isMine] true bo'lsa — mijoz (o'ng tomon, navy pufak),
/// aks holda advokat (chap tomon, oq pufak).
class ChatMessage extends Equatable {
  const ChatMessage({
    required this.id,
    required this.text,
    required this.isMine,
    required this.timeLabel,
  });

  final String id;
  final String text;
  final bool isMine;
  final String timeLabel;

  @override
  List<Object?> get props => [id];
}
