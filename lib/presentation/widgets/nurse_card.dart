import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/nurse_model.dart';
import 'match_score_badge.dart';

class NurseCard extends StatelessWidget {
  final NurseModel nurse;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onSelectPressed;

  const NurseCard({
    super.key,
    required this.nurse,
    this.isSelected = false,
    required this.onTap,
    this.onSelectPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blushPink.withOpacity(0.4) : AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.dustyRose : AppColors.warmBeige,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // صورة الممرض
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: 70,
                    height: 70,
                    color: AppColors.warmBeige,
                    child: Image.network(
                      nurse.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.dustyRoseLight,
                        child: const Icon(Icons.person, color: Colors.white, size: 36),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // تفاصيل الممرض
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              nurse.name,
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.warmDarkGray,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          MatchScoreBadge(score: nurse.matchScore),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        nurse.specialty,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 16, color: Colors.amber),
                          const SizedBox(width: 2),
                          Text(
                            nurse.rating.toString(),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.warmDarkGray,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${nurse.reviewsCount} تقييم)',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              color: AppColors.textMuted,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.location_on_outlined, size: 14, color: AppColors.softMauve),
                          const SizedBox(width: 2),
                          Text(
                            nurse.distance,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              color: AppColors.softMauve,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: AppColors.warmBeige),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: nurse.isAvailable ? AppColors.mutedGreenLight : AppColors.softRedLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: nurse.isAvailable ? AppColors.mutedGreen : AppColors.softRed,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        nurse.isAvailable ? 'متاح للزيارة اليوم' : 'غير متاح الآن',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: nurse.isAvailable ? AppColors.mutedGreen : AppColors.softRed,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  '${nurse.pricePerHour.toInt()} ج.م / ساعة',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.dustyRoseDark,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
