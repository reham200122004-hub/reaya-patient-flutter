import 'nurse_model.dart';
import 'service_model.dart';
import 'case_information_model.dart';

enum BookingStatus {
  pending,
  confirmed,
  inProgress,
  completed,
  cancelled,
}

class CareHandoverSummary {
  final String patientCondition;
  final String serviceDetails;
  final String nurseObservations;
  final String medicationsAdministered;
  final String nextSteps;
  final String handoverTime;

  const CareHandoverSummary({
    required this.patientCondition,
    required this.serviceDetails,
    required this.nurseObservations,
    required this.medicationsAdministered,
    required this.nextSteps,
    required this.handoverTime,
  });
}

class BookingModel {
  final String id;
  final String bookingReference;
  final NurseModel nurse;
  final ServiceModel service;
  final CaseInformationModel caseInfo;
  final DateTime scheduledDate;
  final String scheduledTimeSlot;
  final String locationAddress;
  final double totalPrice;
  final BookingStatus status;
  final CareHandoverSummary? handoverSummary;
  final DateTime createdAt;

  const BookingModel({
    required this.id,
    required this.bookingReference,
    required this.nurse,
    required this.service,
    required this.caseInfo,
    required this.scheduledDate,
    required this.scheduledTimeSlot,
    required this.locationAddress,
    required this.totalPrice,
    required this.status,
    this.handoverSummary,
    required this.createdAt,
  });

  String get statusArabic {
    switch (status) {
      case BookingStatus.pending:
        return 'قيد الانتظار';
      case BookingStatus.confirmed:
        return 'مؤكد ومجدول';
      case BookingStatus.inProgress:
        return 'الممرض في الطريق';
      case BookingStatus.completed:
        return 'مكتمل بنجاح';
      case BookingStatus.cancelled:
        return 'ملغي';
    }
  }
}
