import 'package:expense_tracker/models/logic/cubit/expense_cubit.dart';
import 'package:expense_tracker/models/logic/cubit/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class CategoryBreakdown extends StatelessWidget {
  const CategoryBreakdown({super.key});

  @override
  Widget build(BuildContext context) {
    // استبدال Consumer بـ BlocBuilder
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      builder: (context, state) {
        final totals = state.categoryTotals;
        final total = state.totalAmount;

        if (totals.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEFF5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text('📊', style: TextStyle(fontSize: 36)),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'No data yet',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2D3436),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add expenses to see your\nspending breakdown',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    color: const Color(0xFF636E72),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }

        final sorted = totals.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          itemCount: sorted.length,
          itemBuilder: (ctx, i) {
            final entry = sorted[i];
            final cat = entry.key;
            final amount = entry.value;
            final percent = total > 0 ? (amount / total) : 0.0;

            return _CategoryRow(
              category: cat,
              amount: amount,
              percent: percent,
              rank: i + 1,
            );
          },
        );
      },
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final ExpenseCategory category;
  final double amount;
  final double percent;
  final int rank;

  const _CategoryRow({
    required this.category,
    required this.amount,
    required this.percent,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: category.lightColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    category.emoji,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.label,
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                    Text(
                      '${(percent * 100).toStringAsFixed(1)}% of total',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: const Color(0xFF636E72),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                NumberFormat.currency(symbol: '\$').format(amount),
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: const Color(0xFF2D3436),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: category.lightColor,
              valueColor: AlwaysStoppedAnimation<Color>(category.color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
