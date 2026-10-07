# 🌸 رِعاية — REAYA (Mobile Application)

> **"رِعاية مش مجرد خدمة، دي طمأنينة"**  
> مشروع تخرج متكامل لتطبيق رعاية وتمريض منزلي مخصص لخدمة المرضى، كبار السن، وذويهم بأعلى معايير الإنسانية والجودة الطبية.

---

## 📱 نظرة عامة على المشروع (Project Overview)

تطبيق **رِعاية (REAYA)** هو منصة متنقلة متكاملة بُنيت باستخدام **Flutter & Dart** توفر للمرضى وكبار السن إمكانية طلب خدمات تمريضية متخصصة وموثوقة مباشرة إلى منازلهم.
يتميز التطبيق بالهوية البصرية الدافئة والأنيقة، والتركيز الكامل على سهولة الاستخدام لكبار السن والعائلات، وتطبيق مفهوم **Arabic-First RTL**، بالإضافة إلى نظام **REAYA Sense** الذكي لفهم وتلخيص شكوى المريض صوتياً، ونظام **REAYA Care Handover** لتسليم الرعاية الطبية بدقة بعد كل زيارة.

---

## 🛠️ المواصفات التقنية (Technical Specifications)

- **Flutter SDK:** `>=3.19.0` (متوافق مع Flutter 3.x و Dart 3.x)
- **Dart Version:** `>=3.0.0 <4.0.0`
- **State Management:** Provider (`^6.1.2`) مع `ChangeNotifier`
- **Architecture Pattern:** Clean Architecture (Core / Data / Presentation)
- **Design System:** Custom Medical Warm Palette (Dusty Rose, Blush Pink, Warm Beige, Cream, Muted Green)
- **Localization:** اللغة العربية كلغة أولى (Arabic-First) بدعم RTL كامل وخط Cairo المعتمد.

---

## 🎨 الهوية البصرية ونظام الألوان (Design & Color Palette)

تم الابتعاد عن الأزرق التقليدي البارد واستبداله بألوان دافئة ومطمئنة:
- **Dusty Rose (`#B86B77`):** اللون الأساسي للأزرار والعناصر البارزة (يرمز للدفء والإنسانية).
- **Blush Pink (`#F6E6E8`):** خلفيات الكروت اللطيفة والوسوم التفاعلية.
- **Warm Beige (`#EFE6DE`):** الفواصل والحدود الهادئة.
- **Cream (`#F7F2EC`):** أسطح الإدخال والبطاقات الثانوية.
- **Off-white (`#FBF8F5`):** الخلفية العامة للتطبيق لمزيد من الراحة البصرية.
- **Warm Dark Gray (`#2C2426`):** النصوص الرئيسية عالية التباين والمريحة لكبار السن.
- **Muted Green (`#5B8E6A`):** للحالات الناجحة والممرضين المتاحين ومطابقة Match Score.

---

## 📱 الشاشات الـ 19 المنفذة بالكامل (19 Full Screens)

