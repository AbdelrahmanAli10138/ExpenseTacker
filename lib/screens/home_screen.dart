import 'package:expense_tracker/models/logic/cubit/expense_cubit.dart';
import 'package:expense_tracker/models/logic/cubit/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart'; 
import '../widgets/expense_summary_card.dart';
import '../widgets/expense_list.dart';
import '../widgets/add_expense_sheet.dart';
import '../widgets/category_breakdown.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openAddExpense() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddExpenseSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 4),
            const ExpenseSummaryCard(),
            const SizedBox(height: 12),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  ExpenseList(),
                  CategoryBreakdown(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddExpense,
        backgroundColor: const Color(0xFF2D3436),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: Text(
          'Add Expense',
          style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
        ),
        elevation: 4,
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Expenses',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
              Text(
                'Track your spending',
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: const Color(0xFF636E72),
                ),
              ),
            ],
          ),
          BlocBuilder<ExpenseCubit, ExpenseState>(
            builder: (context, state) {
              return state.expenses.isNotEmpty
                  ? TextButton.icon(
                      onPressed: () => _showClearDialog(),
                      icon: const Icon(Icons.delete_outline_rounded,
                          size: 18, color: Color(0xFFFF6B6B)),
                      label: Text(
                        'Clear',
                        style: GoogleFonts.dmSans(
                          color: const Color(0xFFFF6B6B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEDEFF5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: const Color(0xFF2D3436),
            borderRadius: BorderRadius.circular(10),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFF636E72),
          labelStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
          padding: const EdgeInsets.all(4),
          tabs: const [
            Tab(text: 'All Expenses'),
            Tab(text: 'By Category'),
          ],
        ),
      ),
    );
  }

  void _showClearDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Clear All?',
          style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w700),
        ),
        content: Text(
          'This will delete all your recorded expenses.',
          style: GoogleFonts.dmSans(color: const Color(0xFF636E72)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel',
                style: GoogleFonts.dmSans(color: const Color(0xFF636E72))),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ExpenseCubit>().clearAll();
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B6B),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('Clear All', style: GoogleFonts.dmSans()),
          ),
        ],
      ),
    );
  }
}