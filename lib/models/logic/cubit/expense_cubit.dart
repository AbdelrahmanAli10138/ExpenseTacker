import 'package:expense_tracker/models/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit() : super(ExpenseState(expenses: []));

  void addExpense({
    required double amount,
    required ExpenseCategory category,
    required String description,
  }) {
    final newExpense = Expense(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: amount,
      category: category,
      description: description,
      date: DateTime.now(),
    );

    final updatedList = List<Expense>.from(state.expenses)..add(newExpense);
    
    emit(ExpenseState(expenses: updatedList));
  }

  void removeExpense(String id) {
    final updatedList = state.expenses.where((e) => e.id != id).toList();
    emit(ExpenseState(expenses: updatedList));
  }

  void clearAll() {
    emit(ExpenseState(expenses: []));
  }
}