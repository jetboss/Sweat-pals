import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal_plan.dart';
import 'user_provider.dart';

final mealPlanProvider = StateNotifierProvider<MealPlanNotifier, List<DailyPlan>>((ref) {
  return MealPlanNotifier(ref);
});

class MealPlanNotifier extends StateNotifier<List<DailyPlan>> {
  final Ref _ref;
  
  MealPlanNotifier(this._ref) : super([]) {
    _initializeDefaultPlan();
  }

  void _initializeDefaultPlan() {
    state = [
      _createDay1(),
      _createDay2(),
      _createDay3(),
      _createDay4(),
      _createDay5(),
      _createDay6(),
      _createDay7(),
    ];
  }

  DailyPlan _createDay1() {
    return const DailyPlan(
      dayNumber: 1,
      meals: [
        Meal(
          name: "Scrambled Eggs with Spinach & Feta",
          type: "Breakfast",
          calories: 450,
          protein: 35,
          carbs: 10,
          fats: 30,
          ingredients: ["3 Eggs", "1 cup Spinach", "30g Feta cheese", "1 slice Whole-grain toast"],
        ),
        Meal(
          name: "Grilled Chicken Salad with Quinoa",
          type: "Lunch",
          calories: 550,
          protein: 45,
          carbs: 40,
          fats: 20,
          ingredients: ["150g Chicken breast", "1/2 cup Quinoa", "Mixed greens", "1 tbsp Olive oil", "Lemon juice"],
        ),
        Meal(
          name: "Baked Salmon with Broccoli",
          type: "Dinner",
          calories: 600,
          protein: 40,
          carbs: 15,
          fats: 40,
          ingredients: ["150g Salmon fillet", "2 cups Broccoli", "1/2 Sweet potato", "Garlic", "Butter"],
        ),
        Meal(
          name: "Greek Yogurt with Berries",
          type: "Snack",
          calories: 200,
          protein: 20,
          carbs: 15,
          fats: 5,
          ingredients: ["200g Greek Yogurt", "1/2 cup Blueberries"],
        ),
      ],
    );
  }

  // Helper to create more days (similar structure)
  DailyPlan _createDay2() => _createDay(2, "Oatmeal with Protein Powder", "Tuna Wrap", "Turkey Chili", "Almonds");
  DailyPlan _createDay3() => _createDay(3, "Omelette with Peppers", "Chicken stir-fry", "Sirloin Steak & Asparagus", "Cottage Cheese");
  DailyPlan _createDay4() => _createDay(4, "Protein Pancakes", "Lentil Soup", "Baked Cod with Zucchini", "Apple & Peanut Butter");
  DailyPlan _createDay5() => _createDay(5, "Breakfast Burrito", "Salmon Salad", "Chicken Thighs with Roasted Veg", "Whey Protein Shake");
  DailyPlan _createDay6() => _createDay(6, "Shakshuka", "Shrimp & Quinoa Bowl", "Lean Ground Beef Tacos", "Edamame");
  DailyPlan _createDay7() => _createDay(7, "Avocado Toast with Egg", "Beef Stir-fry", "Lemon Herb Roast Chicken", "Hard-boiled Eggs");

  DailyPlan _createDay(int day, String b, String l, String d, String s) {
    return DailyPlan(
      dayNumber: day,
      meals: [
        Meal(name: b, type: "Breakfast", calories: 450, protein: 30, carbs: 40, fats: 15, ingredients: ["Item 1", "Item 2"]),
        Meal(name: l, type: "Lunch", calories: 500, protein: 40, carbs: 30, fats: 20, ingredients: ["Item 1", "Item 2"]),
        Meal(name: d, type: "Dinner", calories: 650, protein: 50, carbs: 20, fats: 30, ingredients: ["Item 1", "Item 2"]),
        Meal(name: s, type: "Snack", calories: 200, protein: 15, carbs: 10, fats: 10, ingredients: ["Item 1"]),
      ],
    );
  }

  List<String> getGroceryList() {
    final List<String> ingredients = [];
    for (var day in state) {
      for (var meal in day.meals) {
        ingredients.addAll(meal.ingredients);
      }
    }
    return ingredients.toSet().toList()..sort();
  }

  List<DailyPlan> getFilteredPlans() {
    final user = _ref.watch(userProvider);
    if (user == null || user.foodsToAvoid.isEmpty) return state;

    final avoided = user.foodsToAvoid.toLowerCase().split(',').map((e) => e.trim());
    
    return state.map((day) {
      final filteredMeals = day.meals.where((meal) {
        return !avoided.any((a) => 
          meal.name.toLowerCase().contains(a) || 
          meal.ingredients.any((i) => i.toLowerCase().contains(a))
        );
      }).toList();
      return DailyPlan(dayNumber: day.dayNumber, meals: filteredMeals);
    }).toList();
  }
}
