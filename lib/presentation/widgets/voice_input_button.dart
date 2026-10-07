import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class VoiceInputButton extends StatelessWidget {
  final bool isRecording;
  final VoidCallback onTap;
  final String label;

  const VoiceInputButton({
    super.key,
    required this.isRecording,
    required this.onTap,
    this.label = 'اضغط للتحدث ووصف الحالة',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isRecording ? AppColors.dustyRose.withOpacity(0.12) : AppColors.blushPink,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isRecording ? AppColors.dustyRose : AppColors.dustyRoseLight.withOpacity(0.4),
            width: isRecording ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isRecording ? AppColors.dustyRose : AppColors.surfaceWhite,
                shape: BoxShape.circle,
                boxShadow: [
                  if (isRecording)
                    BoxShadow(
                      color: AppColors.dustyRose.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                ],
              ),
              child: Icon(
                isRecording ? Icons.mic : Icons.mic_none_rounded,
                color: isRecording ? Colors.white : AppColors.dustyRose,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isRecording ? 'جاري الاستماع... تحدث الآن' : label,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isRecording ? AppColors.dustyRose : AppColors.warmDarkGray,
                    ),
                  ),
                  Text(
                    isRecording ? 'اضغط مرة أخرى للانتهاء وتحليل الحالة' : 'مدعوم بنظام REAYA Sense الصوتي',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String statusText;
  final Color backgroundColor;
  final Color textColor;

  const StatusBadge({
    super.key,
    required this.statusText,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}

class MatchScoreBadge extends StatelessWidget {
  final int score;

  const MatchScoreBadge({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.mutedGreenLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.mutedGreen.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome, size: 14, color: AppColors.mutedGreen),
          const SizedBox(width: 4),
          Text(
            '$score% توافق',
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppColors.mutedGreen,
            ),
          ),
        ],
      ),
    );
  }
}
