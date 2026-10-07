import 'package:flutter/foundation.dart';
import '../../data/models/case_information_model.dart';
import '../../data/models/service_model.dart';
import '../../data/mock/mock_data.dart';

enum ReayaSenseState {
  idle,
  recordingVoice,
  processing,
  summaryReady,
  verified,
}

class ReayaSenseProvider with ChangeNotifier {
  ReayaSenseState _state = ReayaSenseState.idle;
  String _inputVoiceOrText = '';
  int _recordingSeconds = 0;
  bool _isVoiceMode = false;
  
  CaseInformationModel? _generatedCaseInfo;
  StructuredCaseSummary? _structuredSummary;
  ServiceModel? _matchedService;

  ReayaSenseState get state => _state;
  String get inputVoiceOrText => _inputVoiceOrText;
  int get recordingSeconds => _recordingSeconds;
  bool get isVoiceMode => _isVoiceMode;
  CaseInformationModel? get generatedCaseInfo => _generatedCaseInfo;
  StructuredCaseSummary? get structuredSummary => _structuredSummary;
  ServiceModel? get matchedService => _matchedService;

  void startVoiceRecording() {
    _state = ReayaSenseState.recordingVoice;
    _isVoiceMode = true;
    _recordingSeconds = 0;
    _inputVoiceOrText = 'جاري التسجيل الصوتي... تحدث بارتياح عن شكوى المريض واحتياجه.';
    notifyListeners();
  }

  void stopVoiceRecording() {
    // محاكاة انتهاء التسجيل الصوتي بنص واقعي
    _inputVoiceOrText = 'والدي 68 سنة، عنده سكر وضغط، وعامل عملية جراحية بسيطة في الساق اليسرى ومحتاج ممرضة تغيرله على الغيار وتعقم الجرح كويس، وبياخد أدوية سيولة فنرجو الحذر الشديد.';
    processCaseDescription(_inputVoiceOrText);
  }

  void cancelRecording() {
    _state = ReayaSenseState.idle;
    _isVoiceMode = false;
    _recordingSeconds = 0;
    _inputVoiceOrText = '';
    notifyListeners();
  }

  Future<void> processCaseDescription(String text) async {
    _inputVoiceOrText = text;
    _state = ReayaSenseState.processing;
    notifyListeners();

    // محاكاة معالجة ذكية سريعة وواقعية (Mock AI Behavior)
    await Future.delayed(const Duration(milliseconds: 1400));

    // مطابقة ذكية للخدمة المناسبة
    if (text.contains('غيار') || text.contains('جرح') || text.contains('عملية')) {
      _matchedService = MockData.services[0]; // تغيير الغيار والجروح
    } else if (text.contains('سكر')) {
      _matchedService = MockData.services[2]; // قياس السكر
    } else if (text.contains('ضغط') || text.contains('دوخة')) {
      _matchedService = MockData.services[1]; // قياس الضغط
    } else if (text.contains('كبير') || text.contains('مسن') || text.contains('مرافقة')) {
      _matchedService = MockData.services[3]; // رعاية كبار السن
    } else {
      _matchedService = MockData.services[5]; // تمريض منزلي
    }

    _generatedCaseInfo = CaseInformationModel(
      patientName: MockData.currentPatient.name,
      patientAge: MockData.currentPatient.age,
      conditionDescription: text,
      specificSymptoms: 'احمرار طفيف حول الضمادة، يحتاج فحص الالتئام وتطهير معقم.',
      requestedServiceName: _matchedService!.title,
      medicalNotes: 'مريض سكري وضغط ويتناول أدوية سيولة (بلافيكس). ممنوع الشد العنيف على الجرح.',
      hasVoiceNote: _isVoiceMode,
      voiceNoteDuration: _isVoiceMode ? '0:24 دقيقة' : null,
      priority: CasePriority.high,
      mobilityStatus: 'محدود الحركة بمساعدة خفيفة',
      requiredEquipments: ['شاش طبي معقم', 'محلول ملحي ومطهر بتادين', 'جهاز قياس ضغط وسكر'],
    );

    _structuredSummary = StructuredCaseSummary(
      summaryTitle: 'ملخص الحالة المنظم - REAYA Sense',
      primaryCondition: 'متابعة وتغيير غيار جراحي لمريض سكري وسيولة',
      recommendedService: _matchedService!.title,
      keyPrecautions: 'تجنب الاحتكاك العنيف، التأكد من تعقيم الأدوات، مراعاة تاريخ السيولة الدموية.',
      estimatedVisitTime: '45 إلى 60 دقيقة',
      priority: CasePriority.high,
      isVerifiedByUser: false,
    );

    _state = ReayaSenseState.summaryReady;
    notifyListeners();
  }

  void confirmSummary() {
    _state = ReayaSenseState.verified;
    notifyListeners();
  }

  void resetForNewInput() {
    _state = ReayaSenseState.idle;
    _inputVoiceOrText = '';
    _recordingSeconds = 0;
    _isVoiceMode = false;
    _generatedCaseInfo = null;
    _structuredSummary = null;
    notifyListeners();
  }
}
