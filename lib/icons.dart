import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Icon(
        icon,
        color: Colors.black.withOpacity(.8),
        size: 14,
      ),
    );
  }
}

class CloseIcon extends StatelessWidget {
  const CloseIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.close, color: Colors.white, size: 10);
  }
}

class InfoIcon extends StatelessWidget {
  const InfoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.info_outline,
      size: 15,
      color: Colors.black.withOpacity(.6),
    );
  }
}
