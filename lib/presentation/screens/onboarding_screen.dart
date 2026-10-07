import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/routes/app_routes.dart';
import '../widgets/primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': AppStrings.onboardingTitle1,
      'desc': AppStrings.onboardingDesc1,
      'icon': Icons.medical_services_rounded,
    },
    {
      'title': AppStrings.onboardingTitle2,
      'desc': AppStrings.onboardingDesc2,
      'icon': Icons.mic_rounded,
    },
    {
      'title': AppStrings.onboardingTitle3,
      'desc': AppStrings.onboardingDesc3,
      'icon': Icons.assignment_turned_in_rounded,
    },
  ];

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // زر التخطي العلوي
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
                    child: const Text(
                      AppStrings.skip,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.softMauve,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    final item = _pages[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: AppColors.blushPink,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.warmBeige, width: 2),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            size: 64,
                            color: AppColors.dustyRose,
                          ),
                        ),
                        const SizedBox(height: 36),
                        Text(
                          item['title'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.warmDarkGray,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          item['desc'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 15,
                            color: AppColors.textSecondary,
                            height: 1.55,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              // مؤشرات الصفحات
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? AppColors.dustyRose : AppColors.warmBeige,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: _currentPage == _pages.length - 1 ? AppStrings.startNow : AppStrings.next,
                onPressed: _onNext,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
