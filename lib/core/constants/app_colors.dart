import 'package:flutter/material.dart';

/// نظام الألوان الموحد لتطبيق رِعاية (REAYA)
/// مبني على نغمات دافئة ومهدئة: Dusty Rose, Blush Pink, Warm Beige, Muted Green
class AppColors {
  // الألوان الأساسية
  static const Color dustyRose = Color(0xFFB86B77); // اللون الأساسي الدافئ والراقي
  static const Color dustyRoseDark = Color(0xFF9E5460);
  static const Color dustyRoseLight = Color(0xFFD6949E);
  
  // ألوان التباين والنعومة
  static const Color blushPink = Color(0xFFF6E6E8); // خلفية كروت خفيفة ولمسات ناعمة
  static const Color softMauve = Color(0xFF8E6C75); // لون النصوص الثانوية والأيقونات
  
  // الخلفيات والسطوح
  static const Color warmBeige = Color(0xFFEFE6DE); // حواف وأزرار ثانوية
  static const Color cream = Color(0xFFF7F2EC); // خلفية الحاويات والبطاقات
  static const Color offWhite = Color(0xFFFBF8F5); // خلفية الشاشات الأساسية
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  
  // النصوص والتباين
  static const Color warmDarkGray = Color(0xFF2C2426); // نص رئيسي غني ومريح للعين
  static const Color textSecondary = Color(0xFF6F5E62);
  static const Color textMuted = Color(0xFF9E8E92);
  
  // الحالات والتنبيهات
  static const Color mutedGreen = Color(0xFF5B8E6A); // متاح / تم بنجاح
  static const Color mutedGreenLight = Color(0xFFEAF4EE);
  static const Color warmAmber = Color(0xFFC78B43); // قيد الانتظار / متوسط الأولوية
  static const Color warmAmberLight = Color(0xFFFCF4E9);
  static const Color softRed = Color(0xFFC25555); // ملغي / أولوية عاجلة
  static const Color softRedLight = Color(0xFFFCEAEA);

  // التدرجات
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFB86B77), Color(0xFFA65864)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warmCardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFFBF8F5)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
