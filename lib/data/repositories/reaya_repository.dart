import '../models/patient_model.dart';
import '../models/nurse_model.dart';
import '../models/service_model.dart';
import '../models/booking_model.dart';
import '../models/medical_record_model.dart';
import '../mock/mock_data.dart';

abstract class ReayaRepository {
  Future<PatientModel> getPatientProfile();
  Future<List<ServiceModel>> getServices();
  Future<List<NurseModel>> getRecommendedNurses({String? serviceId, String? location});
  Future<List<BookingModel>> getBookings();
  Future<BookingModel> createBooking(BookingModel booking);
  Future<List<MedicalRecordModel>> getMedicalRecords();
}

class ReayaRepositoryImpl implements ReayaRepository {
  @override
  Future<PatientModel> getPatientProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockData.currentPatient;
  }

  @override
  Future<List<ServiceModel>> getServices() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockData.services;
  }

  @override
  Future<List<NurseModel>> getRecommendedNurses({String? serviceId, String? location}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.nurses;
  }

  @override
  Future<List<BookingModel>> getBookings() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return MockData.initialBookings;
  }

  @override
  Future<BookingModel> createBooking(BookingModel booking) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return booking;
  }

  @override
  Future<List<MedicalRecordModel>> getMedicalRecords() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockData.medicalRecords;
  }
}
