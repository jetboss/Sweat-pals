import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/daily_checkin_provider.dart';
import '../../theme/app_colors.dart';

class DailyCheckInModal extends ConsumerStatefulWidget {
  const DailyCheckInModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const DailyCheckInModal(),
    );
  }

  @override
  ConsumerState<DailyCheckInModal> createState() => _DailyCheckInModalState();
}

class _DailyCheckInModalState extends ConsumerState<DailyCheckInModal> {
  int _moodScore = 3; // Neutral
  int _energyLevel = 5; // Moderate
  double _sleepHours = 7.0;
  final _weightController = TextEditingController();
  final _waterController = TextEditingController();

  final List<String> _moodEmojis = ['😢', '😐', '🙂', '😀', '🤩'];
  final List<String> _moodLabels = ['Rough', 'Meh', 'Okay', 'Good', 'Great'];

  @override
  void dispose() {
    _weightController.dispose();
    _waterController.dispose();
    super.dispose();
  }

  void _submit() async {
    final water = int.tryParse(_waterController.text) ?? 0;
    final weight = double.tryParse(_weightController.text);

    try {
      await ref.read(dailyCheckInProvider.notifier).submitCheckIn(
        moodScore: _moodScore,
        energyLevel: _energyLevel,
        sleepHours: _sleepHours,
        waterIntake: water,
        weight: weight,
      );
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Check-in saved! Flame on! 🔥")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving check-in: $e"), backgroundColor: AppColors.error),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dailyCheckInProvider);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Daily Check-In",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Track your recovery to fuel your streak.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          
          // Mood Section
          _buildSectionLabel("How are you feeling?"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              final isSelected = _moodScore == index + 1;
              return GestureDetector(
                onTap: () => setState(() => _moodScore = index + 1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: isSelected ? Border.all(color: AppColors.primary, width: 2) : null,
                  ),
                  child: Column(
                    children: [
                      Text(_moodEmojis[index], style: const TextStyle(fontSize: 32)),
                      const SizedBox(height: 4),
                      Text(
                        _moodLabels[index],
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: isSelected ? AppColors.primary : AppColors.textSecondary,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),

          // Energy Slider
          _buildSectionLabel("Energy Level  ⚡️ $_energyLevel/10"),
          Slider(
            value: _energyLevel.toDouble(),
            min: 1,
            max: 10,
            divisions: 9,
            activeColor: AppColors.primary,
            onChanged: (val) => setState(() => _energyLevel = val.toInt()),
          ),
          
          const SizedBox(height: 16),

          // Sleep & Water Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionLabel("Sleep (Hours)"),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.divider),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => setState(() => _sleepHours = (_sleepHours - 0.5).clamp(0, 14)),
                          ),
                          Text(
                            _sleepHours.toString(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => setState(() => _sleepHours = (_sleepHours + 0.5).clamp(0, 14)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionLabel("Water (ml)"),
                    TextFormField(
                      controller: _waterController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "e.g. 2000",
                        suffixText: "ml",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          
          // Weight
          _buildSectionLabel("Weight (Optional)"),
          TextFormField(
            controller: _weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              hintText: "Current weight",
              suffixText: "kg", // Localization todo
            ),
          ),

          const SizedBox(height: 32),

          // Submit Button
          ElevatedButton(
            onPressed: state.isLoading ? null : _submit,
            child: state.isLoading 
              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
              : const Text("Complete Check-In"),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }
}
