import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _phoneController = TextEditingController();
  bool _isSent = false;
  bool _isLoading = false;

  void _resetPassword() async {
    if (_phoneController.text.isNotEmpty) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(milliseconds: 900));
      setState(() {
        _isLoading = false;
        _isSent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('استعادة الحساب'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: _isSent
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: AppColors.mutedGreenLight,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check_circle_outline, color: AppColors.mutedGreen, size: 54),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'تم إرسال رمز التحقق',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.warmDarkGray,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'أرسلنا رمز إعادة تعيين كلمة المرور إلى الرقم ${_phoneController.text}.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 30),
                      PrimaryButton(
                        text: 'العودة لتسجيل الدخول',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'نسيت كلمة المرور؟',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.warmDarkGray,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'أدخل رقم الهاتف المرتبط بحسابك وسنرسل لك رمزاً لتسجيل كلمة مرور جديدة.',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 28),
                    CustomTextField(
                      label: AppStrings.phone,
                      hint: '01xxxxxxxxx',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icons.phone_android_rounded,
                      isRequired: true,
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: 'إرسال رمز التأكيد',
                      isLoading: _isLoading,
                      onPressed: _resetPassword,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
