import 'package:flutter/material.dart';

// Professional Color Palette - Modern Green Theme
const primaryColor = Color(0xFF10B981); // Emerald 500 - Modern green
const primaryDarkColor = Color(0xFF059669); // Emerald 600 - Darker green
const primaryLightColor = Color(0xFF34D399); // Emerald 400 - Light green
const secondaryColor = Color(0xFFFFFFFF); // White
const accentColor = Color(0xFFF59E0B); // Amber 500 - Professional accent
const bgColor = Color(0xFFF8FAFC); // Slate 50 - Subtle background
const surfaceColor = Color(0xFFF1F5F9); // Slate 100 - Surface
const textPrimary = Color(0xFF0F172A); // Slate 900 - Primary text
const textSecondary = Color(0xFF64748B); // Slate 500 - Secondary text
const dividerColor = Color(0xFFE2E8F0); // Slate 200

// Additional Professional Colors
const successColor = Color(0xFF10B981);
const warningColor = Color(0xFFF59E0B);
const errorColor = Color(0xFFEF4444);
const infoColor = Color(0xFF3B82F6);

// Card Colors for Stats
const cardColor1 = Color(0xFF10B981); // Green
const cardColor2 = Color(0xFFF59E0B); // Amber
const cardColor3 = Color(0xFF8B5CF6); // Violet

// Dark Mode Colors - Professional Dark Theme
const darkBgColor = Color(0xFF0F172A); // Slate 900
const darkSecondaryColor = Color(0xFF1E293B); // Slate 800
const darkSurfaceColor = Color(0xFF334155); // Slate 700
const darkTextPrimary = Color(0xFFF8FAFC); // Slate 50
const darkTextSecondary = Color(0xFF94A3B8); // Slate 400
const darkDividerColor = Color(0xFF334155); // Slate 700

// Spacing System
const defaultPadding = 16.0;
const smallPadding = 8.0;
const largePadding = 24.0;
const extraLargePadding = 32.0;

// Border Radius
const smallRadius = 8.0;
const defaultRadius = 12.0;
const largeRadius = 16.0;
const extraLargeRadius = 24.0;

// Shadow System
List<BoxShadow> cardShadow = [
  BoxShadow(
    color: Color(0x1A0F172A),
    blurRadius: 20,
    offset: Offset(0, 4),
    spreadRadius: -2,
  ),
];

List<BoxShadow> cardShadowHover = [
  BoxShadow(
    color: Color(0x330F172A),
    blurRadius: 24,
    offset: Offset(0, 8),
    spreadRadius: -4,
  ),
];

List<BoxShadow> buttonShadow = [
  BoxShadow(
    color: Color(0x3310B981),
    blurRadius: 12,
    offset: Offset(0, 4),
  ),
];