1. **شاشة البداية (Splash Screen):** شعار رِعاية المتحرك مع الشعار اللفظي.
2. **التعريف بالتطبيق (Onboarding Screen):** 3 مراحل تعريفية مع سلايدر تفاعلي وزر تخطي.
3. **تسجيل الدخول (Login Screen):** تسجيل الدخول برقم الهاتف وكلمة المرور مع التحقق من الحقول.
4. **إنشاء حساب جديد (Register Screen):** تسجيل مريض أو ولي أمر مع البيانات الأساسية والعمر.
5. **استعادة كلمة المرور (Forgot Password Screen):** إرسال رمز تحقق وتأكيد فوري.
6. **الرئيسية (Home Screen):** ترحيب شخصي، زر الحجز الرئيسي البارز، بطاقة REAYA Sense، الحجز القادم، الخدمات السريعة، وآخر الفحوصات.
7. **الملف الشخصي (Profile Screen):** السجل الصحي الأساسي، فصيلة الدم، الأمراض المزمنة، العنوان المعتمد، وإعدادات الحساب.
8. **الخدمات (Services Screen):** استعراض بطاقات الخدمات التمريضية بأسعارها وتفاصيلها.
9. **معلومات الحالة (Case Information Screen):** وصف الشكوى، الملاحظات، فحص الحقول الإلزامية، وتكامل REAYA Sense.
10. **الموقع (Location Screen):** محاكاة موقع GPS الحالي، العنوان المحفوظ، تفاصيل الطابق والشقة والعلامة المميزة.
11. **ترشيح الممرضين (Nurse Recommendation Screen):** بطاقات الممرضين المعتمدين مع نسبة التوافق الذكية (Match Score) والمسافة والتقييم.
12. **تفاصيل الممرض (Nurse Details Screen):** السيرة المهنية، الاعتماد، الخدمات المقدمة، تجارب المرضى، وأزرار الحجز.
13. **تأكيد الحجز (Confirm Booking Screen):** اختيار التوقيت، ملخص التكلفة والانتقالات، ومراجعة تفاصيل الحالة.
14. **نجاح الحجز (Booking Success Screen):** كود الحجز المرجعي، تفاصيل الممرض، وخيارات المتابعة.
15. **الحجوزات (Bookings Screen):** 3 تبويبات (الحالية/القادمة، المكتملة، الملغية) مع حالات Empty State.
16. **تفاصيل الحجز (Booking Details Screen):** تفاصيل الزيارة وبطاقة **REAYA Care Handover** المنظمة.
17. **السجل الطبي (Medical Record Screen):** أرشيف العلامات الحيوية (الضغط، السكر، النبض) وملاحظات الزيارات السابقة.
18. **الإشعارات (Notifications Screen):** إشعارات تأكيد المواعيد، وصول الممرض، وتقارير الزيارات مع تمييز المقروء.
19. **التقييم (Rating Screen):** تقييم تجربة الرعاية بالنجوم، وسوم الرضا، والتعليق النصي مع شاشة نجاح مخصصة.

---

## 🧠 مميزات فريدة (Key Highlights)

### 1. نظام REAYA Sense
- يتيح للمريض أو أسرته وصف المشكلة الصحية عبر واجهة إدخال صوتي (Voice Input UI) أو كتابة سريعة.
- يقوم النظام بمحاكاة التحليل الفوري للمفردات وتصنيف الحالة واقتراح الخدمة الأنسب والأولوية.
- يعرض بطاقة ملخص منظمة: `الحالة | الخدمة المقترحة | الأولوية | الملاحظات والتنبيهات` ويسأل: *"هل المعلومات دي صحيحة؟"* مع خيارات (تأكيد / تعديل / إعادة التسجيل).

### 2. تسليم الرعاية (REAYA Care Handover)
- بطاقة تسليم مهنية تضمن سلامة المريض بتدوين العلامات الحيوية، الإجراء التمريضي المنفذ، والأدوية المصرح بها والخطوات القادمة للمريض وأسرته.

---

