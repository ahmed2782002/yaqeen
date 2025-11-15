import 'package:flutter/material.dart';

class PrayerBox extends StatelessWidget {
  final String name;
  final String time;
  final String suffix;
  final bool isActive;

  const PrayerBox({
    super.key,
    required this.name,
    required this.time,
    required this.suffix,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 120, // عرض متوسط يناسب النص
      // ارتفاع أطول للصلاة القادمة
      margin: EdgeInsets.symmetric(horizontal: 7, vertical: isActive ?  2: 10),

      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isActive
              ? [const Color(0xFF012B44), const Color(0xFF628D93)]
              : [const Color(0xFF202020), const Color(0xFF5A4C32)],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isActive ? 28 : 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                suffix,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
