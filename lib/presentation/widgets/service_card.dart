import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/service_model.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.service,
    this.isSelected = false,
    required this.onTap,
  });

  IconData _getServiceIcon(String iconName) {
    switch (iconName) {
      case 'bandage':
        return Icons.healing_rounded;
      case 'heart-pulse':
        return Icons.monitor_heart_rounded;
      case 'droplet':
        return Icons.water_drop_rounded;
      case 'accessibility':
        return Icons.elderly_rounded;
      case 'shield-plus':
        return Icons.health_and_safety_rounded;
      case 'stethoscope':
      default:
        return Icons.medical_services_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blushPink.withOpacity(0.5) : AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? AppColors.dustyRose : AppColors.warmBeige,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.dustyRose : AppColors.cream,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    _getServiceIcon(service.iconName),
                    color: isSelected ? Colors.white : AppColors.dustyRose,
                    size: 24,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.cream,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${service.basePrice.toInt()} ج.م',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.dustyRoseDark,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              service.title,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.warmDarkGray,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              service.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.timer_outlined, size: 16, color: AppColors.softMauve),
                const SizedBox(width: 4),
                Text(
                  service.duration,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    color: AppColors.softMauve,
                  ),
                ),
                const Spacer(),
                if (isSelected)
                  const Icon(Icons.check_circle, color: AppColors.dustyRose, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
