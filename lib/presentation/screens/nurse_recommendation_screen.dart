import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock/mock_data.dart';
import '../providers/booking_provider.dart';
import '../widgets/nurse_card.dart';

class NurseRecommendationScreen extends StatelessWidget {
  const NurseRecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('الممرضون المقترحون'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // بنر التوافق الذكي
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.blushPink.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.dustyRoseLight.withOpacity(0.4)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.auto_awesome, color: AppColors.dustyRose, size: 24),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ترشيحات ذكية بناءً على تقييم الحالة والمسافة',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.dustyRoseDark,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'تم ترتيب الممرضين وفقاً لمعدل التوافق (Match Score) وخبراتهم الطبية.',
                            style: TextStyle(
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
              const SizedBox(height: 20),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: MockData.nurses.length,
                separatorBuilder: (context, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final nurse = MockData.nurses[index];
                  final isSelected = bookingProvider.selectedNurse?.id == nurse.id;
                  return NurseCard(
                    nurse: nurse,
                    isSelected: isSelected,
                    onTap: () {
                      bookingProvider.selectNurse(nurse);
                      Navigator.pushNamed(context, AppRoutes.nurseDetails);
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
