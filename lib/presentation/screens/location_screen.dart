import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock/mock_data.dart';
import '../providers/booking_provider.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_text_field.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _addressController = TextEditingController();
  final _buildingController = TextEditingController(text: 'عمارة 14 - الدور الرابع - شقة 12');
  final _landmarkController = TextEditingController(text: 'بجوار صيدلية العزبي، ميدان الإسماعيلية');
  bool _useCurrentLocation = true;

  @override
  void initState() {
    super.initState();
    _addressController.text = MockData.currentPatient.address;
  }

  @override
  void dispose() {
    _addressController.dispose();
    _buildingController.dispose();
    _landmarkController.dispose();
    super.dispose();
  }

  void _confirmLocation() {
    final fullAddress = '${_addressController.text} (${_buildingController.text}) - علامة مميزة: ${_landmarkController.text}';
    context.read<BookingProvider>().setLocation(fullAddress);
    Navigator.pushNamed(context, AppRoutes.nurseRecommendation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('موقع وصول الممرض'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // حاوية محاكاة الخريطة GPS المتقنة
              Container(
                height: 190,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.warmBeige, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // تمثيل خريطة بالخطوط الهادئة
                    Opacity(
                      opacity: 0.25,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.dustyRose, width: 0.5),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.dustyRose,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.dustyRose.withOpacity(0.4),
                                blurRadius: 15,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.location_on, color: Colors.white, size: 28),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6),
                            ],
                          ),
                          child: const Text(
                            'موقعك الحالي التقريبي: مصر الجديدة، القاهرة',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.warmDarkGray,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // خيارات الموقع المحفوظ
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.warmBeige),
                ),
                child: Row(
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: _useCurrentLocation,
                      activeColor: AppColors.dustyRose,
                      onChanged: (val) => setState(() => _useCurrentLocation = val ?? true),
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'العنوان المنزلي المحفوظ (الافتراضي)',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.warmDarkGray,
                            ),
                          ),
                          Text(
                            'شارع النزهة، مصر الجديدة، القاهرة',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.home_outlined, color: AppColors.dustyRose),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                'تفاصيل العنوان الدقيق لوصول الممرض',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.warmDarkGray,
                ),
              ),
              const SizedBox(height: 14),

              CustomTextField(
                label: 'الشارع والمنطقة',
                hint: 'اسم الشارع والحي',
                controller: _addressController,
                prefixIcon: Icons.map_outlined,
                isRequired: true,
              ),
              const SizedBox(height: 12),

              CustomTextField(
                label: 'رقم العمارة، الطابق، ورقم الشقة',
                hint: 'مثال: عمارة 14 - الدور 4 - شقة 12',
                controller: _buildingController,
                prefixIcon: Icons.apartment_outlined,
                isRequired: true,
              ),
              const SizedBox(height: 12),

              CustomTextField(
                label: 'علامة مميزة أو إرشادات للوصول',
                hint: 'مثال: بجوار صيدلية العزبي، يوجد مصعد',
                controller: _landmarkController,
                prefixIcon: Icons.directions_outlined,
              ),

              const SizedBox(height: 32),
              PrimaryButton(
                text: 'تأكيد الموقع واختيار الممرض',
                icon: Icons.check,
                onPressed: _confirmLocation,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
