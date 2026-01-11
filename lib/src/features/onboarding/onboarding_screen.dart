import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user_profile.dart';
import '../../providers/user_provider.dart';
import '../../theme/app_colors.dart';
import '../../services/notifications_service.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  UserProfile? _calculatedProfile;

  // Form Controllers
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _foodsController = TextEditingController();
  String _sex = 'F';

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _foodsController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (_currentPage == 3) {
      // Calculate profile but don't save yet to prevent reactive switch
      setState(() {
        _calculatedProfile = UserProfile(
          name: _nameController.text,
          startingWeight: double.tryParse(_weightController.text) ?? 70.0,
          targetWeight: (double.tryParse(_weightController.text) ?? 70.0) - 5,
          height: double.tryParse(_heightController.text) ?? 170.0,
          age: int.tryParse(_ageController.text) ?? 25,
          sex: _sex,
          foodsToAvoid: _foodsController.text,
          startDate: DateTime.now(),
        );
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() async {
    if (_calculatedProfile != null) {
      await ref.read(userProvider.notifier).saveProfile(_calculatedProfile!);
      
      // Schedule initial reminders
      await NotificationsService.scheduleDailyReminder(
        id: 1,
        title: "Good Morning, Sweat Pal! ☀️",
        body: "Time to crush your goals today. Don't forget to check in!",
        hour: 8,
        minute: 0,
      );
      
      await NotificationsService.scheduleDailyReminder(
        id: 2,
        title: "Evening Review 🌙",
        body: "How did today go? Log your habits and journal your wins!",
        hour: 20,
        minute: 0,
      );
      // Reactive state in MyApp will handle the switch to MainShell
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: LinearProgressIndicator(
                value: (_currentPage + 1) / 5,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                color: Colors.pink,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildFirstStep(),
                  _buildBasicsStep(),
                  _buildPhysicalsStep(),
                  _buildPreferencesStep(),
                  if (_calculatedProfile != null)
                    _buildSummaryStep(_calculatedProfile!)
                  else
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
            if (_currentPage < 4)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    elevation: 4,
                    shadowColor: AppColors.primary.withValues(alpha: 0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    _currentPage == 3 ? 'Generate Plan 🚀' : 'Next Pal! →',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryStep(UserProfile profile) {
    final planSummary = ref.read(userProvider.notifier).generate12WeekPlanSummary(profile);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Icon(Icons.rocket_launch_rounded, size: 80, color: AppColors.primary),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              "You're all set, ${profile.name}! 🎉",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
          ),
          const SizedBox(height: 40),
          _buildMetricCard("BMI", profile.bmi.toStringAsFixed(1), "Normal range: 18.5 - 24.9"),
          const SizedBox(height: 16),
          _buildMetricCard("Daily Calories", "${profile.tdee.toStringAsFixed(0)} kcal", "Target for maintaining weight"),
          const SizedBox(height: 32),
          const Text(
            "Your 12-Week Roadmap",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: Text(
              planSummary,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _finishOnboarding,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 56),
              elevation: 4,
              shadowColor: AppColors.success.withValues(alpha: 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              "Let's Crush it! 💪",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, String description) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.pink)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const Icon(Icons.check_circle_rounded, color: Colors.teal),
        ],
      ),
    );
  }

  Widget _buildStepWrapper(String title, String subtitle, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withValues(alpha: 0.1).withValues(alpha: 0.5),
            AppColors.scaffoldBackground,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Text(
              title,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                color: Colors.pink,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.primaryVariant.withValues(alpha: 0.7),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 50),
            ...children.map((child) => Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: child,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstStep() {
    return _buildStepWrapper(
      "Hey Sweat Pal!",
      "Let's get to know you better. What's your name, pal?",
      [
        TextField(
          controller: _nameController,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          decoration: _inputDecoration("Your Name", Icons.person_rounded),
        ),
      ],
    );
  }

  Widget _buildBasicsStep() {
    return _buildStepWrapper(
      "The Basics",
      "Sharing your stats helps us craft the perfect plan.",
      [
        TextField(
          controller: _ageController,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          decoration: _inputDecoration("Age", Icons.calendar_today_rounded),
        ),
        DropdownButtonFormField<String>(
          initialValue: _sex,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          decoration: _inputDecoration("Sex", Icons.wc_rounded),
          items: const [
            DropdownMenuItem(value: 'M', child: Text('Male')),
            DropdownMenuItem(value: 'F', child: Text('Female')),
          ],
          onChanged: (val) => setState(() => _sex = val!),
        ),
      ],
    );
  }

  Widget _buildPhysicalsStep() {
    return _buildStepWrapper(
      "Your Stats",
      "Current measurements for progress tracking.",
      [
        TextField(
          controller: _weightController,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          decoration: _inputDecoration("Weight", Icons.monitor_weight_rounded, suffix: "kg"),
        ),
        TextField(
          controller: _heightController,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          decoration: _inputDecoration("Height", Icons.height_rounded, suffix: "cm"),
        ),
      ],
    );
  }

  Widget _buildPreferencesStep() {
    return _buildStepWrapper(
      "Avoid List",
      "Tell us what foods to dodge to keep you on track.",
      [
        TextField(
          controller: _foodsController,
          maxLines: 4,
          style: const TextStyle(fontSize: 16),
          decoration: _inputDecoration("e.g. Sugar, Soda, Fast food...", Icons.no_food_rounded),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon, {String? suffix}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.primary.withValues(alpha: 0.4)),
      suffixText: suffix,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.pink, width: 2),
      ),
    );
  }
}
