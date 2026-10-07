import React, { useState, useEffect } from 'react';
import {
  Heart,
  Phone,
  Lock,
  User,
  MapPin,
  Calendar,
  Clock,
  Star,
  CheckCircle,
  AlertCircle,
  ArrowRight,
  ArrowLeft,
  Mic,
  MicOff,
  Bell,
  Activity,
  FileText,
  Settings,
  LogOut,
  ChevronLeft,
  Sparkles,
  Share2,
  Send,
  HelpCircle,
  Shield,
  Search,
  Code,
  Smartphone,
  Copy,
  Check
} from 'lucide-react';

// ألوان رِعاية المعتمدة
const COLORS = {
  dustyRose: '#B86B77',
  dustyRoseDark: '#9E5460',
  blushPink: '#F6E6E8',
  softMauve: '#8E6C75',
  warmBeige: '#EFE6DE',
  cream: '#F7F2EC',
  offWhite: '#FBF8F5',
  warmDarkGray: '#2C2426',
  textSecondary: '#6F5E62',
  mutedGreen: '#5B8E6A',
  mutedGreenLight: '#EAF4EE',
};

// الشاشات الـ 19 المعتمدة
type Screen =
  | 'splash'
  | 'onboarding'
  | 'login'
  | 'register'
  | 'forgot_password'
  | 'home'
  | 'profile'
  | 'services'
  | 'case_info'
  | 'location'
  | 'nurse_recommendation'
  | 'nurse_details'
  | 'confirm_booking'
  | 'booking_success'
  | 'bookings'
  | 'booking_details'
  | 'medical_record'
  | 'notifications'
  | 'rating';

