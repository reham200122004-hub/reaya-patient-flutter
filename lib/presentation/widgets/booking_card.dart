import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/booking_model.dart';
import 'status_badge.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback onTap;

  const BookingCard({
    super.key,
    required this.booking,
    required this.onTap,
  });

  Color _getStatusBg() {
    switch (booking.status) {
      case BookingStatus.confirmed:
      case BookingStatus.completed:
        return AppColors.mutedGreenLight;
      case BookingStatus.inProgress:
      case BookingStatus.pending:
        return AppColors.warmAmberLight;
      case BookingStatus.cancelled:
        return AppColors.softRedLight;
    }
  }

  Color _getStatusTextColor() {
    switch (booking.status) {
      case BookingStatus.confirmed:
      case BookingStatus.completed:
        return AppColors.mutedGreen;
      case BookingStatus.inProgress:
      case BookingStatus.pending:
        return AppColors.warmAmber;
      case BookingStatus.cancelled:
        return AppColors.softRed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.warmBeige),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        booking.bookingReference,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.dustyRose,
                        ),
                      ),
                    ),
                  ],
                ),
                StatusBadge(
                  statusText: booking.statusArabic,
                  backgroundColor: _getStatusBg(),
                  textColor: _getStatusTextColor(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              booking.service.title,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.warmDarkGray,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.person_pin, size: 16, color: AppColors.softMauve),
                const SizedBox(width: 6),
                Text(
                  booking.nurse.name,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 15, color: AppColors.softMauve),
                const SizedBox(width: 6),
                Text(
                  booking.scheduledTimeSlot,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    color: AppColors.softMauve,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: AppColors.warmBeige),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الإجمالي: ${booking.totalPrice.toInt()} ج.م',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.dustyRoseDark,
                  ),
                ),
                const Row(
                  children: [
                    Text(
                      'عرض التفاصيل',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dustyRose,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_back_ios_rounded, size: 12, color: AppColors.dustyRose),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
