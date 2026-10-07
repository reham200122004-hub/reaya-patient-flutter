class ServiceModel {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final double basePrice;
  final String duration;
  final List<String> details;

  const ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.basePrice,
    required this.duration,
    required this.details,
  });
}
