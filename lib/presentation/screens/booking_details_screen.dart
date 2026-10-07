import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../data/models/booking_model.dart';
import '../../data/mock/mock_data.dart';
import '../providers/booking_provider.dart';
import '../widgets/status_badge.dart';
import '../widgets/care_handover_card.dart';
import '../widgets/primary_button.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final booking = bookingProvider.lastCreatedBooking ?? MockData.initialBookings.first;

    final handover = booking.handoverSummary ?? const CareHandoverSummary(
      patientCondition: 'مستقرة، الجرح نظيف ويحتاج غيار دوري مع متابعة قراءات السكر.',
      serviceDetails: 'تغيير الغيار الجراحي، تعقيم ببيتادين، وشاش فازلين معقم.',
      nurseObservations: 'لا يوجد ارتشاح أو التهاب، تم قياس الضغط 125/80 والنبض 74.',
      medicationsAdministered: 'تم التأكد من تناول جرعة السيولة بعد وجبة خفيفة.',
      nextSteps: 'إعادة الغيار بعد يومين وتجنب وصول الماء مباشرة للمنطقة.',
      handoverTime: 'الموعد المحدد اليوم',
    );

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: Text('تفاصيل الحجز (${booking.bookingReference})'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.dustyRose),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم نسخ تفاصيل الحجز للمشاركة', style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: AppColors.dustyRose,
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // بطاقة الحالة ورقم الحجز
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.warmBeige),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'كود الحجز: ${booking.bookingReference}',
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.warmDarkGray,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'تاريخ الإنشاء: ${booking.scheduledTimeSlot}',
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    StatusBadge(
                      statusText: booking.statusArabic,
                      backgroundColor: AppColors.mutedGreenLight,
                      textColor: AppColors.mutedGreen,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // بطاقة الممرض
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.warmBeige),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 64,
                        height: 64,
                        color: AppColors.warmBeige,
                        child: Image.network(
                          booking.nurse.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.dustyRoseLight,
                            child: const Icon(Icons.person, color: Colors.white, size: 32),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking.nurse.name,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.warmDarkGray,
                            ),
                          ),
                          Text(
                            booking.nurse.specialty,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                '${booking.nurse.rating}',
                                style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              const Spacer(),
                              Text(
                                booking.nurse.distance,
                                style: const TextStyle(fontFamily: 'Cairo', fontSize: 11, color: AppColors.softMauve),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // تفاصيل الخدمة والموقع
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.warmBeige),
                ),
                child: Column(
                  children: [
                    _row(Icons.medical_services_outlined, 'الخدمة:', booking.service.title),
                    const Divider(height: 16, color: AppColors.warmBeige),
                    _row(Icons.access_time_rounded, 'الموعد:', booking.scheduledTimeSlot),
                    const Divider(height: 16, color: AppColors.warmBeige),
                    _row(Icons.location_on_outlined, 'الموقع:', booking.locationAddress),
                    const Divider(height: 16, color: AppColors.warmBeige),
                    _row(Icons.payments_outlined, 'الإجمالي المدفوع:', '${booking.totalPrice.toInt()} ج.م (عند الزيارة)'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ملخص الحالة
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.warmBeige),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'بيانات شكوى الحالة المسجلة',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.warmDarkGray,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      booking.caseInfo.conditionDescription,
                      style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, color: AppColors.warmDarkGray, height: 1.4),
                    ),
                    if (booking.caseInfo.medicalNotes.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        'ملاحظات إضافية: ${booking.caseInfo.medicalNotes}',
                        style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // بطاقة REAYA Care Handover المعتمدة
              CareHandoverCard(handover: handover),

              const SizedBox(height: 24),

              // زر تقييم الزيارة
              PrimaryButton(
                text: 'تقييم تجربة الرعاية والممرض',
                icon: Icons.star_outline_rounded,
                onPressed: () => Navigator.pushNamed(context, AppRoutes.rating),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.dustyRose, size: 20),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.warmDarkGray),
          ),
        ),
      ],
    );
  }
}
