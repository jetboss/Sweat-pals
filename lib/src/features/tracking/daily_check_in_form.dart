import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../models/daily_check_in.dart';
import 'tracking_provider.dart';
import '../../widgets/rive_animation_widget.dart';

class DailyCheckInForm extends ConsumerStatefulWidget {
  const DailyCheckInForm({super.key});

  @override
  ConsumerState<DailyCheckInForm> createState() => _DailyCheckInFormState();
}

class _DailyCheckInFormState extends ConsumerState<DailyCheckInForm> {
  final _formKey = GlobalKey<FormState>();
  bool _followedMealPlan = false;
  final _mealPlanNotesController = TextEditingController();
  double _sleepHours = 8.0;
  bool _drankWater = false; // Legacy toggle, maps to some intake? Or simple 2000ml check?
  int _mood = 3;
  bool _exerciseCompleted = false;
  int _energyLevel = 5;
  final _weightController = TextEditingController();

  @override
  void dispose() {
    _mealPlanNotesController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final weight = double.tryParse(_weightController.text);
      
      final entry = DailyCheckIn(
        id: const Uuid().v4(),
        date: DateTime.now(),
        followedMealPlan: _followedMealPlan,
        mealPlanNotes: _mealPlanNotesController.text,
        sleepHours: _sleepHours,
        waterIntake: _drankWater ? 2000 : 0, // Simple mapping for now
        moodScore: _mood, // Renamed field
        exerciseCompleted: _exerciseCompleted,
        energyLevel: _energyLevel,
        weight: weight,
      );

      ref.read(trackingProvider.notifier).addEntry(entry);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Check-in'),
        actions: [
          IconButton(
            onPressed: _save,
            icon: const Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: RiveAnimationWidget(type: RiveAssetType.celebration),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'How was your day, pal? Let\'s track our wins together!',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Question 1: Meal Plan
              SwitchListTile(
                title: const Text('Did you follow your meal plan?'),
                value: _followedMealPlan,
                onChanged: (value) => setState(() => _followedMealPlan = value),
              ),
              if (_followedMealPlan)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: _mealPlanNotesController,
                    decoration: const InputDecoration(
                      labelText: 'Any notes? (Optional)',
                      hintText: 'e.g., "Loved the chicken salad!"',
                    ),
                  ),
                ),
              const Divider(height: 32),
              
              // Energy Level (New)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Energy Level: $_energyLevel/10'),
              ),
              Slider(
                value: _energyLevel.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                onChanged: (value) => setState(() => _energyLevel = value.toInt()),
              ),
              const Divider(height: 32),

              // Question 2: Sleep
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Sleep Hours: ${_sleepHours.toStringAsFixed(1)}'),
              ),
              Slider(
                value: _sleepHours,
                min: 0,
                max: 12,
                divisions: 24,
                onChanged: (value) => setState(() => _sleepHours = value),
              ),
              const Divider(height: 32),
              
              // Question 3: Water (Simplified)
              SwitchListTile(
                title: const Text('Did you hit your water goal?'),
                value: _drankWater,
                onChanged: (value) => setState(() => _drankWater = value),
              ),
              const Divider(height: 32),
              
              // Question 4: Mood
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('How would you rate your mood?'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  final rating = index + 1;
                  return IconButton(
                    icon: Icon(
                      rating <= _mood ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: Colors.amber,
                      size: 32,
                    ),
                    onPressed: () => setState(() => _mood = rating),
                  );
                }),
              ),
              const Divider(height: 32),
              
              // Weight (New)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _weightController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Current Weight (kg) (Optional)',
                    suffixText: 'kg',
                  ),
                ),
              ),
              const Divider(height: 32),

              // Question 5: Exercise
              SwitchListTile(
                title: const Text('Did you complete your exercise?'),
                value: _exerciseCompleted,
                onChanged: (value) => setState(() => _exerciseCompleted = value),
              ),
              const SizedBox(height: 40),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Save Check-in'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
