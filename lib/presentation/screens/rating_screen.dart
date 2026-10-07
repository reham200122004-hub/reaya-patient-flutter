import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock/mock_data.dart';
import '../providers/booking_provider.dart';
import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';
import '../widgets/custom_text_field.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _selectedRating = 5;
  final _commentController = TextEditingController();
  final List<String> _selectedTags = [];
  bool _isSubmitted = false;

  final List<String> _tags = [
    'دقة بالمواعيد',
    'نظافة وتعقيم عالي',
    'تعامل إنساني راقٍ',
    'خفة يد وبدون ألم',
    'خبرة واحترافية',
    'طمأنينة وهدوء',
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submit() {
    final bookingProvider = context.read<BookingProvider>();
    bookingProvider.submitRating(
      bookingId: 'bkg_101',
      nurseId: 'nurse_1',
      rating: _selectedRating,
      feedback: _commentController.text.trim(),
      tags: _selectedTags,
    );

    setState(() => _isSubmitted = true);
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final nurse = bookingProvider.selectedNurse ?? MockData.nurses[0];

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('تقييم تجربة الرعاية'),
      ),
      body: SafeArea(
        child: _isSubmitted
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: const BoxDecoration(
                          color: AppColors.mutedGreenLight,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.star_rounded, color: AppColors.mutedGreen, size: 56),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'شكرًا لك على تقييمك القيم!',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.warmDarkGray,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'ملاحظاتك تساعدنا على الحفاظ على أعلى معايير الأمان والرعاية الطبية والإنسانية لأحبائنا.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      PrimaryButton(
                        text: 'العودة للصفحة الرئيسية',
                        icon: Icons.home_rounded,
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false),
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    // صورة واسم الممرض
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: AppColors.warmBeige),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 76,
                              height: 76,
                              color: AppColors.warmBeige,
                              child: Image.network(
                                nurse.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: AppColors.dustyRoseLight,
                                  child: const Icon(Icons.person, color: Colors.white, size: 38),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            nurse.name,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.warmDarkGray,
                            ),
                          ),
                          Text(
                            nurse.specialty,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'كيف تقيم مستوى الخدمة والاهتمام الإنساني؟',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.warmDarkGray,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // النجوم
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              final starIndex = index + 1;
                              return IconButton(
                                iconSize: 38,
                                icon: Icon(
                                  starIndex <= _selectedRating ? Icons.star_rounded : Icons.star_outline_rounded,
                                  color: starIndex <= _selectedRating ? Colors.amber : AppColors.warmBeige,
                                ),
                                onPressed: () => setState(() => _selectedRating = starIndex),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // وسوم التقييم
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
                            'ما أبرز ما ميز الزيارة؟',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.warmDarkGray,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _tags.map((tag) {
                              final isSelected = _selectedTags.contains(tag);
                              return FilterChip(
                                label: Text(tag),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      _selectedTags.add(tag);
                                    } else {
                                      _selectedTags.remove(tag);
                                    }
                                  });
                                },
                                selectedColor: AppColors.blushPink,
                                checkmarkColor: AppColors.dustyRose,
                                labelStyle: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                  color: isSelected ? AppColors.dustyRoseDark : AppColors.warmDarkGray,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: isSelected ? AppColors.dustyRose : AppColors.warmBeige,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'كلماتك أو نصائحك للممرض وإدارة رِعاية',
                            hint: 'اكتب انطباعك أو أي اقتراح لتطوير الخدمة...',
                            controller: _commentController,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    PrimaryButton(
                      text: 'إرسال التقييم',
                      icon: Icons.send_rounded,
                      onPressed: _submit,
                    ),
                    const SizedBox(height: 12),
                    SecondaryButton(
                      text: 'تخطي التقييم الآن',
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
      ),
    );
  }
}
