import 'package:flutter/foundation.dart';
import '../../data/models/patient_model.dart';
import '../../data/mock/mock_data.dart';

class AuthProvider with ChangeNotifier {
  PatientModel? _currentPatient = MockData.currentPatient;
  bool _isAuthenticated = true;
  bool _isLoading = false;
  String? _errorMessage;

  PatientModel? get currentPatient => _currentPatient;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String phone, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    if (phone.isNotEmpty && password.length >= 6) {
      _isAuthenticated = true;
      _currentPatient = MockData.currentPatient;
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = 'يرجى إدخال رقم هاتف صحيح وكلمة مرور لا تقل عن 6 أحرف';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required int age,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    _currentPatient = PatientModel(
      id: 'p_new_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      phone: phone,
      email: email,
      address: 'شارع النزهة، مصر الجديدة، القاهرة',
      age: age,
      gender: 'ذكر',
      bloodType: 'O+',
      chronicDiseases: ['ضغط دم'],
    );
    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _currentPatient = null;
    notifyListeners();
  }

  void updateProfile({
    required String name,
    required String phone,
    required String address,
  }) {
    if (_currentPatient != null) {
      _currentPatient = PatientModel(
        id: _currentPatient!.id,
        name: name,
        phone: phone,
        email: _currentPatient!.email,
        address: address,
        age: _currentPatient!.age,
        gender: _currentPatient!.gender,
        bloodType: _currentPatient!.bloodType,
        chronicDiseases: _currentPatient!.chronicDiseases,
      );
      notifyListeners();
    }
  }
}
