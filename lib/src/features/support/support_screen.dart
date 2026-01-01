import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Craving Support')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBuddyHeader(context),
            const SizedBox(height: 24),
            Text(
              'High Volume Snacks (<200 Cal)',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildSnackList(),
            const SizedBox(height: 32),
            Text(
              'Anti-Binge Script',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildBingeScript(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildBuddyHeader(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.favorite_rounded, color: Colors.redAccent),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'When cravings hit, remember: We\'ve got this, sweat pal!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSnackList() {
    final snacks = [
      '3 cups air-popped popcorn (90 cal)',
      '1 cup blueberries / 1 apple (80 cal)',
      'Low-fat Greek yogurt with Stevia (100 cal)',
      'Cucumber slices with 2 tbsp hummus (120 cal)',
      '1 slice whole-wheat toast with 1/2 avocado (180 cal)',
      'Sugar-free Jell-O (10 cal)',
      '2 rice cakes with thin layer PB (150 cal)',
      '1 cup sugar snap peas (60 cal)',
      'Handful of baby carrots (35 cal)',
      '1 medium banana (105 cal)',
    ];

    return Column(
      children: snacks
          .map((snack) => ListTile(
                leading: const Icon(Icons.restaurant_rounded, size: 20),
                title: Text(snack),
                dense: true,
              ))
          .toList(),
    );
  }

  Widget _buildBingeScript(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: const Text(
        '1. Stop. Take 3 deep breaths.\n'
        '2. Drink 16oz of cold water immediately.\n'
        '3. Ask: Am I hungry, or just bored/stressed?\n'
        '4. Set a timer for 15 minutes. If I still want it then, I\'ll have a high-volume snack.\n'
        '5. Text my pal! "Hey pal, craving is hitting. Let\'s stay strong together."',
        style: TextStyle(height: 1.6),
      ),
    );
  }
}
