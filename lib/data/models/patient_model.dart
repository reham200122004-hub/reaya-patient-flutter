class PatientModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String address;
  final int age;
  final String gender;
  final String bloodType;
  final List<String> chronicDiseases;

  const PatientModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.age,
    required this.gender,
    required this.bloodType,
    required this.chronicDiseases,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'address': address,
    'age': age,
    'gender': gender,
    'bloodType': bloodType,
    'chronicDiseases': chronicDiseases,
  };

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
    id: json['id'] as String,
    name: json['name'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    address: json['address'] as String,
    age: json['age'] as int,
    gender: json['gender'] as String,
    bloodType: json['bloodType'] as String,
    chronicDiseases: List<String>.from(json['chronicDiseases'] ?? []),
  );
}
