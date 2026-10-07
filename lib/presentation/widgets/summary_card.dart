import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/case_information_model.dart';
import '../../data/models/booking_model.dart';

class SummaryCard extends StatelessWidget {
  final StructuredCaseSummary summary;
  final VoidCallback onConfirm;
  final VoidCallback onEdit;
  final VoidCallback onReRecord;

  const SummaryCard({
    super.key,
    required this.summary,
    required this.onConfirm,
    required this.onEdit,
    required this.onReRecord,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.dustyRose.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.dustyRose.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.blushPink,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.auto_awesome, color: AppColors.dustyRose, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  summary.summaryTitle,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.warmDarkGray,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.mutedGreenLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'REAYA Sense AI',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mutedGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow('الحالة الأساسية:', summary.primaryCondition),
          _buildInfoRow('الخدمة المقترحة:', summary.recommendedService),
          _buildInfoRow('الأولوية:', summary.priority == CasePriority.high ? 'عالية (خلال ساعتين)' : 'عادية'),
          _buildInfoRow('ملاحظات وتنبيهات:', summary.keyPrecautions),
          _buildInfoRow('الوقت التقديري:', summary.estimatedVisitTime),
          const SizedBox(height: 14),
          const Divider(height: 1, color: AppColors.warmBeige),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'هل المعلومات دي صحيحة؟',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.warmDarkGray,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: onConfirm,
                  icon: const Icon(Icons.check, size: 18),
                  label: const Text('تأكيد البيانات'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dustyRose,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: onEdit,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.warmDarkGray,
                    side: const BorderSide(color: AppColors.warmBeige),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('تعديل'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Center(
            child: TextButton.icon(
              onPressed: onReRecord,
              icon: const Icon(Icons.replay, size: 16, color: AppColors.softMauve),
              label: const Text(
                'إعادة التسجيل الصوتي',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 13, color: AppColors.softMauve),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.warmDarkGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CareHandoverCard extends StatelessWidget {
  final CareHandoverSummary handover;

  const CareHandoverCard({super.key, required this.handover});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.warmBeige, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.dustyRose,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.assignment_turned_in_rounded, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'REAYA Care Handover',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.warmDarkGray,
                    ),
                  ),
                  Text(
                    'ملخص تسليم الحالة التمريضية المعتمد',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: AppColors.warmBeige),
          const SizedBox(height: 12),
          _item('حالة المريض:', handover.patientCondition),
          _item('تفاصيل الإجراء:', handover.serviceDetails),
          _item('ملاحظات الممرض:', handover.nurseObservations),
          _item('الأدوية والمحاليل:', handover.medicationsAdministered),
          _item('الخطوات القادمة:', handover.nextSteps),
          _item('توقيت التسليم:', handover.handoverTime),
        ],
      ),
    );
  }

  Widget _item(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.dustyRoseDark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            desc,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13,
              color: AppColors.warmDarkGray,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
