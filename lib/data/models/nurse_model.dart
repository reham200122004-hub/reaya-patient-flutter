class NurseModel {
  final String id;
  final String name;
  final String title;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final String experience;
  final String specialty;
  final String distance;
  final bool isAvailable;
  final int matchScore; // Mock Match Score percentage (e.g. 96%)
  final String about;
  final List<String> providedServices;
  final double pricePerHour;
  final List<String> reviews;

  const NurseModel({
    required this.id,
    required this.name,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    required this.experience,
    required this.specialty,
    required this.distance,
    required this.isAvailable,
    required this.matchScore,
    required this.about,
    required this.providedServices,
    required this.pricePerHour,
    required this.reviews,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'title': title,
    'imageUrl': imageUrl,
    'rating': rating,
    'reviewsCount': reviewsCount,
    'experience': experience,
    'specialty': specialty,
    'distance': distance,
    'isAvailable': isAvailable,
    'matchScore': matchScore,
    'about': about,
    'providedServices': providedServices,
    'pricePerHour': pricePerHour,
    'reviews': reviews,
  };
}
