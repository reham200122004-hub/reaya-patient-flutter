import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock/mock_data.dart';
import '../providers/booking_provider.dart';
import '../widgets/primary_button.dart';
import '../widgets/match_score_badge.dart';

class NurseDetailsScreen extends StatelessWidget {
  const NurseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final nurse = bookingProvider.selectedNurse ?? MockData.nurses[0];

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('الملف المهني للممرض'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // بطاقة التعريف الأساسية
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.warmBeige),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: 86,
                                  height: 86,
                                  color: AppColors.warmBeige,
                                  child: Image.network(
                                    nurse.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: AppColors.dustyRoseLight,
                                      child: const Icon(Icons.person, color: Colors.white, size: 40),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      nurse.name,
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.warmDarkGray,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      nurse.title,
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        MatchScoreBadge(score: nurse.matchScore),
                                        const Spacer(),
                                        const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                                        const SizedBox(width: 2),
                                        Text(
                                          '${nurse.rating}',
                                          style: const TextStyle(
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          ' (${nurse.reviewsCount})',
                                          style: const TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 11,
                                            color: AppColors.textMuted,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(height: 1, color: AppColors.warmBeige),
                          const SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _infoBlock('الخبرة العملية', nurse.experience),
                              _infoBlock('المسافة والوصول', nurse.distance),
                              _infoBlock('التكلفة التقريبية', '${nurse.pricePerHour.toInt()} ج.م / ساعة'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // نبذة عن الممرض
                    const Text(
                      'نبذة مهنية ومعلومات الاعتماد',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.warmDarkGray,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.warmBeige),
                      ),
                      child: Text(
                        nurse.about,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // الخدمات المقدمة
                    const Text(
                      'الخدمات التمريضية المعتمدة',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.warmDarkGray,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: nurse.providedServices.map((srv) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.cream,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.warmBeige),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.check_circle_outline, color: AppColors.dustyRose, size: 16),
                              const SizedBox(width: 6),
                              Text(
                                srv,
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.warmDarkGray,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // آراء وتقييمات المرضى
                    const Text(
                      'تجارب وآراء المرضى السابقين',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.warmDarkGray,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: nurse.reviews.map((rev) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceWhite,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.warmBeige),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.format_quote_rounded, color: AppColors.dustyRoseLight, size: 24),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  rev,
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 13,
                                    color: AppColors.warmDarkGray,
                                    height: 1.45,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // زر الحجز السفلي
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.warmBeige)),
              ),
              child: PrimaryButton(
                text: 'اختيار الممرض وتأكيد الموعد',
                icon: Icons.check_circle_outline,
                onPressed: () {
                  bookingProvider.selectNurse(nurse);
                  Navigator.pushNamed(context, AppRoutes.confirmBooking);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBlock(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: AppColors.warmDarkGray,
          ),
        ),
      ],
    );
  }
}
