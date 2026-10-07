import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock/mock_data.dart';
import '../providers/booking_provider.dart';
import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final booking = bookingProvider.lastCreatedBooking ?? MockData.initialBookings.first;

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // أيقونة النجاح الكبيرة بألوان رِعاية الدافئة
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.mutedGreenLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.mutedGreen.withOpacity(0.3), width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mutedGreen.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.check_circle_rounded, color: AppColors.mutedGreen, size: 56),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'تم تأكيد حجزك بنجاح!',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.warmDarkGray,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'تم إرسال إشعار للممرض وسيتوجه إليك في الموعد المحدد بكل عناية واحترافية.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),

              // بطاقة تفاصيل الحجز
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.warmBeige),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('رقم الحجز المرجعي:', style: TextStyle(fontFamily: 'Cairo', fontSize: 13, color: AppColors.textSecondary)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.cream,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            booking.bookingReference,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: AppColors.dustyRose,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1, color: AppColors.warmBeige),
                    const SizedBox(height: 12),
                    _detailRow('الممرض المعتمد:', booking.nurse.name),
                    _detailRow('الخدمة المطلوبة:', booking.service.title),
                    _detailRow('موعد الزيارة:', booking.scheduledTimeSlot),
                    _detailRow('العنوان:', booking.locationAddress, isMultiLine: true),
                    _detailRow('الإجمالي:', '${booking.totalPrice.toInt()} ج.م'),
                  ],
                ),
              ),

              const Spacer(),

              PrimaryButton(
                text: 'عرض تفاصيل الحجز',
                icon: Icons.receipt_long_rounded,
                onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.bookingDetails),
              ),
              const SizedBox(height: 12),
              SecondaryButton(
                text: 'العودة إلى الصفحة الرئيسية',
                icon: Icons.home_rounded,
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value, {bool isMultiLine = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: isMultiLine ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.warmDarkGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
