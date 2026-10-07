import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock/mock_data.dart';
import '../providers/booking_provider.dart';
import '../widgets/service_card.dart';
import '../widgets/primary_button.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final selectedService = bookingProvider.selectedService;

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('خدمات الرعاية التمريضية'),
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
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.blushPink.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.dustyRoseLight.withOpacity(0.3)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline_rounded, color: AppColors.dustyRose, size: 22),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'اختر الخدمة التمريضية المناسبة، وسنقوم بتوصيلك بأكفأ ممرض معتمد بالقرب منك.',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 13,
                                color: AppColors.warmDarkGray,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: MockData.services.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final service = MockData.services[index];
                        final isSelected = selectedService?.id == service.id;
                        return ServiceCard(
                          service: service,
                          isSelected: isSelected,
                          onTap: () {
                            bookingProvider.selectService(service);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            // شريط التأكيد السفلي
            if (selectedService != null)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: AppColors.warmBeige)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            selectedService.title,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.warmDarkGray,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'السعر المبدئي: ${selectedService.basePrice.toInt()} ج.م',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 13,
                              color: AppColors.dustyRoseDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 160,
                      child: PrimaryButton(
                        text: 'متابعة الحجز',
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.caseInformation);
                        },
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
