import 'package:expense_tracker/models/expense.dart';


class ExpenseState {
  final List<Expense> expenses;

  ExpenseState({required this.expenses});

  // حساب إجمالي المبالغ
  double get totalAmount =>
      expenses.fold(0.0, (sum, e) => sum + e.amount);

  // حساب إجمالي كل فئة
  Map<ExpenseCategory, double> get categoryTotals {
    final Map<ExpenseCategory, double> totals = {};
    for (final expense in expenses) {
      totals[expense.category] =
          (totals[expense.category] ?? 0.0) + expense.amount;
    }
    return totals;
  }

  // الحصول على الفئة الأكثر صرفاً
  ExpenseCategory? get topCategory {
    if (expenses.isEmpty) return null;
    final totals = categoryTotals;
    return totals.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;
  }
}