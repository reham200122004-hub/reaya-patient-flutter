import 'package:flutter/foundation.dart';
import '../../data/models/nurse_model.dart';
import '../../data/models/service_model.dart';
import '../../data/models/booking_model.dart';
import '../../data/models/case_information_model.dart';
import '../../data/models/medical_record_model.dart';
import '../../data/mock/mock_data.dart';

class BookingProvider with ChangeNotifier {
  List<BookingModel> _bookings = List.from(MockData.initialBookings);
  List<NotificationModel> _notifications = List.from(MockData.notifications);
  List<MedicalRecordModel> _medicalRecords = List.from(MockData.medicalRecords);
  
  // بيانات مسار الحجز الجاري (Active Booking Draft)
  ServiceModel? _selectedService = MockData.services[0];
  CaseInformationModel? _currentCaseInfo;
  String _selectedLocation = MockData.currentPatient.address;
  NurseModel? _selectedNurse = MockData.nurses[0];
  DateTime _scheduledDate = DateTime.now().add(const Duration(hours: 3));
  String _selectedTimeSlot = '06:30 مساءً';
  String _additionalNotes = 'يرجى الحضور في الموعد، المصعد متاح بالعمارة.';
  
  BookingModel? _lastCreatedBooking;
  bool _isLoading = false;

  // Getters
  List<BookingModel> get bookings => _bookings;
  List<NotificationModel> get notifications => _notifications;
  List<MedicalRecordModel> get medicalRecords => _medicalRecords;
  
  List<BookingModel> get upcomingBookings => 
      _bookings.where((b) => b.status == BookingStatus.confirmed || b.status == BookingStatus.inProgress || b.status == BookingStatus.pending).toList();

  List<BookingModel> get completedBookings => 
      _bookings.where((b) => b.status == BookingStatus.completed).toList();

  List<BookingModel> get cancelledBookings => 
      _bookings.where((b) => b.status == BookingStatus.cancelled).toList();

  ServiceModel? get selectedService => _selectedService;
  CaseInformationModel? get currentCaseInfo => _currentCaseInfo;
  String get selectedLocation => _selectedLocation;
  NurseModel? get selectedNurse => _selectedNurse;
  DateTime get scheduledDate => _scheduledDate;
  String get selectedTimeSlot => _selectedTimeSlot;
  String get additionalNotes => _additionalNotes;
  BookingModel? get lastCreatedBooking => _lastCreatedBooking;
  bool get isLoading => _isLoading;

  int get unreadNotificationsCount => 
      _notifications.where((n) => !n.isRead).length;

  void selectService(ServiceModel service) {
    _selectedService = service;
    notifyListeners();
  }

  void setCaseInformation(CaseInformationModel info) {
    _currentCaseInfo = info;
    notifyListeners();
  }

  void setLocation(String location) {
    _selectedLocation = location;
    notifyListeners();
  }

  void selectNurse(NurseModel nurse) {
    _selectedNurse = nurse;
    notifyListeners();
  }

  void setSchedule(DateTime date, String timeSlot) {
    _scheduledDate = date;
    _selectedTimeSlot = timeSlot;
    notifyListeners();
  }

  void setAdditionalNotes(String notes) {
    _additionalNotes = notes;
    notifyListeners();
  }

  Future<BookingModel> confirmCurrentBooking() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1200));

    final newBooking = BookingModel(
      id: 'bkg_${DateTime.now().millisecondsSinceEpoch}',
      bookingReference: 'REA-${1000 + _bookings.length * 11}',
      nurse: _selectedNurse ?? MockData.nurses[0],
      service: _selectedService ?? MockData.services[0],
      caseInfo: _currentCaseInfo ?? const CaseInformationModel(
        patientName: 'الحاج عبد الرحمن الشامي',
        patientAge: 68,
        conditionDescription: 'رعاية تمريضية وغيار معقم',
        specificSymptoms: 'متابعة دورية',
        requestedServiceName: 'تغيير الغيار والجروح',
        medicalNotes: 'مريض سكري وضغط',
      ),
      scheduledDate: _scheduledDate,
      scheduledTimeSlot: _selectedTimeSlot,
      locationAddress: _selectedLocation,
      totalPrice: (_selectedService?.basePrice ?? 150) + 30, // 30 مصاريف انتقالات
      status: BookingStatus.confirmed,
      createdAt: DateTime.now(),
    );

    _bookings.insert(0, newBooking);
    _lastCreatedBooking = newBooking;

    // إضافة إشعار جديد للحجز
    _notifications.insert(0, NotificationModel(
      id: 'notif_${DateTime.now().millisecondsSinceEpoch}',
      title: 'تم تأكيد حجزك بنجاح (${newBooking.bookingReference})',
      body: 'سيتوجه الممرض ${newBooking.nurse.name} إليك في الموعد المحدد.',
      timestamp: 'الآن',
      type: NotificationType.bookingConfirmed,
      isRead: false,
      bookingId: newBooking.id,
    ));

    _isLoading = false;
    notifyListeners();
    return newBooking;
  }

  void markNotificationAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void markAllNotificationsAsRead() {
    _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
    notifyListeners();
  }

  void submitRating({
    required String bookingId,
    required String nurseId,
    required int rating,
    required String feedback,
    required List<String> tags,
  }) {
    // محاكاة تسجيل التقييم بنجاح
    notifyListeners();
  }
}
