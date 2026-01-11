import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/meal_plan.dart';
import '../../providers/meals_provider.dart';
import '../../theme/app_colors.dart';

class MealsScreen extends ConsumerStatefulWidget {
  const MealsScreen({super.key});

  @override
  ConsumerState<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends ConsumerState<MealsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredPlans = ref.watch(mealPlanProvider.notifier).getFilteredPlans();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.pink,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: Colors.pink,
          tabs: List.generate(7, (index) => Tab(text: 'Day ${index + 1}')),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_rounded),
            onPressed: () => _showGroceryList(context, ref),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: filteredPlans.map((plan) => _buildDayView(plan)).toList(),
      ),
    );
  }

  Widget _buildDayView(DailyPlan plan) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        _buildDailyMacrosSummary(plan),
        const SizedBox(height: 24),
        const Text(
          "Today's Menu",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...plan.meals.map((meal) => _buildMealCard(meal)),
        const SizedBox(height: 32),
        _buildMotivationalTip(),
      ],
    ),
  );
}

  Widget _buildDailyMacrosSummary(DailyPlan plan) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          const Text("Daily Goal Overiew", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMacroItem("Cals", plan.totalCalories, "kcal"),
              _buildMacroItem("Protein", plan.totalProtein, "g"),
              _buildMacroItem("Carbs", plan.totalCarbs, "g"),
              _buildMacroItem("Fats", plan.totalFats, "g"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroItem(String label, int value, String unit) {
    return Column(
      children: [
        Text(value.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink)),
        Text("$label ($unit)", style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildMealCard(Meal meal) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(meal.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("${meal.type} • ${meal.calories} kcal • ${meal.protein}g P"),
        leading: _buildMealIcon(meal.type),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Ingredients:", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...meal.ingredients.map((ing) => Text("• $ing")),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("P: ${meal.protein}g"),
                    Text("C: ${meal.carbs}g"),
                    Text("F: ${meal.fats}g"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealIcon(String type) {
    IconData icon;
    switch (type) {
      case "Breakfast": icon = Icons.wb_sunny_rounded; break;
      case "Lunch": icon = Icons.lunch_dining_rounded; break;
      case "Dinner": icon = Icons.dinner_dining_rounded; break;
      default: icon = Icons.cookie_rounded;
    }
    return CircleAvatar(
      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
      child: Icon(icon, color: Colors.pink, size: 20),
    );
  }

  Widget _buildMotivationalTip() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.2)),
      ),
      child: const Row(
        children: [
          Icon(Icons.tips_and_updates_rounded, color: Colors.teal),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "Meal prep together, sweat pals! It's more fun and keeps you both on track.",
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.teal),
            ),
          ),
        ],
      ),
    );
  }

  void _showGroceryList(BuildContext context, WidgetRef ref) {
    final list = ref.read(mealPlanProvider.notifier).getGroceryList();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text("Weekly Grocery List", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.pink)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (ctx, i) => ListTile(
                  leading: const Icon(Icons.check_box_outline_blank, color: AppColors.primary),
                  title: Text(list[i]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