## 🏗️ هيكلية المشروع (Clean Architecture)

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   └── app_text_styles.dart
│   ├── routes/
│   │   └── app_routes.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── utils/
│       └── date_formatter.dart
├── data/
│   ├── mock/
│   │   └── mock_data.dart
│   ├── models/
│   │   ├── booking_model.dart
│   │   ├── case_information_model.dart
│   │   ├── medical_record_model.dart
│   │   ├── nurse_model.dart
│   │   ├── patient_model.dart
│   │   └── service_model.dart
│   └── repositories/
│       └── reaya_repository.dart
├── presentation/
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   ├── booking_provider.dart
│   │   └── reaya_sense_provider.dart
│   ├── screens/
│   │   ├── booking_details_screen.dart
│   │   ├── booking_success_screen.dart
│   │   ├── bookings_screen.dart
│   │   ├── case_information_screen.dart
│   │   ├── confirm_booking_screen.dart
│   │   ├── forgot_password_screen.dart
│   │   ├── home_screen.dart
│   │   ├── location_screen.dart
│   │   ├── login_screen.dart
│   │   ├── medical_record_screen.dart
│   │   ├── notifications_screen.dart
│   │   ├── nurse_details_screen.dart
│   │   ├── nurse_recommendation_screen.dart
│   │   ├── onboarding_screen.dart
│   │   ├── profile_screen.dart
│   │   ├── rating_screen.dart
│   │   ├── register_screen.dart
│   │   ├── services_screen.dart
│   │   └── splash_screen.dart
│   └── widgets/
│       ├── booking_card.dart
│       ├── care_handover_card.dart
│       ├── custom_text_field.dart
│       ├── empty_state.dart
│       ├── match_score_badge.dart
│       ├── nurse_card.dart
│       ├── primary_button.dart
│       ├── secondary_button.dart
│       ├── section_title.dart
│       ├── service_card.dart
│       ├── status_badge.dart
│       ├── summary_card.dart
│       └── voice_input_button.dart
└── main.dart
```

---

## 🔌 الجاهزية للربط المستقبلي (Backend & AI Ready)

### جاهزية الـ Backend (Backend Ready):
- تم عزل مصادر البيانات عبر طبقة `ReayaRepository` ونماذج بيانات `Models` تدعم `toJson()` و `fromJson()`.
- تم تجهيز نقاط الربط لـ:
  - Authentication (Firebase Auth / REST API)
  - Booking & Order Lifecycle
  - GPS Realtime Tracking
  - Push Notifications (FCM)
  - Medical Records EHR Integration

### جاهزية الذكاء الاصطناعي (AI Ready):
- معمارية `ReayaSenseProvider` مفصولة تمامًا بحيث يمكن استبدال معالجة الـ Mock الحالية بنداء مباشر لـ Gemini API أو Whisper Speech-to-Text لتحويل الصوت إلى نصوص وهيكلة بيانات الحالة بدقة فائقة.

---

## 🚀 تعليمات التشغيل (How to Run)

1. **تأكد من تثبيت بيئة Flutter:**
   ```bash
   flutter doctor
   ```

2. **تحميل الحزم والاعتماديات:**
   ```bash
   flutter pub get
   ```

3. **تشغيل التطبيق على الهاتف أو المحاكي:**
   ```bash
   flutter run
   ```

4. **بناء نسخة Release للـ Android (APK):**
   ```bash
   flutter build apk --release
   ```

---

## 📄 الترخيص
تم تطوير هذا التطبيق كنموذج عملي لمشروع تخرج متكامل لتطبيق رعاية وتمريض منزلي. جميع الحقوق محفوظة لفريق رِعاية © 2026.
---
# 🏥 REAYA | تطبيق رِعاية

تطبيق طيبي متكامل مخصص لإدارة الرعاية الصحية، مبني باستخدام **Flutter & Dart**، بدعم كامل للغة العربية (**Arabic-First RTL**) مع تطبيق أفضل الممارسات الهندسية (**Clean Architecture**).

---

## 🌐 النسخة التجريبية الحية | Live Interactive Preview

يمكنك تجربة تطبيق **رِعاية** مباشرة عبر المتصفح بالضغط على الزر أدناه:

[![Live Demo](https://img.shields.io/badge/Demo-Live_Preview-2ea44f?style=for-the-badge&logo=flutter&logoColor=white)](https://reham-ramadan.github.io/REAYA/)

👉 **الرابط المباشر:** [https://reham-ramadan.github.io/REAYA/](https://reham-ramadan.github.io/REAYA/)

---

## 🛠️ التقنيات المستخدمة | Tech Stack

- **Framework:** Flutter (Web & Mobile)
- **Language:** Dart
- **Architecture:** Clean Architecture
- **UI/UX:** Arabic RTL Design Pattern
-
