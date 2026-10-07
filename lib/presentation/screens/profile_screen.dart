import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock/mock_data.dart';
import '../providers/auth_provider.dart';
import '../widgets/primary_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final patient = authProvider.currentPatient ?? MockData.currentPatient;

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // بطاقة بيانات المريض الرئيسية
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surfaceWhite,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.warmBeige),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(
                          color: AppColors.blushPink,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.dustyRose, width: 2),
                        ),
                        child: const Icon(Icons.person, size: 52, color: AppColors.dustyRose),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.dustyRose,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit, size: 14, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    patient.name,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.warmDarkGray,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    patient.phone,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: AppColors.warmBeige),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMiniBadge('العمر', '${patient.age} سنة'),
                      _buildMiniBadge('فصيلة الدم', patient.bloodType),
                      _buildMiniBadge('الجنس', patient.gender),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // الأمراض المزمنة
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
                  const Row(
                    children: [
                      Icon(Icons.medical_information_outlined, color: AppColors.dustyRose, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'الأمراض المزمنة المسجلة',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
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
                    children: patient.chronicDiseases.map((disease) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.blushPink,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          disease,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dustyRoseDark,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // العنوان المسجل
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surfaceWhite,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.warmBeige),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.cream,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.location_on_outlined, color: AppColors.dustyRose, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'العنوان المعتمد للزيارات',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.warmDarkGray,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          patient.address,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_location_alt_outlined, color: AppColors.dustyRose),
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.location),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // الإعدادات العامة
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceWhite,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.warmBeige),
              ),
              child: Column(
                children: [
                  _buildSettingTile(
                    icon: Icons.language_rounded,
                    title: 'لغة التطبيق',
                    subtitle: 'العربية (Arabic First)',
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: AppColors.warmBeige),
                  _buildSettingTile(
                    icon: Icons.notifications_none_rounded,
                    title: 'الإشعارات والتنبيهات',
                    subtitle: 'مفعلة للمواعيد والتحديثات',
                    onTap: () => Navigator.pushNamed(context, AppRoutes.notifications),
                  ),
                  const Divider(height: 1, color: AppColors.warmBeige),
                  _buildSettingTile(
                    icon: Icons.shield_outlined,
                    title: 'سياسة الخصوصية وحماية بيانات المرضى',
                    subtitle: 'تشفير تام للتقارير والبيانات',
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: AppColors.warmBeige),
                  _buildSettingTile(
                    icon: Icons.help_outline_rounded,
                    title: 'المساعدة والدعم التمريضي',
                    subtitle: 'تواصل مباشر مع فريق الرعاية',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // زر تسجيل الخروج
            OutlinedButton.icon(
              onPressed: () {
                authProvider.logout();
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
              },
              icon: const Icon(Icons.logout_rounded, color: AppColors.softRed, size: 20),
              label: const Text(
                'تسجيل الخروج',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.softRed,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.softRed, width: 1.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniBadge(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppColors.dustyRoseDark,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.dustyRose, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.warmDarkGray,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          color: AppColors.textSecondary,
        ),
      ),
      trailing: const Icon(Icons.arrow_back_ios_rounded, size: 14, color: AppColors.softMauve),
      onTap: onTap,
    );
  }
}
