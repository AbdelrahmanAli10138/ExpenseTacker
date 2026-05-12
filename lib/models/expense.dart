import 'package:flutter/material.dart';

enum ExpenseCategory {
  food,
  transport,
  shopping,
  entertainment,
  health,
  utilities,
  education,
  other,
}

extension ExpenseCategoryExtension on ExpenseCategory {
  String get label {
    switch (this) {
      case ExpenseCategory.food:
        return 'Food & Dining';
      case ExpenseCategory.transport:
        return 'Transport';
      case ExpenseCategory.shopping:
        return 'Shopping';
      case ExpenseCategory.entertainment:
        return 'Entertainment';
      case ExpenseCategory.health:
        return 'Health';
      case ExpenseCategory.utilities:
        return 'Utilities';
      case ExpenseCategory.education:
        return 'Education';
      case ExpenseCategory.other:
        return 'Other';
    }
  }

  String get emoji {
    switch (this) {
      case ExpenseCategory.food:
        return '🍽️';
      case ExpenseCategory.transport:
        return '🚗';
      case ExpenseCategory.shopping:
        return '🛍️';
      case ExpenseCategory.entertainment:
        return '🎬';
      case ExpenseCategory.health:
        return '💊';
      case ExpenseCategory.utilities:
        return '💡';
      case ExpenseCategory.education:
        return '📚';
      case ExpenseCategory.other:
        return '📦';
    }
  }

  Color get color {
    switch (this) {
      case ExpenseCategory.food:
        return const Color(0xFFFF6B6B);
      case ExpenseCategory.transport:
        return const Color(0xFF4ECDC4);
      case ExpenseCategory.shopping:
        return const Color(0xFFFFE66D);
      case ExpenseCategory.entertainment:
        return const Color(0xFFA29BFE);
      case ExpenseCategory.health:
        return const Color(0xFF6BCB77);
      case ExpenseCategory.utilities:
        return const Color(0xFFFFB347);
      case ExpenseCategory.education:
        return const Color(0xFF74B9FF);
      case ExpenseCategory.other:
        return const Color(0xFFB2BEC3);
    }
  }

  Color get lightColor {
    return color.withOpacity(0.15);
  }
}

class Expense {
  final String id;
  final double amount;
  final ExpenseCategory category;
  final String description;
  final DateTime date;

  Expense({
    required this.id,
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
  });
}
