import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/routes/app_routes.dart';
import '../providers/auth_provider.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ageController = TextEditingController(text: '65');
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final authProvider = context.read<AuthProvider>();
      final success = await authProvider.register(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        age: int.tryParse(_ageController.text.trim()) ?? 60,
      );

      if (success && mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('حساب جديد'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'انضم لعائلة رِعاية',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.warmDarkGray,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'بيانات المريض أو ولي أمره لتسهيل المتابعة الطبية',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: AppStrings.fullName,
                  hint: 'مثال: محمد أحمد علي',
                  controller: _nameController,
                  prefixIcon: Icons.person_outline_rounded,
                  isRequired: true,
                  validator: (v) => (v == null || v.isEmpty) ? 'يرجى إدخال الاسم' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: AppStrings.phone,
                  hint: '01xxxxxxxxx',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_android_rounded,
                  isRequired: true,
                  validator: (v) => (v == null || v.isEmpty) ? 'يرجى إدخال الهاتف' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: AppStrings.email,
                  hint: 'name@example.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  isRequired: false,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'العمر التقريبي للمريض',
                  hint: 'مثال: 68',
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.calendar_month_outlined,
                  isRequired: true,
                  validator: (v) => (v == null || v.isEmpty) ? 'يرجى إدخال العمر' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: AppStrings.password,
                  hint: 'كلمة مرور قوية لا تقل عن 6 أحرف',
                  controller: _passwordController,
                  obscureText: true,
                  prefixIcon: Icons.lock_outline_rounded,
                  isRequired: true,
                  validator: (v) => (v == null || v.length < 6) ? 'كلمة المرور قصيرة' : null,
                ),
                const SizedBox(height: 28),
                PrimaryButton(
                  text: AppStrings.register,
                  isLoading: authProvider.isLoading,
                  onPressed: _submit,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('لديك حساب بالفعل؟', style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: AppColors.textSecondary)),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
                      child: const Text('سجل دخولك', style: TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.dustyRose)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
