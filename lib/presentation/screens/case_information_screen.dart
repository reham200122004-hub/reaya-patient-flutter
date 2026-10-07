import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../data/models/case_information_model.dart';
import '../providers/booking_provider.dart';
import '../providers/reaya_sense_provider.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/voice_input_button.dart';
import '../widgets/summary_card.dart';

class CaseInformationScreen extends StatefulWidget {
  const CaseInformationScreen({super.key});

  @override
  State<CaseInformationScreen> createState() => _CaseInformationScreenState();
}

class _CaseInformationScreenState extends State<CaseInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController(text: 'الحاج عبد الرحمن الشامي');
  final _ageController = TextEditingController(text: '68');
  final _descriptionController = TextEditingController();
  final _symptomsController = TextEditingController();
  final _notesController = TextEditingController();
  CasePriority _selectedPriority = CasePriority.medium;

  @override
  void initState() {
    super.initState();
    _descriptionController.text = 'يحتاج غيار معقم على جرح الساق ومتابعة السكر.';
    _notesController.text = 'المريض يتناول أدوية سيولة (بلافيكس).';
  }

  @override
  void dispose() {
    _patientNameController.dispose();
    _ageController.dispose();
    _descriptionController.dispose();
    _symptomsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _proceedToLocation() {
    if (_formKey.currentState?.validate() ?? false) {
      final bookingProvider = context.read<BookingProvider>();
      final caseInfo = CaseInformationModel(
        patientName: _patientNameController.text.trim(),
        patientAge: int.tryParse(_ageController.text.trim()) ?? 65,
        conditionDescription: _descriptionController.text.trim(),
        specificSymptoms: _symptomsController.text.trim().isEmpty ? 'متابعة دورية' : _symptomsController.text.trim(),
        requestedServiceName: bookingProvider.selectedService?.title ?? 'خدمات تمريض منزلية',
        medicalNotes: _notesController.text.trim(),
        priority: _selectedPriority,
      );

      bookingProvider.setCaseInformation(caseInfo);
      Navigator.pushNamed(context, AppRoutes.location);
    }
  }

  @override
  Widget build(BuildContext context) {
    final senseProvider = context.watch<ReayaSenseProvider>();

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('معلومات الحالة وتفاصيل الشكوى'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ميزة REAYA Sense في الأعلى
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.blushPink.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.dustyRoseLight.withOpacity(0.4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.auto_awesome, color: AppColors.dustyRose, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'مساعد REAYA Sense الصوتي والذكي',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.dustyRoseDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'بدلاً من ملء كل الحقول يدويًا، يمكنك التحدث وسيقوم النظام بتلخيص الحالة واقتراح الخدمة تلقائيًا.',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 14),
                      VoiceInputButton(
                        isRecording: senseProvider.state == ReayaSenseState.recordingVoice,
                        onTap: () {
                          if (senseProvider.state == ReayaSenseState.recordingVoice) {
                            senseProvider.stopVoiceRecording();
                            // مزامنة النص في الحقل
                            Future.delayed(const Duration(milliseconds: 1500), () {
                              if (senseProvider.generatedCaseInfo != null) {
                                setState(() {
                                  _descriptionController.text = senseProvider.generatedCaseInfo!.conditionDescription;
                                  _notesController.text = senseProvider.generatedCaseInfo!.medicalNotes;
                                });
                              }
                            });
                          } else {
                            senseProvider.startVoiceRecording();
                          }
                        },
                      ),
                    ],
                  ),
                ),

                // حالة المعالجة أو عرض الملخص المنظم لـ REAYA Sense
                if (senseProvider.state == ReayaSenseState.processing) ...[
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceWhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.warmBeige),
                    ),
                    child: const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.dustyRose)),
                          SizedBox(height: 14),
                          Text(
                            'يقوم REAYA Sense بتحليل الكلمات واستخراج الاحتياجات التمريضية...',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'Cairo', fontSize: 13, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                if (senseProvider.structuredSummary != null &&
                    senseProvider.state == ReayaSenseState.summaryReady) ...[
                  const SizedBox(height: 20),
                  SummaryCard(
                    summary: senseProvider.structuredSummary!,
                    onConfirm: () {
                      senseProvider.confirmSummary();
                      if (senseProvider.generatedCaseInfo != null) {
                        context.read<BookingProvider>().setCaseInformation(senseProvider.generatedCaseInfo!);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم تأكيد بيانات الحالة بنجاح!', style: TextStyle(fontFamily: 'Cairo')),
                          backgroundColor: AppColors.mutedGreen,
                        ),
                      );
                    },
                    onEdit: () {
                      senseProvider.resetForNewInput();
                    },
                    onReRecord: () {
                      senseProvider.startVoiceRecording();
                    },
                  ),
                ],

                const SizedBox(height: 24),
                const Text(
                  'تفاصيل الحالة والبيانات الأساسية',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.warmDarkGray,
                  ),
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'اسم المريض',
                  hint: 'اسم متلقي الرعاية',
                  controller: _patientNameController,
                  isRequired: true,
                  prefixIcon: Icons.person_outline,
                  validator: (v) => (v == null || v.isEmpty) ? 'اسم المريض مطلوب' : null,
                ),
                const SizedBox(height: 14),

                CustomTextField(
                  label: 'عمر المريض (بالسنوات)',
                  hint: 'مثال: 68',
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  isRequired: true,
                  prefixIcon: Icons.calendar_month_outlined,
                  validator: (v) => (v == null || v.isEmpty) ? 'العمر مطلوب' : null,
                ),
                const SizedBox(height: 14),

                CustomTextField(
                  label: 'وصف الحالة المرضية والشكوى الحالية',
                  hint: 'صف بالتفصيل ما يشكو منه المريض أو سبب طلب الزيارة...',
                  controller: _descriptionController,
                  maxLines: 3,
                  isRequired: true,
                  validator: (v) => (v == null || v.length < 5) ? 'يرجى كتابة وصف واضح للحالة' : null,
                ),
                const SizedBox(height: 14),

                CustomTextField(
                  label: 'أعراض خاصة أو ملاحظات حرجة (اختياري)',
                  hint: 'مثال: دوخة، احمرار حول الجرح، ارتفاع طفيف بالحرارة',
                  controller: _symptomsController,
                  maxLines: 2,
                  prefixIcon: Icons.healing_outlined,
                ),
                const SizedBox(height: 14),

                CustomTextField(
                  label: 'الأدوية والملاحظات الطبية المهمة للممرض',
                  hint: 'مثال: يتناول أدوية سيولة، حساسية من البنسلين، إلخ',
                  controller: _notesController,
                  maxLines: 2,
                  prefixIcon: Icons.medication_outlined,
                ),
                const SizedBox(height: 18),

                // تحديد أولوية الزيارة
                const Text(
                  'درجة أولوية الزيارة',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.warmDarkGray,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildPriorityChip(CasePriority.low, 'عادية (روتينية)'),
                    const SizedBox(width: 8),
                    _buildPriorityChip(CasePriority.medium, 'متوسطة (اليوم)'),
                    const SizedBox(width: 8),
                    _buildPriorityChip(CasePriority.high, 'عاجلة (ساعتين)'),
                  ],
                ),

                const SizedBox(height: 32),
                PrimaryButton(
                  text: 'متابعة لتحديد الموقع',
                  icon: Icons.arrow_back_rounded,
                  onPressed: _proceedToLocation,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityChip(CasePriority priority, String label) {
    final isSelected = _selectedPriority == priority;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPriority = priority),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.dustyRose : AppColors.surfaceWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.dustyRose : AppColors.warmBeige,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : AppColors.warmDarkGray,
            ),
          ),
        ),
      ),
    );
  }
}
