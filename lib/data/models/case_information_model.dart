enum CasePriority {
  low,
  medium,
  high,
  urgent,
}

class CaseInformationModel {
  final String patientName;
  final int patientAge;
  final String conditionDescription;
  final String specificSymptoms;
  final String requestedServiceName;
  final String medicalNotes;
  final bool hasVoiceNote;
  final String? voiceNoteDuration;
  final CasePriority priority;
  final String mobilityStatus; // قادر على الحركة، طريح الفراش، إلخ
  final List<String> requiredEquipments;

  const CaseInformationModel({
    required this.patientName,
    required this.patientAge,
    required this.conditionDescription,
    required this.specificSymptoms,
    required this.requestedServiceName,
    required this.medicalNotes,
    this.hasVoiceNote = false,
    this.voiceNoteDuration,
    this.priority = CasePriority.medium,
    this.mobilityStatus = 'محدود الحركة بمساعدة',
    this.requiredEquipments = const ['جهاز قياس الضغط', 'مسحات طبية معقمة'],
  });

  String get priorityArabic {
    switch (priority) {
      case CasePriority.low:
        return 'عادية (متابعة روتينية)';
      case CasePriority.medium:
        return 'متوسطة (تحتاج رعاية اليوم)';
      case CasePriority.high:
        return 'مرتفعة (خلال ساعتين)';
      case CasePriority.urgent:
        return 'عاجلة وفورية';
    }
  }
}

class StructuredCaseSummary {
  final String summaryTitle;
  final String primaryCondition;
  final String recommendedService;
  final String keyPrecautions;
  final String estimatedVisitTime;
  final CasePriority priority;
  final bool isVerifiedByUser;

  const StructuredCaseSummary({
    required this.summaryTitle,
    required this.primaryCondition,
    required this.recommendedService,
    required this.keyPrecautions,
    required this.estimatedVisitTime,
    required this.priority,
    this.isVerifiedByUser = false,
  });
}
