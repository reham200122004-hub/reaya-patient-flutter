import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock/mock_data.dart';
import '../providers/auth_provider.dart';
import '../providers/booking_provider.dart';
import '../widgets/section_title.dart';
import '../widgets/service_card.dart';
import '../widgets/booking_card.dart';
import '../widgets/primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final bookingProvider = context.watch<BookingProvider>();
    final patient = authProvider.currentPatient ?? MockData.currentPatient;
    final upcomingBookings = bookingProvider.upcomingBookings;
    final unreadCount = bookingProvider.unreadNotificationsCount;

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الهيدر الترحيبي
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.dustyRose,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.warmBeige, width: 2),
                          ),
                          child: const Center(
                            child: Icon(Icons.person, color: Colors.white, size: 26),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.welcomeBack,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            patient.name,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.warmDarkGray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications_none_rounded, color: AppColors.warmDarkGray, size: 28),
                            onPressed: () => Navigator.pushNamed(context, AppRoutes.notifications),
                          ),
                          if (unreadCount > 0)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppColors.dustyRose,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '$unreadCount',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // بنر الحجز الرئيسي (Main CTA Banner)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.dustyRose.withOpacity(0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'رعاية تمريضية منزلية متكاملة',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Icon(Icons.volunteer_activism_rounded, color: Colors.white, size: 28),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'أفضل تمريض منزلي لأهلك، أمان وثقة واطمئنان',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.caseInformation),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.dustyRoseDark,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppStrings.mainCta,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_back_ios_rounded, size: 14),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // بطاقة REAYA Sense المبتكرة
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppRoutes.caseInformation),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceWhite,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.dustyRoseLight.withOpacity(0.4), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.dustyRose.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.blushPink,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.mic_rounded, color: AppColors.dustyRose, size: 28),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'REAYA Sense',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.dustyRoseDark,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(Icons.auto_awesome, size: 14, color: AppColors.dustyRose),
                              ],
                            ),
                            SizedBox(height: 2),
                            Text(
                              'صف الحالة بصوتك وسنقترح الممرض الأنسب فوراً',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_back_ios_rounded, size: 16, color: AppColors.softMauve),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // الحجز الحالي أو القادم
              SectionTitle(
                title: AppStrings.upcomingBooking,
                trailing: TextButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.bookings),
                  child: const Text(
                    'جميع الحجوزات',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dustyRose,
                    ),
                  ),
                ),
              ),

              if (upcomingBookings.isNotEmpty)
                BookingCard(
                  booking: upcomingBookings.first,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.bookingDetails),
                )
              else
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceWhite,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.warmBeige),
                  ),
                  child: const Center(
                    child: Text(
                      AppStrings.noCurrentBookings,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              // الخدمات السريعة
              SectionTitle(
                title: AppStrings.quickServices,
                subtitle: 'اختر الخدمة المطلوبة لنبدأ التنسيق فورًا',
                trailing: TextButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.services),
                  child: const Text(
                    'عرض الكل',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dustyRose,
                    ),
                  ),
                ),
              ),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.88,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: 4, // عرض 4 خدمات سريعة
                itemBuilder: (context, index) {
                  final service = MockData.services[index];
                  return ServiceCard(
                    service: service,
                    isSelected: bookingProvider.selectedService?.id == service.id,
                    onTap: () {
                      bookingProvider.selectService(service);
                      Navigator.pushNamed(context, AppRoutes.caseInformation);
                    },
                  );
                },
              ),

              const SizedBox(height: 24),

              // آخر النشاطات (سجل المريض الطبي)
              SectionTitle(
                title: AppStrings.recentActivities,
                subtitle: 'السجل الصحي والزيارات السابقة',
                trailing: TextButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.medicalRecord),
                  child: const Text(
                    'السجل الكامل',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dustyRose,
                    ),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.warmBeige),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.history_rounded, color: AppColors.dustyRose, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          MockData.medicalRecords.first.serviceTitle,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.warmDarkGray,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          MockData.medicalRecords.first.date,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      MockData.medicalRecords.first.vitalSigns,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 0),
    );
  }

  Widget _buildBottomNav(BuildContext context, int currentIndex) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.warmBeige, width: 1)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 0) return;
          if (index == 1) Navigator.pushNamed(context, AppRoutes.services);
          if (index == 2) Navigator.pushNamed(context, AppRoutes.bookings);
          if (index == 3) Navigator.pushNamed(context, AppRoutes.medicalRecord);
          if (index == 4) Navigator.pushNamed(context, AppRoutes.profile);
        },
        selectedItemColor: AppColors.dustyRose,
        unselectedItemColor: AppColors.softMauve,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedLabelStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w700, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'الخدمات'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: 'الحجوزات'),
          BottomNavigationBarItem(icon: Icon(Icons.folder_shared_rounded), label: 'السجل'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'حسابي'),
        ],
      ),
    );
  }
}
