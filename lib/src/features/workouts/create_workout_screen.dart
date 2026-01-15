import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../models/workout.dart';
import '../../providers/workouts_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/animated_widgets.dart';

class CreateWorkoutScreen extends ConsumerStatefulWidget {
  const CreateWorkoutScreen({super.key});

  @override
  ConsumerState<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends ConsumerState<CreateWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  
  final List<Exercise> _exercises = [];

  void _addExercise() {
    showDialog(
      context: context,
      builder: (context) => _AddExerciseDialog(
        onAdd: (exercise) {
          setState(() {
            _exercises.add(exercise);
          });
        },
      ),
    );
  }

  void _saveWorkout() {
    if (_formKey.currentState!.validate()) {
      if (_exercises.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please add at least one exercise.')),
        );
        return;
      }

      final newWorkout = Workout(
        id: const Uuid().v4(),
        title: _titleController.text,
        description: _descController.text,
        exercises: _exercises,
        category: 'Custom',
        workoutCategory: WorkoutCategory.fullBody, // Default
        level: WorkoutLevel.intermediate, // Default
        durationMinutes: _calculateDuration(),
        equipment: Equipment.none,
        imageUrl: 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=400', // Default gym image
      );

      ref.read(workoutsProvider.notifier).saveCustomWorkout(newWorkout);
      Navigator.pop(context);
    }
  }

  int _calculateDuration() {
    int totalSeconds = _exercises.fold(0, (sum, ex) => sum + (ex.durationSeconds > 0 ? ex.durationSeconds : 30));
    return (totalSeconds / 60).ceil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        title: const Text('Create Workout', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: _saveWorkout,
            child: const Text('Save', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Workout Name'),
                validator: (value) => value!.isEmpty ? 'Enter a name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Description'),
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Exercises', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: AppColors.primary),
                    onPressed: _addExercise,
                  ),
                ],
              ),
              Expanded(
                child: ReorderableListView(
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) newIndex -= 1;
                      final item = _exercises.removeAt(oldIndex);
                      _exercises.insert(newIndex, item);
                    });
                  },
                  children: [
                    for (int i = 0; i < _exercises.length; i++)
                      ListTile(
                        key: ValueKey(_exercises[i]),
                        tileColor: AppColors.cardBackground,
                        title: Text(_exercises[i].name, style: const TextStyle(color: Colors.white)),
                        subtitle: Text(
                          _exercises[i].durationSeconds > 0 
                              ? '${_exercises[i].durationSeconds}s' 
                              : '${_exercises[i].reps} reps',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                        ),
                        leading: const Icon(Icons.drag_handle, color: Colors.grey),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _exercises.removeAt(i);
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: GlowingFAB(
        onPressed: _addExercise,
        child: const Icon(Icons.add),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
    );
  }
}

class _AddExerciseDialog extends StatefulWidget {
  final Function(Exercise) onAdd;

  const _AddExerciseDialog({required this.onAdd});

  @override
  State<_AddExerciseDialog> createState() => _AddExerciseDialogState();
}

class _AddExerciseDialogState extends State<_AddExerciseDialog> {
  final _nameController = TextEditingController();
  final _instructionsController = TextEditingController();
  bool _isTimeBased = true;
  double _duration = 30;
  double _reps = 10;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardBackground,
      title: const Text('Add Exercise', style: TextStyle(color: Colors.white)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'Exercise Name', labelStyle: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Type:', style: TextStyle(color: Colors.white)),
                const SizedBox(width: 16),
                ChoiceChip(
                  label: const Text('Time'),
                  selected: _isTimeBased,
                  onSelected: (val) => setState(() => _isTimeBased = true),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Reps'),
                  selected: !_isTimeBased,
                  onSelected: (val) => setState(() => _isTimeBased = false),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_isTimeBased) ...[
              Text('Duration: ${_duration.toInt()}s', style: const TextStyle(color: Colors.white)),
              Slider(
                value: _duration,
                min: 5,
                max: 120,
                divisions: 23,
                activeColor: AppColors.primary,
                onChanged: (val) => setState(() => _duration = val),
              ),
            ] else ...[
              Text('Reps: ${_reps.toInt()}', style: const TextStyle(color: Colors.white)),
              Slider(
                value: _reps,
                min: 1,
                max: 50,
                divisions: 49,
                activeColor: AppColors.primary,
                onChanged: (val) => setState(() => _reps = val),
              ),
            ],
            const SizedBox(height: 16),
             TextField(
              controller: _instructionsController,
               style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'Instructions', labelStyle: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          onPressed: () {
            if (_nameController.text.isNotEmpty) {
              final ex = Exercise(
                name: _nameController.text,
                durationSeconds: _isTimeBased ? _duration.toInt() : 0,
                reps: _isTimeBased ? 0 : _reps.toInt(),
                instructions: _instructionsController.text.isNotEmpty ? _instructionsController.text : 'Do the exercise.',
              );
              widget.onAdd(ex);
              Navigator.pop(context);
            }
          },
          child: const Text('Add', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
