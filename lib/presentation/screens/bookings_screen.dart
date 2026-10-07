import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../data/models/booking_model.dart';
import '../providers/booking_provider.dart';
import '../widgets/booking_card.dart';
import '../widgets/empty_state.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('حجوزاتي والزيارات التمريضية'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.dustyRose,
          indicatorWeight: 3,
          labelColor: AppColors.dustyRoseDark,
          unselectedLabelColor: AppColors.softMauve,
          labelStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w700, fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 14),
          tabs: const [
            Tab(text: 'الحالية والقادمة'),
            Tab(text: 'المكتملة'),
            Tab(text: 'الملغية'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // الحجوزات القادمة
          _buildBookingList(
            bookings: bookingProvider.upcomingBookings,
            emptyTitle: 'لا توجد حجوزات نشطة حاليًا',
            emptyDesc: 'يمكنك طلب زيارة تمريضية جديدة وسنصلك بأقرب ممرض معتمد.',
            showOrderButton: true,
          ),
          // الحجوزات المكتملة
          _buildBookingList(
            bookings: bookingProvider.completedBookings,
            emptyTitle: 'لا توجد زيارات مكتملة بعد',
            emptyDesc: 'عند انتهاء أي زيارة تمريضية ستجد تقرير التسليم Care Handover هنا.',
            showOrderButton: false,
          ),
          // الحجوزات الملغية
          _buildBookingList(
            bookings: bookingProvider.cancelledBookings,
            emptyTitle: 'لا توجد حجوزات ملغية',
            emptyDesc: 'سجل الحجوزات الملغية فارغ تمامًا.',
            showOrderButton: false,
          ),
        ],
      ),
    );
  }

  Widget _buildBookingList({
    required List<BookingModel> bookings,
    required String emptyTitle,
    required String emptyDesc,
    required bool showOrderButton,
  }) {
    if (bookings.isEmpty) {
      return EmptyState(
        title: emptyTitle,
        description: emptyDesc,
        icon: Icons.calendar_today_outlined,
        buttonText: showOrderButton ? 'اطلب رعاية الآن' : null,
        onButtonPressed: showOrderButton ? () => Navigator.pushNamed(context, AppRoutes.services) : null,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      itemCount: bookings.length,
      separatorBuilder: (context, index) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return BookingCard(
          booking: booking,
          onTap: () {
            // حفظ الحجز المحدد والانتقال
            Navigator.pushNamed(context, AppRoutes.bookingDetails);
          },
        );
      },
    );
  }
}
