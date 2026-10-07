import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock/mock_data.dart';
import '../providers/booking_provider.dart';
import '../widgets/primary_button.dart';

class ConfirmBookingScreen extends StatefulWidget {
  const ConfirmBookingScreen({super.key});

  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedSlot = '06:30 مساءً';
  final _additionalNotesController = TextEditingController(text: 'يرجى الحضور في الموعد، المصعد يعمل بالعمارة.');

  final List<String> _availableSlots = [
    '02:00 ظهراً',
    '04:30 عصراً',
    '06:30 مساءً',
    '08:00 مساءً',
  ];

  @override
  void dispose() {
    _additionalNotesController.dispose();
    super.dispose();
  }

  void _onConfirm() async {
    final bookingProvider = context.read<BookingProvider>();
    bookingProvider.setSchedule(_selectedDate, _selectedSlot);
    bookingProvider.setAdditionalNotes(_additionalNotesController.text.trim());

    final booking = await bookingProvider.confirmCurrentBooking();
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.bookingSuccess);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final nurse = bookingProvider.selectedNurse ?? MockData.nurses[0];
    final service = bookingProvider.selectedService ?? MockData.services[0];
    final caseInfo = bookingProvider.currentCaseInfo;
    final location = bookingProvider.selectedLocation;

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('مراجعة وتأكيد الحجز'),
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
                    // ملخص الممرض والخدمة
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: AppColors.warmBeige),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  color: AppColors.warmBeige,
                                  child: Image.network(
                                    nurse.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: AppColors.dustyRoseLight,
                                      child: const Icon(Icons.person, color: Colors.white),
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
                                      nurse.name,
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.warmDarkGray,
                                      ),
                                    ),
                                    Text(
                                      nurse.title,
                                      style: const TextStyle(
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
                          const SizedBox(height: 14),
                          const Divider(height: 1, color: AppColors.warmBeige),
                          const SizedBox(height: 12),
                          _summaryRow('الخدمة المطلوبة:', service.title),
                          _summaryRow('المدة المقدرة:', service.duration),
                          _summaryRow('تكلفة الخدمة:', '${service.basePrice.toInt()} ج.م'),
                          _summaryRow('رسوم الانتقال المباشر:', '30 ج.م'),
                          const Divider(height: 1, color: AppColors.warmBeige),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'الإجمالي النهائي:',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.warmDarkGray,
                                ),
                              ),
                              Text(
                                '${service.basePrice.toInt() + 30} ج.م',
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.dustyRoseDark,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // الموعد والتوقيت
                    const Text(
                      'تحديد موعد الزيارة',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.warmDarkGray,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.warmBeige),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.access_time_rounded, color: AppColors.dustyRose, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'المواعيد المتاحة اليوم:',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.warmDarkGray,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _availableSlots.map((slot) {
                              final isSelected = _selectedSlot == slot;
                              return GestureDetector(
                                onTap: () => setState(() => _selectedSlot = slot),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.dustyRose : AppColors.cream,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected ? AppColors.dustyRose : AppColors.warmBeige,
                                    ),
                                  ),
                                  child: Text(
                                    slot,
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: isSelected ? Colors.white : AppColors.warmDarkGray,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // موقع الزيارة
                    const Text(
                      'موقع الزيارة',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.warmDarkGray,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.warmBeige),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on_outlined, color: AppColors.dustyRose, size: 22),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              location,
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 13,
                                color: AppColors.warmDarkGray,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ملخص الحالة
                    if (caseInfo != null) ...[
                      const Text(
                        'ملخص شكوى المريض',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.warmDarkGray,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceWhite,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.warmBeige),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              caseInfo.conditionDescription,
                              style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, color: AppColors.warmDarkGray),
                            ),
                            if (caseInfo.medicalNotes.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(
                                'ملاحظات: ${caseInfo.medicalNotes}',
                                style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, color: AppColors.textSecondary),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // زر التأكيد النهائي
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.warmBeige)),
              ),
              child: PrimaryButton(
                text: 'تأكيد الحجز النهائي',
                isLoading: bookingProvider.isLoading,
                icon: Icons.check_circle_rounded,
                onPressed: _onConfirm,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.warmDarkGray)),
        ],
      ),
    );
  }
}
