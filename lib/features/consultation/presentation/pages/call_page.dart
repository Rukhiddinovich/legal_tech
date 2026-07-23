import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../lawyers/domain/entities/lawyer.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key, required this.lawyer, required this.isVideo});

  final Lawyer lawyer;
  final bool isVideo;

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  int _seconds = 0;
  Timer? _timer;
  bool _isMuted = false;
  bool _isVideoOff = false;
  bool _isSpeakerOn = true;

  @override
  void initState() {
    super.initState();
    _isVideoOff = !widget.isVideo;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime() {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background - Video simulation or Avatar
          if (!_isVideoOff)
            Opacity(
              opacity: 0.6,
              child: Image.network(
                'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=500&auto=format&fit=crop',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Center(
                  child: Icon(CupertinoIcons.person_fill, size: 100, color: Colors.grey),
                ),
              ),
            )
          else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.gold.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.gold, width: 2),
                    ),
                    alignment: Alignment.center,
                    child: GlobalText(
                      text: widget.lawyer.fullName.substring(0, 1),
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: AppColors.gold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  GlobalText(
                    text: widget.lawyer.fullName,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                  const SizedBox(height: 8),
                  GlobalText(
                    text: 'Ovozli qo\'ng\'iroq...',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),

          // Small Overlay Preview for Client Video if Video call is Active
          if (!_isVideoOff && widget.isVideo)
            Positioned(
              top: 50,
              right: 20,
              child: Container(
                width: 90,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.white, width: 1.5),
                  color: Colors.grey[900],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300&auto=format&fit=crop',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      CupertinoIcons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

          // Caller name & duration on top left for video call
          if (!_isVideoOff)
            Positioned(
              top: 60,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalText(
                    text: widget.lawyer.fullName,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.online,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      GlobalText(
                        text: _formatTime(),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Duration for voice call
          if (_isVideoOff)
            Positioned(
              top: 250,
              left: 0,
              right: 0,
              child: Center(
                child: GlobalText(
                  text: _formatTime(),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ),

          // Bottom Control Panel
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ControlButton(
                      icon: _isMuted ? CupertinoIcons.mic_slash_fill : CupertinoIcons.mic_fill,
                      active: _isMuted,
                      onTap: () {
                        setState(() {
                          _isMuted = !_isMuted;
                        });
                      },
                    ),
                    if (widget.isVideo)
                      _ControlButton(
                        icon: _isVideoOff ? CupertinoIcons.video_camera_solid : CupertinoIcons.video_camera,
                        active: _isVideoOff,
                        onTap: () {
                          setState(() {
                            _isVideoOff = !_isVideoOff;
                          });
                        },
                      ),
                    _ControlButton(
                      icon: _isSpeakerOn ? CupertinoIcons.volume_up : CupertinoIcons.volume_off,
                      active: _isSpeakerOn,
                      onTap: () {
                        setState(() {
                          _isSpeakerOn = !_isSpeakerOn;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: AppColors.danger,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(CupertinoIcons.phone_down_fill, color: Colors.white, size: 28),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: active ? AppColors.white : AppColors.white.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: active ? Colors.black : Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
