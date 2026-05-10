import 'package:flutter/material.dart';

Color parseBrandColor(String? hex, {Color fallback = const Color(0xFFF59700)}) {
  final value = hex?.trim();
  if (value == null || value.isEmpty) return fallback;

  final normalized = value.startsWith('#') ? value.substring(1) : value;
  if (normalized.length != 6) return fallback;

  final colorValue = int.tryParse(normalized, radix: 16);
  if (colorValue == null) return fallback;

  return Color(0xFF000000 | colorValue);
}
