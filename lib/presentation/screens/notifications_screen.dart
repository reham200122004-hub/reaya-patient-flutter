import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../data/models/medical_record_model.dart';
import '../providers/booking_provider.dart';
import '../widgets/empty_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.bookingConfirmed:
        return Icons.check_circle_outline;
      case NotificationType.nurseAssigned:
        return Icons.person_pin_circle_outlined;
      case NotificationType.reminder:
        return Icons.alarm_rounded;
      case NotificationType.serviceCompleted:
        return Icons.assignment_turned_in_outlined;
      case NotificationType.rateRequest:
        return Icons.star_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final notifications = bookingProvider.notifications;

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('الإشعارات والتنبيهات'),
        actions: [
          if (notifications.isNotEmpty)
            TextButton(
              onPressed: () => bookingProvider.markAllNotificationsAsRead(),
              child: const Text(
                'تحديد الكل كمقروء',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: AppColors.dustyRose),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: notifications.isEmpty
            ? const EmptyState(
                title: 'لا توجد إشعارات جديدة',
                description: 'ستصلك هنا إشعارات فورية عند تأكيد أي حجز أو اقتراب موعد الزيارة.',
                icon: Icons.notifications_none_rounded,
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                itemCount: notifications.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final notif = notifications[index];
                  return InkWell(
                    onTap: () {
                      bookingProvider.markNotificationAsRead(notif.id);
                      if (notif.type == NotificationType.rateRequest) {
                        Navigator.pushNamed(context, AppRoutes.rating);
                      } else {
                        Navigator.pushNamed(context, AppRoutes.bookingDetails);
                      }
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: notif.isRead ? AppColors.surfaceWhite : AppColors.blushPink.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: notif.isRead ? AppColors.warmBeige : AppColors.dustyRoseLight,
                          width: notif.isRead ? 1 : 1.5,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: notif.isRead ? AppColors.cream : AppColors.dustyRose,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _getNotificationIcon(notif.type),
                              color: notif.isRead ? AppColors.softMauve : Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        notif.title,
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 14,
                                          fontWeight: notif.isRead ? FontWeight.w600 : FontWeight.w800,
                                          color: AppColors.warmDarkGray,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      notif.timestamp,
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 11,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  notif.body,
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!notif.isRead) ...[
                            const SizedBox(width: 8),
                            const CircleAvatar(radius: 4, backgroundColor: AppColors.dustyRose),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