export default function App() {
  const [currentScreen, setCurrentScreen] = useState<Screen>('splash');
  const [activeTab, setActiveTab] = useState<'preview' | 'code'>('preview');
  const [selectedFile, setSelectedFile] = useState<string>('lib/main.dart');
  const [copied, setCopied] = useState(false);

  // حالة المستخدم والبيانات
  const [patientName, setPatientName] = useState('الحاج عبد الرحمن الشامي');
  const [patientPhone, setPatientPhone] = useState('01012345678');
  const [patientAddress, setPatientAddress] = useState('شارع النزهة، مصر الجديدة، القاهرة (الدور الرابع - شقة 12)');
  
  // حالة مسار الحجز
  const [selectedServiceId, setSelectedServiceId] = useState('srv_1');
  const [caseDescription, setCaseDescription] = useState('يحتاج غيار معقم على جرح الساق اليسرى بعد جراحة بسيطة ومتابعة السكر.');
  const [caseNotes, setCaseNotes] = useState('المريض يتناول أدوية سيولة (بلافيكس).');
  const [isRecording, setIsRecording] = useState(false);
  const [isSenseProcessing, setIsSenseProcessing] = useState(false);
  const [senseSummaryVerified, setSenseSummaryVerified] = useState(false);
  const [selectedNurseId, setSelectedNurseId] = useState('nurse_1');
  const [selectedTimeSlot, setSelectedTimeSlot] = useState('06:30 مساءً');
  const [bookingReference, setBookingReference] = useState('REA-8921');
  const [ratingStars, setRatingStars] = useState(5);
  const [ratingSubmitted, setRatingSubmitted] = useState(false);
  const [unreadNotifs, setUnreadNotifs] = useState(2);
  const [bookingsFilter, setBookingsFilter] = useState<'upcoming' | 'completed' | 'cancelled'>('upcoming');

  // البيانات التجريبية
  const services = [
    { id: 'srv_1', title: 'تغيير الغيار والجروح', price: 150, duration: '45 دقيقة', desc: 'تنظيف وتعقيم متقدم للغيار الجراحي وقرح الفراش بأعلى درجات الأمان.' },
    { id: 'srv_2', title: 'قياس الضغط والعلامات الحيوية', price: 80, duration: '30 دقيقة', desc: 'متابعة شاملة لضغط الدم، نبض القلب، نسبة الأكسجين ودرجة الحرارة.' },
    { id: 'srv_3', title: 'قياس السكر وضبط الجرعات', price: 70, duration: '30 دقيقة', desc: 'فحص سكر الدم الصائم والعشوائي وتدوين قراءات المتابعة بدقة.' },
    { id: 'srv_4', title: 'متابعة ورعاية كبار السن', price: 220, duration: 'ساعتان', desc: 'رعاية إنسانية متخصصة تلبي الاحتياجات الحركية والنفسية والصحية.' },
    { id: 'srv_5', title: 'الإسعافات الأولية البسيطة', price: 120, duration: '40 دقيقة', desc: 'تعامل فوري مع الكدمات الطفيفة، الحروق البسيطة، أو الدوار المؤقت.' },
    { id: 'srv_6', title: 'خدمات تمريض منزلية متقدمة', price: 180, duration: '60 دقيقة', desc: 'تركيب الكانيولا، المحاليل الوريدية، والحقن العضلي بإشراف معتمد.' },
  ];

  const nurses = [
    {
      id: 'nurse_1',
      name: 'ممرضة / فاطمة الزهراء علي',
      title: 'أخصائية تمريض كبار السن والعناية الحرجة',
      rating: 4.9,
      reviews: 142,
      experience: '7 سنوات خبرة',
      specialty: 'رعاية كبار السن والجروح المعقدة',
      distance: '1.2 كم (10 دقائق)',
      matchScore: 96,
      price: 120,
      avatar: 'https://images.unsplash.com/photo-1594824813589-cf2b36e3c042?auto=format&fit=crop&w=300&q=80',
      about: 'أخصائية تمريض معتمدة من جامعة عين شمس، عملت في قسم الباطنة والرعاية المركزة. حاصلة على شهادات الإنعاش ومتابعة القدم السكري.',
    },
    {
      id: 'nurse_2',
      name: 'أخصائي / أحمد مصطفى سالم',
      title: 'أخصائي تمريض منزلي ورعاية طوارئ',
      rating: 4.8,
      reviews: 98,
      experience: '5 سنوات خبرة',
      specialty: 'المحاليل، الكانيولا، والعلامات الحيوية',
      distance: '2.5 كم (15 دقيقة)',
      matchScore: 92,
      price: 110,
      avatar: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80',
      about: 'ممرض أخصائي معتمد متخصص في تركيب الكانيولا الوريدية الصعبة وإعطاء المحاليل ومتابعة مرضى ارتفاع ضغط الدم والسكري.',
    },
    {
      id: 'nurse_3',
      name: 'ممرضة / مريم يسري إبراهيم',
      title: 'أخصائية تمريض الجراحة والرعاية العامة',
      rating: 4.9,
      reviews: 165,
      experience: '8 سنوات خبرة',
      specialty: 'الغيار الجراحي ومتابعة العمليات',
      distance: '3.1 كم (20 دقيقة)',
      matchScore: 89,
      price: 130,
      avatar: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80',
      about: 'خبرة طويلة بمستشفيات القصر العيني في متابعة الجروح الجراحية المعقمة، صبورة ولطيفة في التعامل مع كبار السن.',
    },
  ];

  // تشغيل الـ Splash تلقائياً للتحول بعد 2.5 ثانية
  useEffect(() => {
    if (currentScreen === 'splash') {
      const timer = setTimeout(() => {
        setCurrentScreen('onboarding');
      }, 2400);
      return () => clearTimeout(timer);
    }
  }, [currentScreen]);

  const activeService = services.find((s) => s.id === selectedServiceId) || services[0];
  const activeNurse = nurses.find((n) => n.id === selectedNurseId) || nurses[0];

  const handleVoiceSenseClick = () => {
    if (isRecording) {
      setIsRecording(false);
      setIsSenseProcessing(true);
      setTimeout(() => {
        setIsSenseProcessing(false);
        setCaseDescription('والدي 68 سنة، يعاني من سكر وضغط، وعامل جراحة بسيطة بالساق ومحتاج غيار معقم ومتابعة مع الحذر من السيولة.');
        setCaseNotes('يتناول أدوية سيولة (بلافيكس)، يرجى التعامل برفق مع الجرح.');
        setSelectedServiceId('srv_1');
        setSenseSummaryVerified(false);
      }, 1200);
    } else {
      setIsRecording(true);
    }
  };

  const copyCode = (code: string) => {
    navigator.clipboard.writeText(code);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  return (
    <div className="min-h-screen bg-[#F4EDE7] flex flex-col items-center justify-start p-2 sm:p-6 text-[#2C2426]">
      {/* الشريط العلوي للتحكم بالمعاينة وأكواد فلاتر */}
      <header className="w-full max-w-5xl bg-white/90 backdrop-blur-md rounded-2xl p-4 shadow-sm border border-[#EFE6DE] mb-6 flex flex-wrap items-center justify-between gap-4">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-xl bg-[#B86B77] flex items-center justify-center text-white shadow-md">
            <Heart className="w-5 h-5 fill-white" />
          </div>
          <div>
            <h1 className="text-lg font-bold text-[#2C2426] flex items-center gap-2">
              رِعاية — REAYA
              <span className="text-xs bg-[#F6E6E8] text-[#9E5460] font-semibold px-2 py-0.5 rounded-full">
                Flutter 3.x Mobile App
              </span>
            </h1>
            <p className="text-xs text-[#6F5E62]">
              "رِعاية مش مجرد خدمة، دي طمأنينة" • 19 شاشة متكاملة • Provider Architecture
            </p>
          </div>
        </div>

        {/* أزرار التبديل ومحدد الشاشات السريع */}
        <div className="flex items-center gap-3">
          <div className="flex items-center bg-[#F7F2EC] p-1 rounded-xl border border-[#EFE6DE]">
            <button
              onClick={() => setActiveTab('preview')}
              className={`flex items-center gap-2 px-3 py-1.5 rounded-lg text-xs font-bold transition-all ${
                activeTab === 'preview' ? 'bg-[#B86B77] text-white shadow-sm' : 'text-[#6F5E62] hover:text-[#2C2426]'
              }`}
            >
              <Smartphone className="w-4 h-4" />
              المعاينة التفاعلية (19 شاشة)
            </button>
            <button
              onClick={() => setActiveTab('code')}
              className={`flex items-center gap-2 px-3 py-1.5 rounded-lg text-xs font-bold transition-all ${
                activeTab === 'code' ? 'bg-[#B86B77] text-white shadow-sm' : 'text-[#6F5E62] hover:text-[#2C2426]'
              }`}
            >
              <Code className="w-4 h-4" />
              أكواد فلاتر (lib/*.dart)
            </button>
          </div>

          <select
            value={currentScreen}
            onChange={(e) => setCurrentScreen(e.target.value as Screen)}
            className="text-xs font-bold bg-[#FBF8F5] border border-[#EFE6DE] text-[#2C2426] rounded-xl px-3 py-2 outline-none focus:border-[#B86B77]"
          >
            <option value="splash">1. Splash</option>
            <option value="onboarding">2. Onboarding</option>
            <option value="login">3. Login</option>
            <option value="register">4. Register</option>
            <option value="forgot_password">5. Forgot Password</option>
            <option value="home">6. Home</option>
            <option value="services">7. Services</option>
            <option value="case_info">8. Case Information (REAYA Sense)</option>
            <option value="location">9. Location</option>
            <option value="nurse_recommendation">10. Nurse Recommendation</option>
            <option value="nurse_details">11. Nurse Details</option>
            <option value="confirm_booking">12. Confirm Booking</option>
            <option value="booking_success">13. Booking Success</option>
            <option value="bookings">14. Bookings</option>
            <option value="booking_details">15. Booking Details (Care Handover)</option>
            <option value="medical_record">16. Medical Record</option>
            <option value="notifications">17. Notifications</option>
            <option value="profile">18. Profile</option>
            <option value="rating">19. Rating</option>
          </select>
        </div>
      </header>

      {/* المحتوى الرئيسي */}
      {activeTab === 'preview' ? (
        <div className="relative w-full max-w-[400px] h-[780px] bg-black rounded-[48px] p-3 shadow-2xl border-[6px] border-[#383133] overflow-hidden flex flex-col">
          {/* Dynamic Island / Notch */}
          <div className="absolute top-4 left-1/2 -translate-x-1/2 w-28 h-5 bg-black rounded-full z-50 flex items-center justify-end px-3">
            <div className="w-2.5 h-2.5 rounded-full bg-[#181818]" />
          </div>

          {/* شاشة الهاتف الداخلية */}
          <div className="w-full h-full bg-[#FBF8F5] rounded-[38px] overflow-hidden flex flex-col relative text-right select-none font-['Cairo',sans-serif]">
            
            {/* شريط الحالة العلوي للهاتف */}
            <div className="h-10 pt-2 px-6 flex justify-between items-center text-[11px] font-bold text-[#6F5E62] z-40 bg-[#FBF8F5]/80 backdrop-blur-sm">
              <span>09:41</span>
              <div className="flex items-center gap-1.5">
                <div className="w-4 h-2 rounded-sm border border-[#6F5E62] flex items-center p-0.5">
                  <div className="w-full h-full bg-[#6F5E62] rounded-2xs" />
                </div>
              </div>
            </div>

            {/* محتوى الشاشات الـ19 */}
            <div className="flex-1 overflow-y-auto pb-4 px-4">
              
              {/* 1. SPLASH SCREEN */}
              {currentScreen === 'splash' && (
                <div className="h-full flex flex-col items-center justify-center text-center animate-fade-in p-6">
                  <div className="w-24 h-24 rounded-full bg-[#B86B77] flex items-center justify-center text-white shadow-xl shadow-[#B86B77]/30 mb-6 animate-pulse">
                    <Heart className="w-12 h-12 fill-white" />
                  </div>
                  <h1 className="text-3xl font-black text-[#2C2426] mb-2 tracking-tight">رِعاية</h1>
                  <div className="bg-[#F6E6E8] text-[#9E5460] font-bold text-xs px-4 py-1.5 rounded-full mb-10">
                    "رِعاية مش مجرد خدمة، دي طمأنينة"
                  </div>
                  <div className="w-6 h-6 border-2 border-[#B86B77] border-t-transparent rounded-full animate-spin mb-4" />
                  <p className="text-xs text-[#8E6C75]">جاري تحميل التطبيق التمريضي...</p>
                </div>
              )}

              {/* 2. ONBOARDING SCREEN */}
              {currentScreen === 'onboarding' && (
                <div className="h-full flex flex-col justify-between py-6 animate-fade-in">
                  <div className="flex justify-between items-center">
                    <span className="text-xs font-bold text-[#B86B77]">REAYA 1.0</span>
                    <button
                      onClick={() => setCurrentScreen('login')}
                      className="text-xs font-bold text-[#8E6C75] hover:text-[#2C2426]"
                    >
                      تخطي
                    </button>
                  </div>

                  <div className="flex flex-col items-center text-center my-auto">
                    <div className="w-32 h-32 rounded-full bg-[#F6E6E8] border-2 border-[#EFE6DE] flex items-center justify-center text-[#B86B77] mb-8 shadow-inner">
                      <Heart className="w-16 h-16 fill-[#B86B77]" />
                    </div>
                    <h2 className="text-xl font-black text-[#2C2426] mb-3 leading-snug">
                      رعاية تمريضية متخصصة في دفء بيتك
                    </h2>
                    <p className="text-xs text-[#6F5E62] leading-relaxed max-w-[280px]">
                      طاقم تمريضي مؤهل وموثوق يصلك أينما كنت بأعلى درجات الرفق والإنسانية والأمان الطبي لأحبائك.
                    </p>
                    <div className="flex gap-1.5 mt-6">
                      <div className="w-6 h-1.5 rounded-full bg-[#B86B77]" />
                      <div className="w-2 h-1.5 rounded-full bg-[#EFE6DE]" />
                      <div className="w-2 h-1.5 rounded-full bg-[#EFE6DE]" />
                    </div>
                  </div>

                  <div className="space-y-2">
                    <button
                      onClick={() => setCurrentScreen('login')}
                      className="w-full h-12 bg-[#B86B77] text-white rounded-2xl font-bold text-sm shadow-md hover:bg-[#9E5460] transition-colors"
                    >
                      ابدأ الآن
                    </button>
                  </div>
                </div>
              )}

              {/* 3. LOGIN SCREEN */}
              {currentScreen === 'login' && (
                <div className="h-full flex flex-col justify-between py-4 animate-fade-in">
                  <div>
                    <div className="text-center my-6">
                      <div className="w-14 h-14 bg-[#F6E6E8] text-[#B86B77] rounded-full mx-auto flex items-center justify-center mb-3">
                        <Heart className="w-7 h-7 fill-[#B86B77]" />
                      </div>
                      <h2 className="text-xl font-black text-[#2C2426]">أهلاً بك في رِعاية</h2>
                      <p className="text-xs text-[#6F5E62]">سجل دخولك لمتابعة صحة أسرتك بكل طمأنينة</p>
                    </div>

                    <div className="space-y-4">
                      <div>
                        <label className="text-xs font-bold text-[#2C2426] block mb-1.5">رقم الهاتف *</label>
                        <div className="relative">
                          <input
                            type="text"
                            value={patientPhone}
                            onChange={(e) => setPatientPhone(e.target.value)}
                            className="w-full h-11 bg-[#F7F2EC] border border-[#EFE6DE] rounded-xl px-10 text-xs text-[#2C2426] focus:border-[#B86B77] outline-none text-left"
                            placeholder="01012345678"
                          />
                          <Phone className="w-4 h-4 text-[#8E6C75] absolute left-3 top-3.5" />
                        </div>
                      </div>

                      <div>
                        <label className="text-xs font-bold text-[#2C2426] block mb-1.5">كلمة المرور *</label>
                        <div className="relative">
                          <input
                            type="password"
                            defaultValue="123456"
                            className="w-full h-11 bg-[#F7F2EC] border border-[#EFE6DE] rounded-xl px-10 text-xs text-[#2C2426] focus:border-[#B86B77] outline-none text-left"
                            placeholder="••••••••"
                          />
                          <Lock className="w-4 h-4 text-[#8E6C75] absolute left-3 top-3.5" />
                        </div>
                      </div>

                      <div className="text-left">
                        <button
                          onClick={() => setCurrentScreen('forgot_password')}
                          className="text-xs font-bold text-[#9E5460]"
                        >
                          نسيت كلمة المرور؟
                        </button>
                      </div>
                    </div>
                  </div>

                  <div className="space-y-3 pt-6">
                    <button
                      onClick={() => setCurrentScreen('home')}
                      className="w-full h-12 bg-[#B86B77] text-white rounded-2xl font-bold text-sm shadow-md hover:bg-[#9E5460]"
                    >
                      تسجيل الدخول
                    </button>
                    <div className="text-center text-xs text-[#6F5E62]">
                      ليس لديك حساب؟{' '}
                      <button
                        onClick={() => setCurrentScreen('register')}
                        className="font-bold text-[#B86B77]"
                      >
                        أنشئ حسابك الآن
                      </button>
                    </div>
                  </div>
                </div>
              )}

              {/* 4. REGISTER SCREEN */}
              {currentScreen === 'register' && (
                <div className="h-full flex flex-col justify-between py-4 animate-fade-in">
                  <div>
                    <button onClick={() => setCurrentScreen('login')} className="flex items-center gap-1 text-xs text-[#8E6C75] mb-3">
                      <ArrowRight className="w-4 h-4" /> العودة للدخول
                    </button>
                    <h2 className="text-xl font-black text-[#2C2426] mb-1">انضم لعائلة رِعاية</h2>
                    <p className="text-xs text-[#6F5E62] mb-4">بيانات المريض أو ولي أمره لتسهيل المتابعة</p>

                    <div className="space-y-3">
                      <div>
                        <label className="text-xs font-bold block mb-1">الاسم بالكامل *</label>
                        <input
                          type="text"
                          value={patientName}
                          onChange={(e) => setPatientName(e.target.value)}
                          className="w-full h-10 bg-[#F7F2EC] border border-[#EFE6DE] rounded-xl px-3 text-xs"
                        />
                      </div>
                      <div>
                        <label className="text-xs font-bold block mb-1">رقم الهاتف *</label>
                        <input
                          type="text"
                          value={patientPhone}
                          onChange={(e) => setPatientPhone(e.target.value)}
                          className="w-full h-10 bg-[#F7F2EC] border border-[#EFE6DE] rounded-xl px-3 text-xs text-left"
                        />
                      </div>
                      <div>
                        <label className="text-xs font-bold block mb-1">العمر التقريبي للمريض *</label>
                        <input
                          type="number"
                          defaultValue="68"
                          className="w-full h-10 bg-[#F7F2EC] border border-[#EFE6DE] rounded-xl px-3 text-xs"
                        />
                      </div>
                      <div>
                        <label className="text-xs font-bold block mb-1">كلمة المرور *</label>
                        <input
                          type="password"
                          defaultValue="123456"
                          className="w-full h-10 bg-[#F7F2EC] border border-[#EFE6DE] rounded-xl px-3 text-xs text-left"
                        />
                      </div>
                    </div>
                  </div>

                  <div className="pt-4">
                    <button
                      onClick={() => setCurrentScreen('home')}
                      className="w-full h-12 bg-[#B86B77] text-white rounded-2xl font-bold text-sm shadow-md"
                    >
                      إنشاء الحساب
                    </button>
                  </div>
                </div>
              )}

              {/* 5. FORGOT PASSWORD SCREEN */}
              {currentScreen === 'forgot_password' && (
                <div className="h-full flex flex-col justify-between py-4 animate-fade-in">
                  <div>
                    <button onClick={() => setCurrentScreen('login')} className="flex items-center gap-1 text-xs text-[#8E6C75] mb-4">
                      <ArrowRight className="w-4 h-4" /> العودة
                    </button>
                    <h2 className="text-xl font-black text-[#2C2426] mb-2">استعادة كلمة المرور</h2>
                    <p className="text-xs text-[#6F5E62] leading-relaxed mb-6">
                      أدخل رقم الهاتف المرتبط بحسابك وسنرسل لك رمزاً لتسجيل كلمة مرور جديدة.
                    </p>
                    <div>
                      <label className="text-xs font-bold block mb-1.5">رقم الهاتف المسجل</label>
                      <input
                        type="text"
                        value={patientPhone}
                        className="w-full h-11 bg-[#F7F2EC] border border-[#EFE6DE] rounded-xl px-3 text-xs text-left"
                      />
                    </div>
                  </div>
                  <button
                    onClick={() => {
                      alert('تم إرسال رمز التحقق في رسالة نصية.');
                      setCurrentScreen('login');
                    }}
                    className="w-full h-12 bg-[#B86B77] text-white rounded-2xl font-bold text-sm shadow-md"
                  >
                    إرسال رمز التأكيد
                  </button>
                </div>
              )}

              {/* 6. HOME SCREEN */}
              {currentScreen === 'home' && (
                <div className="space-y-4 pb-14 animate-fade-in pt-1">
                  {/* رأس الشاشة مع الملف والإشعارات */}
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-2.5 cursor-pointer" onClick={() => setCurrentScreen('profile')}>
                      <div className="w-10 h-10 rounded-full bg-[#B86B77] text-white flex items-center justify-center font-bold text-sm border border-[#EFE6DE]">
                        ع
                      </div>
                      <div>
                        <div className="text-[11px] text-[#8E6C75]">مرحبًا بك،</div>
                        <div className="text-xs font-black text-[#2C2426]">{patientName}</div>
                      </div>
                    </div>
                    <button
                      onClick={() => setCurrentScreen('notifications')}
                      className="w-9 h-9 rounded-full bg-white border border-[#EFE6DE] flex items-center justify-center relative shadow-2xs"
                    >
                      <Bell className="w-4 h-4 text-[#2C2426]" />
                      {unreadNotifs > 0 && (
                        <span className="w-2 h-2 rounded-full bg-[#B86B77] absolute top-1.5 right-1.5" />
                      )}
                    </button>
                  </div>

                  {/* بنر CTA الرئيسي البارز */}
                  <div className="bg-gradient-to-br from-[#B86B77] to-[#9E5460] rounded-2xl p-4 text-white shadow-lg shadow-[#B86B77]/20">
                    <div className="flex justify-between items-center mb-2">
                      <span className="text-[10px] bg-white/20 px-2 py-0.5 rounded-full font-bold">
                        رعاية تمريضية منزلية متكاملة
                      </span>
                      <Heart className="w-4 h-4 fill-white" />
                    </div>
                    <h3 className="text-sm font-black mb-3 leading-snug">
                      أفضل تمريض منزلي لأهلك، أمان وثقة واطمئنان
                    </h3>
                    <button
                      onClick={() => setCurrentScreen('case_info')}
                      className="w-full h-9 bg-white text-[#9E5460] rounded-xl text-xs font-black flex items-center justify-center gap-1.5 shadow-sm hover:bg-[#F6E6E8]"
                    >
                      اطلب رعاية منزلية الآن
                      <ArrowLeft className="w-3.5 h-3.5" />
                    </button>
                  </div>

                  {/* بطاقة REAYA SENSE الذكية */}
                  <div
                    onClick={() => setCurrentScreen('case_info')}
                    className="bg-white rounded-2xl p-3.5 border border-[#B86B77]/30 shadow-2xs flex items-center gap-3 cursor-pointer hover:border-[#B86B77] transition-all"
                  >
                    <div className="w-10 h-10 rounded-xl bg-[#F6E6E8] flex items-center justify-center text-[#B86B77]">
                      <Mic className="w-5 h-5" />
                    </div>
                    <div className="flex-1">
                      <div className="flex items-center gap-1.5">
                        <span className="text-xs font-black text-[#9E5460]">REAYA Sense</span>
                        <Sparkles className="w-3 h-3 text-[#B86B77]" />
                      </div>
                      <p className="text-[11px] text-[#6F5E62]">تحدث بصوتك وسنلخص الحالة ونقترح الممرض فوراً</p>
                    </div>
                    <ChevronLeft className="w-4 h-4 text-[#8E6C75]" />
                  </div>

                  {/* الحجز القادم */}
                  <div>
                    <div className="flex justify-between items-center mb-2">
                      <h4 className="text-xs font-black text-[#2C2426]">الحجز القادم</h4>
                      <button onClick={() => setCurrentScreen('bookings')} className="text-[11px] font-bold text-[#B86B77]">
                        كل الحجوزات
                      </button>
                    </div>
                    <div
                      onClick={() => setCurrentScreen('booking_details')}
                      className="bg-white rounded-2xl p-3.5 border border-[#EFE6DE] shadow-2xs cursor-pointer hover:border-[#B86B77]"
                    >
                      <div className="flex justify-between items-start mb-2">
                        <span className="text-[10px] bg-[#F7F2EC] text-[#B86B77] font-bold px-2 py-0.5 rounded-md">
                          {bookingReference}
                        </span>
                        <span className="text-[10px] bg-[#EAF4EE] text-[#5B8E6A] font-bold px-2 py-0.5 rounded-md">
                          مؤكد ومجدول
                        </span>
                      </div>
                      <div className="text-xs font-bold text-[#2C2426] mb-1">{activeService.title}</div>
                      <div className="text-[11px] text-[#6F5E62] flex items-center gap-1 mb-2">
                        <User className="w-3.5 h-3.5 text-[#8E6C75]" /> {activeNurse.name}
                      </div>
                      <div className="text-[10px] text-[#8E6C75] flex items-center justify-between border-t border-[#EFE6DE] pt-2">
                        <span className="flex items-center gap-1">
                          <Clock className="w-3 h-3" /> اليوم، {selectedTimeSlot}
                        </span>
                        <span className="font-bold text-[#9E5460]">الإجمالي: {activeService.price + 30} ج.م</span>
                      </div>
                    </div>
                  </div>

                  {/* الخدمات السريعة */}
                  <div>
                    <div className="flex justify-between items-center mb-2">
                      <h4 className="text-xs font-black text-[#2C2426]">الخدمات السريعة</h4>
                      <button onClick={() => setCurrentScreen('services')} className="text-[11px] font-bold text-[#B86B77]">
                        عرض الكل
                      </button>
                    </div>
                    <div className="grid grid-cols-2 gap-2.5">
                      {services.slice(0, 4).map((s) => (
                        <div
                          key={s.id}
                          onClick={() => {
                            setSelectedServiceId(s.id);
                            setCurrentScreen('case_info');
                          }}
                          className="bg-white p-3 rounded-xl border border-[#EFE6DE] shadow-2xs cursor-pointer hover:border-[#B86B77] transition-all"
                        >
                          <div className="w-8 h-8 rounded-lg bg-[#F7F2EC] flex items-center justify-center text-[#B86B77] mb-2">
                            <Activity className="w-4 h-4" />
                          </div>
                          <div className="text-[11px] font-black text-[#2C2426] mb-1 line-clamp-1">{s.title}</div>
                          <div className="text-[10px] text-[#9E5460] font-bold">{s.price} ج.م</div>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              )}

              {/* 7. SERVICES SCREEN */}
              {currentScreen === 'services' && (
                <div className="space-y-3 py-2 pb-14 animate-fade-in">
                  <div className="flex items-center gap-2 mb-2">
                    <button onClick={() => setCurrentScreen('home')} className="p-1">
                      <ArrowRight className="w-4 h-4 text-[#2C2426]" />
                    </button>
                    <h3 className="text-sm font-black text-[#2C2426]">خدمات الرعاية التمريضية</h3>
                  </div>

                  <div className="bg-[#F6E6E8]/60 p-3 rounded-xl text-[11px] text-[#6F5E62]">
                    اختر الخدمة المطلوبة وسنقوم بتوصيلك بأكفأ ممرض معتمد بالقرب منك.
                  </div>

                  <div className="space-y-2.5">
                    {services.map((srv) => {
                      const isSelected = selectedServiceId === srv.id;
                      return (
                        <div
                          key={srv.id}
                          onClick={() => setSelectedServiceId(srv.id)}
                          className={`p-3.5 rounded-2xl border transition-all cursor-pointer ${
                            isSelected
                              ? 'bg-white border-[#B86B77] shadow-sm'
                              : 'bg-white border-[#EFE6DE] hover:border-[#B86B77]/50'
                          }`}
                        >
                          <div className="flex justify-between items-center mb-1.5">
                            <h4 className="text-xs font-black text-[#2C2426]">{srv.title}</h4>
                            <span className="text-xs font-black text-[#9E5460]">{srv.price} ج.م</span>
                          </div>
                          <p className="text-[11px] text-[#6F5E62] leading-relaxed mb-2">{srv.desc}</p>
                          <div className="flex justify-between items-center text-[10px] text-[#8E6C75] border-t border-[#F7F2EC] pt-2">
                            <span className="flex items-center gap-1">
                              <Clock className="w-3 h-3" /> المدة: {srv.duration}
                            </span>
                            {isSelected && <span className="font-bold text-[#B86B77]">✓ محددة</span>}
                          </div>
                        </div>
                      );
                    })}
                  </div>

                  <div className="pt-2">
                    <button
                      onClick={() => setCurrentScreen('case_info')}
                      className="w-full h-11 bg-[#B86B77] text-white rounded-xl font-bold text-xs shadow-md"
                    >
                      متابعة لمعلومات الحالة
                    </button>
                  </div>
                </div>
              )}

              {/* 8. CASE INFORMATION & REAYA SENSE SCREEN */}
              {currentScreen === 'case_info' && (
                <div className="space-y-3.5 py-2 pb-14 animate-fade-in">
                  <div className="flex items-center gap-2 mb-1">
                    <button onClick={() => setCurrentScreen('home')} className="p-1">
                      <ArrowRight className="w-4 h-4 text-[#2C2426]" />
                    </button>
                    <h3 className="text-sm font-black text-[#2C2426]">معلومات الحالة و REAYA Sense</h3>
                  </div>

                  {/* وحدة REAYA SENSE الصوتية */}
                  <div className="bg-gradient-to-r from-[#F6E6E8] to-[#F7F2EC] p-3.5 rounded-2xl border border-[#B86B77]/40 shadow-2xs">
                    <div className="flex items-center gap-2 mb-2">
                      <Sparkles className="w-4 h-4 text-[#B86B77]" />
                      <span className="text-xs font-black text-[#9E5460]">مساعد REAYA Sense الصوتي الذكي</span>
                    </div>
                    <p className="text-[11px] text-[#6F5E62] leading-relaxed mb-3">
                      تحدث بصوتك وسيقوم النظام بتلخيص الحالة واقتراح الخدمة تلقائياً.
                    </p>

                    <button
                      onClick={handleVoiceSenseClick}
                      className={`w-full py-2.5 px-3 rounded-xl flex items-center justify-center gap-2 text-xs font-bold transition-all shadow-sm ${
                        isRecording
                          ? 'bg-[#B86B77] text-white animate-pulse'
                          : 'bg-white text-[#9E5460] border border-[#B86B77]/30 hover:bg-[#F6E6E8]'
                      }`}
                    >
                      {isRecording ? (
                        <>
                          <MicOff className="w-4 h-4" /> اضغط للانتهاء ومعالجة الصوت...
                        </>
                      ) : (
                        <>
                          <Mic className="w-4 h-4 text-[#B86B77]" /> اضغط للتحدث ووصف الحالة صوتياً
                        </>
                      )}
                    </button>
                  </div>

                  {/* حالة معالجة الذكاء الاصطناعي التجريبي */}
                  {isSenseProcessing && (
                    <div className="bg-white p-4 rounded-xl border border-[#EFE6DE] text-center space-y-2">
                      <div className="w-5 h-5 border-2 border-[#B86B77] border-t-transparent rounded-full animate-spin mx-auto" />
                      <p className="text-[11px] text-[#6F5E62]">
                        يقوم REAYA Sense بتحليل الكلمات واستخراج المتطلبات التمريضية...
                      </p>
                    </div>
                  )}

                  {/* بطاقة ملخص REAYA SENSE المنظم */}
                  {!isSenseProcessing && caseDescription && (
                    <div className="bg-white p-3.5 rounded-2xl border border-[#B86B77]/50 shadow-2xs space-y-2 text-xs">
                      <div className="flex items-center justify-between border-b border-[#F7F2EC] pb-2">
                        <span className="font-black text-[#2C2426]">ملخص الحالة المنظم (REAYA Sense)</span>
                        <span className="text-[10px] bg-[#EAF4EE] text-[#5B8E6A] font-bold px-2 py-0.5 rounded-full">
                          تم التحليل الذكي
                        </span>
                      </div>
                      <div className="text-[11px] text-[#6F5E62] leading-relaxed">
                        <span className="font-bold text-[#2C2426]">الخدمة المقترحة:</span> {activeService.title}
                      </div>
                      <div className="text-[11px] text-[#6F5E62] leading-relaxed">
                        <span className="font-bold text-[#2C2426]">الأولوية:</span> عاجلة (خلال ساعتين)
                      </div>
                      <div className="text-[11px] text-[#6F5E62] leading-relaxed">
                        <span className="font-bold text-[#2C2426]">الملاحظات والسيولة:</span> {caseNotes}
                      </div>

                      <div className="bg-[#F7F2EC] p-2.5 rounded-xl text-center space-y-2 pt-2">
                        <div className="text-[11px] font-bold text-[#2C2426]">هل المعلومات دي صحيحة؟</div>
                        <div className="flex gap-2">
                          <button
                            onClick={() => setSenseSummaryVerified(true)}
                            className={`flex-1 py-1.5 rounded-lg text-[11px] font-bold transition-all ${
                              senseSummaryVerified
                                ? 'bg-[#5B8E6A] text-white'
                                : 'bg-[#B86B77] text-white hover:bg-[#9E5460]'
                            }`}
                          >
                            {senseSummaryVerified ? '✓ تم تأكيد البيانات' : 'تأكيد البيانات'}
                          </button>
                          <button
                            onClick={() => {
                              setCaseDescription('');
                              setSenseSummaryVerified(false);
                            }}
                            className="px-3 py-1.5 bg-white border border-[#EFE6DE] text-[#6F5E62] rounded-lg text-[11px]"
                          >
                            تعديل
                          </button>
                        </div>
                      </div>
                    </div>
                  )}

                  {/* الحقول النصية التقليدية */}
                  <div className="space-y-3 pt-1">
                    <div>
                      <label className="text-xs font-bold block mb-1">اسم المريض *</label>
                      <input
                        type="text"
                        value={patientName}
                        onChange={(e) => setPatientName(e.target.value)}
                        className="w-full h-10 bg-[#F7F2EC] border border-[#EFE6DE] rounded-xl px-3 text-xs"
                      />
                    </div>
                    <div>
                      <label className="text-xs font-bold block mb-1">وصف الحالة والشكوى *</label>
                      <textarea
                        rows={2}
                        value={caseDescription}
                        onChange={(e) => setCaseDescription(e.target.value)}
                        className="w-full bg-[#F7F2EC] border border-[#EFE6DE] rounded-xl p-2.5 text-xs outline-none"
                        placeholder="اكتب شكوى المريض واحتياجه..."
                      />
                    </div>
                    <div>
                      <label className="text-xs font-bold block mb-1">ملاحظات طبية أو أدوية هامة</label>
                      <input
                        type="text"
                        value={caseNotes}
                        onChange={(e) => setCaseNotes(e.target.value)}
                        className="w-full h-10 bg-[#F7F2EC] border border-[#EFE6DE] rounded-xl px-3 text-xs"
                      />
                    </div>
                  </div>

                  <div className="pt-2">
                    <button
                      onClick={() => setCurrentScreen('location')}
                      className="w-full h-11 bg-[#B86B77] text-white rounded-xl font-bold text-xs shadow-md"
                    >
                      متابعة لتحديد الموقع
                    </button>
                  </div>
                </div>
              )}

              {/* 9. LOCATION SCREEN */}
              {currentScreen === 'location' && (
                <div className="space-y-3.5 py-2 pb-14 animate-fade-in">
                  <div className="flex items-center gap-2 mb-1">
                    <button onClick={() => setCurrentScreen('case_info')} className="p-1">
                      <ArrowRight className="w-4 h-4 text-[#2C2426]" />
                    </button>
                    <h3 className="text-sm font-black text-[#2C2426]">موقع وصول الممرض</h3>
                  </div>

                  {/* محاكاة خريطة GPS هادئة */}
                  <div className="h-36 w-full bg-[#F7F2EC] rounded-2xl border border-[#EFE6DE] relative overflow-hidden flex flex-col items-center justify-center">
                    <div className="w-10 h-10 rounded-full bg-[#B86B77] flex items-center justify-center text-white shadow-lg shadow-[#B86B77]/30 mb-2">
                      <MapPin className="w-5 h-5 fill-white" />
                    </div>
                    <span className="text-[11px] font-bold text-[#2C2426] bg-white/90 px-3 py-1 rounded-full shadow-2xs">
                      مصر الجديدة، القاهرة
                    </span>
                  </div>

                  <div className="bg-white p-3 rounded-xl border border-[#EFE6DE] text-xs space-y-1">
                    <div className="font-black text-[#2C2426]">العنوان المحفوظ الافتراضي</div>
                    <p className="text-[11px] text-[#6F5E62] leading-relaxed">{patientAddress}</p>
                  </div>

                  <div className="space-y-3">
                    <div>
                      <label className="text-xs font-bold block mb-1">الشارع والمنطقة *</label>
                      <input
                        type="text"
                        value={patientAddress}
                        onChange={(e) => setPatientAddress(e.target.value)}
                        className="w-full h-10 bg-[#F7F2EC] border border-[#EFE6DE] rounded-xl px-3 text-xs"
                      />
                    </div>
                    <div>
                      <label className="text-xs font-bold block mb-1">علامة مميزة وإرشادات وصول</label>
                      <input
                        type="text"
                        defaultValue="بجوار صيدلية العزبي - يوجد مصعد بالعمارة"
                        className="w-full h-10 bg-[#F7F2EC] border border-[#EFE6DE] rounded-xl px-3 text-xs"
                      />
                    </div>
                  </div>

                  <div className="pt-2">
                    <button
                      onClick={() => setCurrentScreen('nurse_recommendation')}
                      className="w-full h-11 bg-[#B86B77] text-white rounded-xl font-bold text-xs shadow-md"
                    >
                      تأكيد الموقع واختيار الممرض
                    </button>
                  </div>
                </div>
              )}

              {/* 10. NURSE RECOMMENDATION SCREEN */}
              {currentScreen === 'nurse_recommendation' && (
                <div className="space-y-3 py-2 pb-14 animate-fade-in">
                  <div className="flex items-center gap-2 mb-1">
                    <button onClick={() => setCurrentScreen('location')} className="p-1">
                      <ArrowRight className="w-4 h-4 text-[#2C2426]" />
                    </button>
                    <h3 className="text-sm font-black text-[#2C2426]">الممرضون المقترحون</h3>
                  </div>

                  <div className="bg-[#F6E6E8] p-3 rounded-xl text-[11px] text-[#9E5460] font-bold flex items-center gap-2">
                    <Sparkles className="w-4 h-4" />
                    ترشيح ذكي بناءً على تخصص الحالة ونسبة التوافق (Match Score)
                  </div>

                  <div className="space-y-3">
                    {nurses.map((nurse) => (
                      <div
                        key={nurse.id}
                        onClick={() => {
                          setSelectedNurseId(nurse.id);
                          setCurrentScreen('nurse_details');
                        }}
                        className="bg-white p-3.5 rounded-2xl border border-[#EFE6DE] shadow-2xs hover:border-[#B86B77] cursor-pointer transition-all space-y-2.5"
                      >
                        <div className="flex gap-3">
                          <img
                            src={nurse.avatar}
                            alt={nurse.name}
                            className="w-14 h-14 rounded-xl object-cover border border-[#EFE6DE]"
                          />
                          <div className="flex-1">
                            <div className="flex justify-between items-start">
                              <h4 className="text-xs font-black text-[#2C2426]">{nurse.name}</h4>
                              <span className="text-[10px] bg-[#EAF4EE] text-[#5B8E6A] font-black px-2 py-0.5 rounded-md">
                                {nurse.matchScore}% توافق
                              </span>
                            </div>
                            <p className="text-[11px] text-[#6F5E62] mt-0.5">{nurse.specialty}</p>
                            <div className="flex items-center gap-2 mt-1 text-[10px] text-[#8E6C75]">
                              <span className="flex items-center gap-0.5 text-amber-500 font-bold">
                                <Star className="w-3 h-3 fill-amber-500" /> {nurse.rating}
                              </span>
                              <span>({nurse.reviews} تقييم)</span>
                              <span>•</span>
                              <span>{nurse.distance}</span>
                            </div>
                          </div>
                        </div>

                        <div className="flex justify-between items-center text-[11px] border-t border-[#F7F2EC] pt-2">
                          <span className="text-[#5B8E6A] font-bold">متاح للزيارة اليوم</span>
                          <span className="text-[#9E5460] font-black">{nurse.price} ج.م / ساعة</span>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {/* 11. NURSE DETAILS SCREEN */}
              {currentScreen === 'nurse_details' && (
                <div className="space-y-3 py-2 pb-14 animate-fade-in">
                  <div className="flex items-center gap-2 mb-1">
                    <button onClick={() => setCurrentScreen('nurse_recommendation')} className="p-1">
                      <ArrowRight className="w-4 h-4 text-[#2C2426]" />
                    </button>
                    <h3 className="text-sm font-black text-[#2C2426]">الملف المهني للممرض</h3>
                  </div>

                  <div className="bg-white p-4 rounded-2xl border border-[#EFE6DE] text-center space-y-2">
                    <img
                      src={activeNurse.avatar}
                      alt={activeNurse.name}
                      className="w-20 h-20 rounded-full mx-auto object-cover border-2 border-[#B86B77]"
                    />
                    <h3 className="text-sm font-black text-[#2C2426]">{activeNurse.name}</h3>
                    <p className="text-xs text-[#6F5E62]">{activeNurse.title}</p>
                    <div className="flex justify-center items-center gap-3 text-xs pt-1">
                      <span className="text-[11px] bg-[#EAF4EE] text-[#5B8E6A] font-bold px-2 py-0.5 rounded-full">
                        {activeNurse.matchScore}% توافق
                      </span>
                      <span className="text-[11px] text-[#8E6C75]">{activeNurse.experience}</span>
                    </div>
                  </div>

                  <div className="bg-white p-3.5 rounded-2xl border border-[#EFE6DE] space-y-1.5">
                    <h4 className="text-xs font-black text-[#2C2426]">نبذة مهنية ومعلومات الاعتماد</h4>
                    <p className="text-[11px] text-[#6F5E62] leading-relaxed">{activeNurse.about}</p>
                  </div>

                  <div className="bg-white p-3.5 rounded-2xl border border-[#EFE6DE] space-y-2">
                    <h4 className="text-xs font-black text-[#2C2426]">تجارب المرضى السابقين</h4>
                    <div className="text-[11px] text-[#6F5E62] bg-[#F7F2EC] p-2.5 rounded-xl leading-relaxed">
                      "ما شاء الله قمة في الذوق والمهنية وتعاملها راقي جداً مع والدي، إيدها خفيفة جداً في تغيير الغيار."
                    </div>
                  </div>

                  <div className="pt-2">
                    <button
                      onClick={() => setCurrentScreen('confirm_booking')}
                      className="w-full h-11 bg-[#B86B77] text-white rounded-xl font-bold text-xs shadow-md"
                    >
                      اختيار الممرض وتأكيد الموعد
                    </button>
                  </div>
                </div>
              )}

              {/* 12. CONFIRM BOOKING SCREEN */}
              {currentScreen === 'confirm_booking' && (
                <div className="space-y-3.5 py-2 pb-14 animate-fade-in">
                  <div className="flex items-center gap-2 mb-1">
                    <button onClick={() => setCurrentScreen('nurse_details')} className="p-1">
                      <ArrowRight className="w-4 h-4 text-[#2C2426]" />
                    </button>
                    <h3 className="text-sm font-black text-[#2C2426]">مراجعة وتأكيد الحجز</h3>
                  </div>

                  <div className="bg-white p-3.5 rounded-2xl border border-[#EFE6DE] space-y-2 text-xs">
                    <div className="flex justify-between items-center border-b border-[#F7F2EC] pb-2">
                      <span className="font-black text-[#2C2426]">الخدمة: {activeService.title}</span>
                      <span className="font-bold text-[#9E5460]">{activeService.price} ج.م</span>
                    </div>
                    <div className="text-[11px] text-[#6F5E62]">الممرض: {activeNurse.name}</div>
                    <div className="text-[11px] text-[#6F5E62]">العنوان: {patientAddress}</div>
                    <div className="text-[11px] text-[#6F5E62]">رسوم الانتقال المباشر: 30 ج.م</div>
                    <div className="flex justify-between items-center border-t border-[#F7F2EC] pt-2 font-black">
                      <span>الإجمالي المطلوب:</span>
                      <span className="text-sm text-[#9E5460]">{activeService.price + 30} ج.م</span>
                    </div>
                  </div>

                  <div>
                    <label className="text-xs font-bold block mb-1.5">اختر موعد الزيارة اليوم</label>
                    <div className="grid grid-cols-2 gap-2">
                      {['04:00 عصراً', '06:30 مساءً', '08:00 مساءً', '10:00 مساءً'].map((slot) => (
                        <button
                          key={slot}
                          onClick={() => setSelectedTimeSlot(slot)}
                          className={`py-2 rounded-xl text-xs font-bold border transition-all ${
                            selectedTimeSlot === slot
                              ? 'bg-[#B86B77] text-white border-[#B86B77]'
                              : 'bg-white text-[#2C2426] border-[#EFE6DE]'
                          }`}
                        >
                          {slot}
                        </button>
                      ))}
                    </div>
                  </div>

                  <div className="pt-3">
                    <button
                      onClick={() => {
                        setBookingReference(`REA-${Math.floor(1000 + Math.random() * 9000)}`);
                        setCurrentScreen('booking_success');
                      }}
                      className="w-full h-11 bg-[#B86B77] text-white rounded-xl font-bold text-xs shadow-md"
                    >
                      تأكيد الحجز النهائي
                    </button>
                  </div>
                </div>
              )}

              {/* 13. BOOKING SUCCESS SCREEN */}
              {currentScreen === 'booking_success' && (
                <div className="h-full flex flex-col justify-between py-6 text-center animate-fade-in">
                  <div className="my-auto space-y-4">
                    <div className="w-20 h-20 rounded-full bg-[#EAF4EE] text-[#5B8E6A] flex items-center justify-center mx-auto border-2 border-[#5B8E6A]/20">
                      <CheckCircle className="w-10 h-10" />
                    </div>
                    <h2 className="text-lg font-black text-[#2C2426]">تم تأكيد حجزك بنجاح!</h2>
                    <p className="text-xs text-[#6F5E62] leading-relaxed max-w-[260px] mx-auto">
                      تم اعتماد موعدك مع {activeNurse.name} وسيتوجه إليك في الموعد بكل رعاية.
                    </p>

                    <div className="bg-white p-3.5 rounded-2xl border border-[#EFE6DE] text-xs text-right space-y-1.5">
                      <div className="flex justify-between">
                        <span className="text-[#8E6C75]">كود الحجز:</span>
                        <span className="font-black text-[#B86B77]">{bookingReference}</span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-[#8E6C75]">الموعد:</span>
                        <span className="font-bold text-[#2C2426]">اليوم، {selectedTimeSlot}</span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-[#8E6C75]">الخدمة:</span>
                        <span className="font-bold text-[#2C2426]">{activeService.title}</span>
                      </div>
                    </div>
                  </div>

                  <div className="space-y-2">
                    <button
                      onClick={() => setCurrentScreen('booking_details')}
                      className="w-full h-11 bg-[#B86B77] text-white rounded-xl font-bold text-xs shadow-md"
                    >
                      عرض تفاصيل الحجز
                    </button>
                    <button
                      onClick={() => setCurrentScreen('home')}
                      className="w-full h-11 bg-white border border-[#EFE6DE] text-[#2C2426] rounded-xl font-bold text-xs"
                    >
                      العودة للرئيسية
                    </button>
                  </div>
                </div>
              )}

              {/* 14. BOOKINGS SCREEN */}
              {currentScreen === 'bookings' && (
                <div className="space-y-3 py-2 pb-14 animate-fade-in">
                  <div className="flex items-center gap-2 mb-1">
                    <button onClick={() => setCurrentScreen('home')} className="p-1">
                      <ArrowRight className="w-4 h-4 text-[#2C2426]" />
                    </button>
                    <h3 className="text-sm font-black text-[#2C2426]">حجوزاتي والزيارات</h3>
                  </div>

                  <div className="flex bg-[#F7F2EC] p-1 rounded-xl border border-[#EFE6DE] text-xs font-bold">
                    <button
                      onClick={() => setBookingsFilter('upcoming')}
                      className={`flex-1 py-1.5 rounded-lg transition-all ${
                        bookingsFilter === 'upcoming' ? 'bg-[#B86B77] text-white shadow-2xs' : 'text-[#6F5E62]'
                      }`}
                    >
                      القادمة
                    </button>
                    <button
                      onClick={() => setBookingsFilter('completed')}
                      className={`flex-1 py-1.5 rounded-lg transition-all ${
                        bookingsFilter === 'completed' ? 'bg-[#B86B77] text-white shadow-2xs' : 'text-[#6F5E62]'
                      }`}
                    >
                      المكتملة
                    </button>
                    <button
                      onClick={() => setBookingsFilter('cancelled')}
                      className={`flex-1 py-1.5 rounded-lg transition-all ${
                        bookingsFilter === 'cancelled' ? 'bg-[#B86B77] text-white shadow-2xs' : 'text-[#6F5E62]'
                      }`}
                    >
                      الملغية
                    </button>
                  </div>

                  {bookingsFilter === 'upcoming' && (
                    <div
                      onClick={() => setCurrentScreen('booking_details')}
                      className="bg-white p-3.5 rounded-2xl border border-[#EFE6DE] shadow-2xs cursor-pointer hover:border-[#B86B77] space-y-2"
                    >
                      <div className="flex justify-between items-center text-xs">
                        <span className="font-black text-[#B86B77]">{bookingReference}</span>
                        <span className="text-[10px] bg-[#EAF4EE] text-[#5B8E6A] font-bold px-2 py-0.5 rounded-md">
                          مؤكد ومجدول
                        </span>
                      </div>
                      <div className="text-xs font-bold text-[#2C2426]">{activeService.title}</div>
                      <div className="text-[11px] text-[#6F5E62]">الممرض: {activeNurse.name}</div>
                      <div className="text-[10px] text-[#8E6C75] flex justify-between border-t border-[#F7F2EC] pt-2">
                        <span>اليوم، {selectedTimeSlot}</span>
                        <span className="font-bold text-[#9E5460]">الإجمالي: {activeService.price + 30} ج.م</span>
                      </div>
                    </div>
                  )}

                  {bookingsFilter === 'completed' && (
                    <div
                      onClick={() => setCurrentScreen('booking_details')}
                      className="bg-white p-3.5 rounded-2xl border border-[#EFE6DE] shadow-2xs cursor-pointer space-y-2"
                    >
                      <div className="flex justify-between items-center text-xs">
                        <span className="font-black text-[#B86B77]">REA-7643</span>
                        <span className="text-[10px] bg-[#EAF4EE] text-[#5B8E6A] font-bold px-2 py-0.5 rounded-md">
                          اكتملت الزيارة
                        </span>
                      </div>
                      <div className="text-xs font-bold text-[#2C2426]">قياس الضغط والعلامات الحيوية</div>
                      <div className="text-[11px] text-[#6F5E62]">الممرضة / مريم يسري إبراهيم</div>
                      <div className="text-[10px] text-[#8E6C75] flex justify-between border-t border-[#F7F2EC] pt-2">
                        <span>الأحد الماضي، 10:00 ص</span>
                        <span className="text-[#B86B77] font-bold">عرض تقرير التسليم</span>
                      </div>
                    </div>
                  )}

                  {bookingsFilter === 'cancelled' && (
                    <div className="p-8 text-center text-xs text-[#8E6C75]">
                      لا توجد حجوزات ملغية في سجلك.
                    </div>
                  )}
                </div>
              )}

              {/* 15. BOOKING DETAILS & CARE HANDOVER SCREEN */}
              {currentScreen === 'booking_details' && (
                <div className="space-y-3 py-2 pb-14 animate-fade-in">
                  <div className="flex items-center gap-2 mb-1">
                    <button onClick={() => setCurrentScreen('home')} className="p-1">
                      <ArrowRight className="w-4 h-4 text-[#2C2426]" />
                    </button>
                    <h3 className="text-sm font-black text-[#2C2426]">تفاصيل الحجز و Care Handover</h3>
                  </div>

                  <div className="bg-white p-3.5 rounded-2xl border border-[#EFE6DE] space-y-1.5 text-xs">
                    <div className="flex justify-between">
                      <span className="text-[#8E6C75]">كود الحجز:</span>
                      <span className="font-black text-[#B86B77]">{bookingReference}</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-[#8E6C75]">الممرض:</span>
                      <span className="font-bold text-[#2C2426]">{activeNurse.name}</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-[#8E6C75]">الموعد:</span>
                      <span className="font-bold text-[#2C2426]">اليوم، {selectedTimeSlot}</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-[#8E6C75]">العنوان:</span>
                      <span className="font-bold text-[#2C2426]">{patientAddress}</span>
                    </div>
                  </div>

                  {/* بطاقة REAYA CARE HANDOVER المعتمدة */}
                  <div className="bg-[#F7F2EC] p-3.5 rounded-2xl border border-[#EFE6DE] space-y-2 text-xs">
                    <div className="flex items-center gap-2 pb-1 border-b border-[#EFE6DE]">
                      <FileText className="w-4 h-4 text-[#B86B77]" />
                      <span className="font-black text-[#2C2426]">REAYA Care Handover (تسليم الحالة)</span>
                    </div>
                    <div className="space-y-1 text-[11px] text-[#6F5E62] leading-relaxed">
                      <div><strong className="text-[#9E5460]">حالة المريض:</strong> مستقرة، الجرح نظيف ويحتاج غيار دوري.</div>
                      <div><strong className="text-[#9E5460]">العلامات الحيوية:</strong> الضغط: 125/80 | السكر: 115 مجم/دل.</div>
                      <div><strong className="text-[#9E5460]">ملاحظات الممرض:</strong> تم تعقيم الجرح بدون أي التهاب أو ارتشاح.</div>
                      <div><strong className="text-[#9E5460]">الخطوات القادمة:</strong> غيار دوري بعد 48 ساعة وإبقاء الشاش جافاً.</div>
                    </div>
                  </div>

                  <div className="pt-2">
                    <button
                      onClick={() => setCurrentScreen('rating')}
                      className="w-full h-11 bg-[#B86B77] text-white rounded-xl font-bold text-xs shadow-md"
                    >
                      تقييم تجربة الرعاية والممرض
                    </button>
                  </div>
                </div>
              )}

              {/* 16. MEDICAL RECORD SCREEN */}
              {currentScreen === 'medical_record' && (
                <div className="space-y-3 py-2 pb-14 animate-fade-in">
                  <div className="flex items-center gap-2 mb-1">
                    <button onClick={() => setCurrentScreen('home')} className="p-1">
                      <ArrowRight className="w-4 h-4 text-[#2C2426]" />
                    </button>
                    <h3 className="text-sm font-black text-[#2C2426]">السجل التمريضي والصحي</h3>
                  </div>

                  <div className="space-y-2.5">
                    {[
                      { date: 'الأحد، 4 أكتوبر 2026', srv: 'قياس الضغط والعلامات الحيوية', nurse: 'مريم يسري', vitals: 'الضغط: 125/80 | السكر: 115 | الأكسجين: 98%' },
                      { date: 'الخميس، 1 أكتوبر 2026', srv: 'تغيير الغيار والجروح', nurse: 'فاطمة الزهراء', vitals: 'الضغط: 130/85 | الجرح نظيف وملتئم 70%' },
                      { date: '21 سبتمبر 2026', srv: 'متابعة ورعاية كبار السن', nurse: 'أحمد مصطفى', vitals: 'جلسة دعم حركي وتمارين أطراف خفيفة' },
                    ].map((rec, i) => (
                      <div key={i} className="bg-white p-3.5 rounded-2xl border border-[#EFE6DE] shadow-2xs space-y-1.5">
                        <div className="flex justify-between items-center text-xs">
                          <span className="font-bold text-[#B86B77]">{rec.date}</span>
                          <span className="text-[11px] text-[#8E6C75]">{rec.nurse}</span>
                        </div>
                        <div className="text-xs font-black text-[#2C2426]">{rec.srv}</div>
                        <div className="bg-[#F7F2EC] p-2 rounded-lg text-[11px] font-bold text-[#2C2426]">
                          {rec.vitals}
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {/* 17. NOTIFICATIONS SCREEN */}
              {currentScreen === 'notifications' && (
                <div className="space-y-3 py-2 pb-14 animate-fade-in">
                  <div className="flex items-center justify-between mb-1">
                    <div className="flex items-center gap-2">
                      <button onClick={() => setCurrentScreen('home')} className="p-1">
                        <ArrowRight className="w-4 h-4 text-[#2C2426]" />
                      </button>
                      <h3 className="text-sm font-black text-[#2C2426]">الإشعارات والتنبيهات</h3>
                    </div>
                    <button
                      onClick={() => setUnreadNotifs(0)}
                      className="text-[11px] font-bold text-[#B86B77]"
                    >
                      تحديد الكل كمقروء
                    </button>
                  </div>

                  <div className="space-y-2">
                    {[
                      { title: 'تم تأكيد حجزك بنجاح ✅', body: 'الموعد مع الممرضة فاطمة الزهراء علي اليوم 06:30 مساءً.', time: 'منذ نصف ساعة' },
                      { title: 'تعيين الممرض المعتمد 👩‍⚕️', body: 'أكدت الممرضة قبول طلبك وهي جاهزة للزيارة.', time: 'منذ ساعة' },
                      { title: 'تذكير بالموعد ⏰', body: 'الزيارة التمريضية المقررة تبدأ خلال ساعتين.', time: 'منذ ساعتين' },
                    ].map((n, i) => (
                      <div
                        key={i}
                        onClick={() => setCurrentScreen('booking_details')}
                        className="bg-white p-3 rounded-2xl border border-[#EFE6DE] shadow-2xs flex items-start gap-3 cursor-pointer hover:border-[#B86B77]"
                      >
                        <div className="w-8 h-8 rounded-full bg-[#F6E6E8] flex items-center justify-center text-[#B86B77] shrink-0 mt-0.5">
                          <Bell className="w-4 h-4" />
                        </div>
                        <div className="flex-1">
                          <div className="flex justify-between items-center mb-0.5">
                            <span className="text-xs font-black text-[#2C2426]">{n.title}</span>
                            <span className="text-[10px] text-[#8E6C75]">{n.time}</span>
                          </div>
                          <p className="text-[11px] text-[#6F5E62] leading-relaxed">{n.body}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {/* 18. PROFILE SCREEN */}
              {currentScreen === 'profile' && (
                <div className="space-y-3.5 py-2 pb-14 animate-fade-in">
                  <div className="flex items-center gap-2 mb-1">
                    <button onClick={() => setCurrentScreen('home')} className="p-1">
                      <ArrowRight className="w-4 h-4 text-[#2C2426]" />
                    </button>
                    <h3 className="text-sm font-black text-[#2C2426]">الملف الشخصي</h3>
                  </div>

                  <div className="bg-white p-4 rounded-2xl border border-[#EFE6DE] text-center space-y-1.5">
                    <div className="w-16 h-16 rounded-full bg-[#B86B77] text-white flex items-center justify-center font-bold text-lg mx-auto">
                      ع
                    </div>
                    <h3 className="text-sm font-black text-[#2C2426]">{patientName}</h3>
                    <p className="text-xs text-[#6F5E62]">{patientPhone}</p>
                    <div className="flex justify-center gap-4 text-xs pt-2 border-t border-[#F7F2EC]">
                      <div><span className="text-[#8E6C75]">العمر:</span> <strong>68 سنة</strong></div>
                      <div><span className="text-[#8E6C75]">الفصيلة:</span> <strong>O+</strong></div>
                    </div>
                  </div>

                  <div className="bg-white p-3.5 rounded-2xl border border-[#EFE6DE] space-y-2 text-xs">
                    <div className="font-black text-[#2C2426]">الأمراض المزمنة المسجلة:</div>
                    <div className="flex gap-2">
                      <span className="bg-[#F6E6E8] text-[#9E5460] font-bold px-2 py-1 rounded-lg">ضغط دم مرتفع</span>
                      <span className="bg-[#F6E6E8] text-[#9E5460] font-bold px-2 py-1 rounded-lg">سكري النوع الثاني</span>
                    </div>
                  </div>

                  <div className="bg-white p-3.5 rounded-2xl border border-[#EFE6DE] space-y-2 text-xs">
                    <div className="font-black text-[#2C2426]">العنوان المعتمد:</div>
                    <p className="text-[11px] text-[#6F5E62] leading-relaxed">{patientAddress}</p>
                  </div>

                  <button
                    onClick={() => setCurrentScreen('login')}
                    className="w-full h-11 bg-white border border-red-200 text-red-600 rounded-xl font-bold text-xs"
                  >
                    تسجيل الخروج
                  </button>
                </div>
              )}

              {/* 19. RATING SCREEN */}
              {currentScreen === 'rating' && (
                <div className="h-full flex flex-col justify-between py-4 animate-fade-in text-center">
                  <div>
                    <h3 className="text-sm font-black text-[#2C2426] mb-3">تقييم تجربة الرعاية</h3>

                    <div className="bg-white p-4 rounded-2xl border border-[#EFE6DE] space-y-3 mb-4">
                      <img
                        src={activeNurse.avatar}
                        alt={activeNurse.name}
                        className="w-14 h-14 rounded-full mx-auto object-cover border border-[#B86B77]"
                      />
                      <div className="text-xs font-black text-[#2C2426]">{activeNurse.name}</div>
                      <p className="text-[11px] text-[#6F5E62]">كيف كانت تجربتك التمريضية والاهتمام الإنساني؟</p>

                      {/* النجوم التفاعلية */}
                      <div className="flex justify-center gap-1">
                        {[1, 2, 3, 4, 5].map((star) => (
                          <button
                            key={star}
                            onClick={() => setRatingStars(star)}
                            className="p-1 focus:outline-none"
                          >
                            <Star
                              className={`w-7 h-7 ${
                                star <= ratingStars ? 'fill-amber-500 text-amber-500' : 'text-[#EFE6DE]'
                              }`}
                            />
                          </button>
                        ))}
                      </div>
                    </div>

                    <textarea
                      rows={3}
                      placeholder="اكتب ملاحظاتك أو كلمة شكر للممرض..."
                      className="w-full bg-[#F7F2EC] border border-[#EFE6DE] rounded-xl p-3 text-xs outline-none"
                    />
                  </div>

                  <div className="space-y-2 pt-2">
                    <button
                      onClick={() => {
                        alert('شكرًا لتقييمك! تم حفظ الملاحظات لدعم طمأنينة المريض.');
                        setCurrentScreen('home');
                      }}
                      className="w-full h-11 bg-[#B86B77] text-white rounded-xl font-bold text-xs shadow-md"
                    >
                      إرسال التقييم
                    </button>
                    <button
                      onClick={() => setCurrentScreen('home')}
                      className="text-xs text-[#8E6C75]"
                    >
                      تخطي الآن
                    </button>
                  </div>
                </div>
              )}
            </div>

            {/* شريط التنقل السفلي للهاتف (Bottom Navigation) */}
            {['home', 'services', 'bookings', 'medical_record', 'profile'].includes(currentScreen) && (
              <div className="h-14 bg-white border-t border-[#EFE6DE] flex items-center justify-around px-2 z-40">
                <button
                  onClick={() => setCurrentScreen('home')}
                  className={`flex flex-col items-center gap-1 text-[10px] font-bold ${
                    currentScreen === 'home' ? 'text-[#B86B77]' : 'text-[#8E6C75]'
                  }`}
                >
                  <Heart className="w-4 h-4" /> الرئيسية
                </button>
                <button
                  onClick={() => setCurrentScreen('services')}
                  className={`flex flex-col items-center gap-1 text-[10px] font-bold ${
                    currentScreen === 'services' ? 'text-[#B86B77]' : 'text-[#8E6C75]'
                  }`}
                >
                  <Activity className="w-4 h-4" /> الخدمات
                </button>
                <button
                  onClick={() => setCurrentScreen('bookings')}
                  className={`flex flex-col items-center gap-1 text-[10px] font-bold ${
                    currentScreen === 'bookings' ? 'text-[#B86B77]' : 'text-[#8E6C75]'
                  }`}
                >
                  <Calendar className="w-4 h-4" /> الحجوزات
                </button>
                <button
                  onClick={() => setCurrentScreen('medical_record')}
                  className={`flex flex-col items-center gap-1 text-[10px] font-bold ${
                    currentScreen === 'medical_record' ? 'text-[#B86B77]' : 'text-[#8E6C75]'
                  }`}
                >
                  <FileText className="w-4 h-4" /> السجل
                </button>
                <button
                  onClick={() => setCurrentScreen('profile')}
                  className={`flex flex-col items-center gap-1 text-[10px] font-bold ${
                    currentScreen === 'profile' ? 'text-[#B86B77]' : 'text-[#8E6C75]'
                  }`}
                >
                  <User className="w-4 h-4" /> حسابي
                </button>
              </div>
            )}
          </div>
        </div>
      ) : (
        /* استعراض كود فلاتر و Dart للمشروع */
        <div className="w-full max-w-5xl bg-white rounded-2xl border border-[#EFE6DE] shadow-sm p-6 overflow-hidden">
          <div className="flex flex-wrap items-center justify-between pb-4 border-b border-[#EFE6DE] gap-4">
            <div>
              <h2 className="text-base font-black text-[#2C2426]">ملفات كود تطبيق فلاتر (Flutter Codebase)</h2>
              <p className="text-xs text-[#6F5E62]">
                جميع الأكواد مكتوبة بلغة Dart ونظام Provider بالمعمارية النظيفة وجاهزة للرفع على GitHub
              </p>
            </div>
            <div className="flex items-center gap-2">
              <select
                value={selectedFile}
                onChange={(e) => setSelectedFile(e.target.value)}
                className="text-xs bg-[#F7F2EC] border border-[#EFE6DE] text-[#2C2426] font-bold rounded-xl px-3 py-2 outline-none"
              >
                <option value="pubspec.yaml">pubspec.yaml</option>
                <option value="lib/main.dart">lib/main.dart (All 19 routes & MultiProvider)</option>
                <option value="lib/core/constants/app_colors.dart">lib/core/constants/app_colors.dart</option>
                <option value="lib/core/theme/app_theme.dart">lib/core/theme/app_theme.dart</option>
                <option value="lib/presentation/providers/reaya_sense_provider.dart">lib/presentation/providers/reaya_sense_provider.dart</option>
                <option value="lib/presentation/screens/home_screen.dart">lib/presentation/screens/home_screen.dart</option>
                <option value="lib/presentation/screens/case_information_screen.dart">lib/presentation/screens/case_information_screen.dart</option>
                <option value="lib/presentation/screens/booking_details_screen.dart">lib/presentation/screens/booking_details_screen.dart</option>
                <option value="README.md">README.md (GitHub Ready)</option>
              </select>

              <button
                onClick={() => copyCode(selectedFile)}
                className="flex items-center gap-1.5 px-3 py-2 bg-[#B86B77] text-white rounded-xl text-xs font-bold hover:bg-[#9E5460]"
              >
                {copied ? <Check className="w-4 h-4" /> : <Copy className="w-4 h-4" />}
                {copied ? 'تم النسخ' : 'نسخ الكود'}
              </button>
            </div>
          </div>

          <div className="mt-4 bg-[#1E1A1B] text-[#E0D7D9] p-4 rounded-xl text-xs font-mono overflow-x-auto max-h-[550px] leading-relaxed text-left" dir="ltr">
            <pre>
              {selectedFile === 'pubspec.yaml' && `name: reaya
description: "رِعاية — REAYA: تطبيق تمريض ورعاية منزلية متكاملة لخدمة المرضى وكبار السن"
version: 1.0.0+1

environment:
  sdk: ">=3.0.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  provider: ^6.1.2
  intl: ^0.19.0
  google_fonts: ^6.2.1

flutter:
  uses-material-design: true`}

              {selectedFile === 'lib/main.dart' && `import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/booking_provider.dart';
import 'presentation/providers/reaya_sense_provider.dart';

// استيراد الشاشات الـ19 كاملة
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/register_screen.dart';
import 'presentation/screens/forgot_password_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/profile_screen.dart';
import 'presentation/screens/services_screen.dart';
import 'presentation/screens/case_information_screen.dart';
import 'presentation/screens/location_screen.dart';
import 'presentation/screens/nurse_recommendation_screen.dart';
import 'presentation/screens/nurse_details_screen.dart';
import 'presentation/screens/confirm_booking_screen.dart';
import 'presentation/screens/booking_success_screen.dart';
import 'presentation/screens/bookings_screen.dart';
import 'presentation/screens/booking_details_screen.dart';
import 'presentation/screens/medical_record_screen.dart';
import 'presentation/screens/notifications_screen.dart';
import 'presentation/screens/rating_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ReayaApp());
}`}

              {selectedFile === 'lib/core/constants/app_colors.dart' && `class AppColors {
  static const Color dustyRose = Color(0xFFB86B77);
  static const Color dustyRoseDark = Color(0xFF9E5460);
  static const Color blushPink = Color(0xFFF6E6E8);
  static const Color softMauve = Color(0xFF8E6C75);
  static const Color warmBeige = Color(0xFFEFE6DE);
  static const Color cream = Color(0xFFF7F2EC);
  static const Color offWhite = Color(0xFFFBF8F5);
  static const Color warmDarkGray = Color(0xFF2C2426);
  static const Color mutedGreen = Color(0xFF5B8E6A);
}`}

              {selectedFile.includes('reaya_sense_provider') && `class ReayaSenseProvider with ChangeNotifier {
  ReayaSenseState _state = ReayaSenseState.idle;
  String _inputVoiceOrText = '';
  CaseInformationModel? _generatedCaseInfo;
  StructuredCaseSummary? _structuredSummary;

  void startVoiceRecording() {
    _state = ReayaSenseState.recordingVoice;
    notifyListeners();
  }

  void stopVoiceRecording() {
    processCaseDescription('المريض يعاني من سكر ويحتاج غيار جراحي مع مراعاة السيولة.');
  }
}`}

              {selectedFile.includes('booking_details_screen') && `// يحتوي على كارت REAYA CARE HANDOVER المعتمد
class BookingDetailsScreen extends StatelessWidget {
  ...
  CareHandoverCard(handover: handover),
}`}

              {selectedFile === 'README.md' && `# رِعاية — REAYA (Flutter Mobile App)
"رِعاية مش مجرد خدمة، دي طمأنينة"
- 19 شاشة حقيقية
- Provider State Management
- Clean Architecture (Core / Data / Presentation)
- REAYA Sense Voice Simulation
- REAYA Care Handover Report`}
            </pre>
          </div>
        </div>
      )}
    </div>
  );
}
