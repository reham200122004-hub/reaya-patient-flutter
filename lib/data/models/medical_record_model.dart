class MedicalRecordModel {
  final String id;
  final String date;
  final String serviceTitle;
  final String nurseName;
  final String vitalSigns; // الضغط 120/80 - السكر 110
  final String nurseNotes;
  final String recommendedFollowUp;

  const MedicalRecordModel({
    required this.id,
    required this.date,
    required this.serviceTitle,
    required this.nurseName,
    required this.vitalSigns,
    required this.nurseNotes,
    required this.recommendedFollowUp,
  });
}

enum NotificationType {
  bookingConfirmed,
  nurseAssigned,
  reminder,
  serviceCompleted,
  rateRequest,
}

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String timestamp;
  final NotificationType type;
  final bool isRead;
  final String? bookingId;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.type,
    this.isRead = false,
    this.bookingId,
  });

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      body: body,
      timestamp: timestamp,
      type: type,
      isRead: isRead ?? this.isRead,
      bookingId: bookingId,
    );
  }
}

class RatingModel {
  final String bookingId;
  final String nurseId;
  final int rating;
  final String feedback;
  final List<String> tags;
  final DateTime createdAt;

  const RatingModel({
    required this.bookingId,
    required this.nurseId,
    required this.rating,
    required this.feedback,
    required this.tags,
    required this.createdAt,
  });
}
