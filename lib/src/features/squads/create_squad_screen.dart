import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../services/database_service.dart';

class CreateSquadScreen extends StatefulWidget {
  const CreateSquadScreen({super.key});

  @override
  State<CreateSquadScreen> createState() => _CreateSquadScreenState();
}

class _CreateSquadScreenState extends State<CreateSquadScreen> {
  final _nameController = TextEditingController();
  String _selectedTier = 'social'; // 'social' | 'wolf'
  bool _isLoading = false;

  void _createSquad() async {
    if (_nameController.text.trim().isEmpty) return;

    setState(() => _isLoading = true);
    
    try {
      final squadId = await DatabaseService().createSquad(
        _nameController.text.trim(),
        _selectedTier,
      );

      setState(() => _isLoading = false);
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Error: ${e.toString().replaceAll("PostgrestException(message: ", "")}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assemble The Pack"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Name your Squad",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: "e.g. Morning Grinders",
                prefixIcon: Icon(Icons.group_work_rounded),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Choose your Vibe",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Tier 1: Social Club
            _TierSelectionCard(
              title: "The Social Club ☕️",
              description: "Casual. Keep each other company. Track walks & light movers.",
              isSelected: _selectedTier == 'social',
              color: AppColors.primary,
              onTap: () => setState(() => _selectedTier = 'social'),
            ),
            const SizedBox(height: 16),

            // Tier 2: Wolf Pack
            _TierSelectionCard(
              title: "The Wolf Pack 🐺",
              description: "Hardcore. Earn your spot. Miss a workout? You get silenced.",
              isSelected: _selectedTier == 'wolf',
              color: AppColors.primary,
              onTap: () => setState(() => _selectedTier = 'wolf'),
            ),

            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _createSquad,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Create Squad"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TierSelectionCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _TierSelectionCard({
    required this.title,
    required this.description,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? color : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? color : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: color, size: 28),
          ],
        ),
      ),
    );
  }
}
