import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../theme/app_colors.dart';
import '../../services/auth_service.dart';
import '../../services/partnership_service.dart';
import '../../services/database_service.dart';
import '../../providers/user_provider.dart';
import '../../models/morning_prompt.dart';
import '../journal/journal_provider.dart';
import '../auth/login_screen.dart';
import 'onboarding_state.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isLoading = false;

  // Step 4: Identity (moved from 2)
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Step 5: Partner Code (moved from 3)
  final _partnerCodeController = TextEditingController();
  String? _myInviteCode;
  bool _expandJoin = false;

  // Step 3: Journal
  final _journalController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _partnerCodeController.dispose();
    _journalController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _handleSignUp() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty || _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill in all fields')));
      return;
    }

    setState(() => _isLoading = true);
    try {
      final onboardingState = ref.read(onboardingStateProvider);

      // 1. Create Auth User
      final response = await AuthService().signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      
      if (response.user != null) {
        // 2. Sync Profile (with Avatar)
        // Note: Creating the auth user usually triggers the postgres trigger for profile creation.
        // We might need to update that profile with the name and avatar.
        // The trigger separates name from metadata, but let's just do an upsert/update here to be safe and add avatar.
        await DatabaseService().syncProfileToSupabase(
          name: _nameController.text.trim(),
          avatarUrl: onboardingState.avatarUrl,
          // user ID is implied from auth context
        );

        // 3. Save Journal Entry
        if (onboardingState.journalEntry != null && onboardingState.journalEntry!.isNotEmpty) {
           final entry = MorningPrompt(
             id: DateTime.now().toIso8601String(),
             date: DateTime.now(),
             goalReminder: onboardingState.journalEntry!, // Map intention to goalReminder
             dailyAction: "Complete onboarding",
             gratitude: "Starting my journey!",
             affirmation: "I am ready.",
           );
           await ref.read(journalProvider.notifier).addEntry(entry);
        }

        // 4. Fetch Invite Code
        String? code;
        int retries = 0;
        while (code == null && retries < 5) {
            try {
              final profile = await Supabase.instance.client
                  .from('profiles')
                  .select('invite_code')
                  .eq('id', response.user!.id)
                  .single();
              code = profile['invite_code'];
            } catch (e) {
              await Future.delayed(const Duration(milliseconds: 500));
              retries++;
            }
        }

        if (mounted) {
          setState(() {
            _myInviteCode = code ?? "ERROR"; 
          });
          _nextPage();
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleMatch() async {
    if (_partnerCodeController.text.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      await PartnershipService().matchWithPartner(_partnerCodeController.text.trim());
      _nextPage(); // Go to success
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Match Failed: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _finishOnboarding() {
    ref.read(onboardingCompleteProvider.notifier).state = true;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkScaffoldBackground : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: LinearProgressIndicator(
                value: (_currentPage + 1) / 6, // 6 Total Steps
                backgroundColor: isDark ? Colors.grey[800] : Colors.grey[100],
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: [
                  _buildPledgeStep(),
                  _buildAvatarStep(),
                  _buildJournalStep(),
                  _buildIdentityStep(),
                  _buildPartnerStep(),
                  _buildSuccessStep(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Step 1
  Widget _buildPledgeStep() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.handshake_rounded, size: 80, color: AppColors.primary),
          const SizedBox(height: 30),
          const Text(
            "The Pledge",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Text(
            "I commit to showing up for my partner, not just myself.\n\n"
            "When they are tired, I will be their strength.\n"
            "When I am tired, I will trust in them.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, height: 1.6, color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[400] : Colors.grey),
          ),
          const Spacer(),
          InkWell(
            onTap: _nextPage,
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: const Text("I Accept", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // Step 2
  Widget _buildAvatarStep() {
    final selectedAvatar = ref.watch(onboardingStateProvider).avatarUrl;
    final avatars = [
      'assets/images/avatar_1.png', // Mock paths, typically would be local assets or selection IDs
      'assets/images/avatar_2.png',
      'assets/images/avatar_3.png',
      'assets/images/avatar_4.png',
    ];

    // Since we don't have actual images, let's use colors/icons for MVP
    final avatarColors = [Colors.blue, Colors.red, Colors.green, Colors.purple];

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
           const Text(
            "Choose Your Look",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            "How do you want to appear to your squad?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: avatarColors.length,
              itemBuilder: (context, index) {
                final color = avatarColors[index];
                // Simple ID generation for now: 'color_int'
                final id = 'avatar_${index + 1}'; 
                final isSelected = selectedAvatar == id;

                return GestureDetector(
                  onTap: () {
                    ref.read(onboardingStateProvider.notifier).setAvatar(id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: isSelected ? Border.all(color: AppColors.primary, width: 4) : null,
                    ),
                    child: Center(
                      child: Icon(Icons.person, size: 48, color: color),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Default to first if none selected, or force selection
              if (selectedAvatar == null) {
                 ref.read(onboardingStateProvider.notifier).setAvatar('avatar_1');
              }
              _nextPage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text("Next", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Step 3
  Widget _buildJournalStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          const Icon(Icons.edit_note_rounded, size: 60, color: AppColors.primary),
          const SizedBox(height: 20),
          const Text(
            "Set Your Intention",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            "What is ONE goal you want to crush this week?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: _journalController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "e.g. Do 10 pushups every morning...",
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            ),
            onChanged: (val) {
              ref.read(onboardingStateProvider.notifier).setJournalEntry(val);
            },
          ),
           const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              if (_journalController.text.isEmpty) {
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Write something small!")));
                 return;
              }
              _nextPage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text("Commit", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Step 4
  Widget _buildIdentityStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Save Your Progress",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            "Create your account to save your pledge and goals.",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: _nameController,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            decoration: _inputDecoration(context, "First Name", Icons.person),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _emailController,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            decoration: _inputDecoration(context, "Email", Icons.email),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            decoration: _inputDecoration(context, "Password", Icons.lock),
            obscureText: true,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _isLoading ? null : _handleSignUp,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary, // Primary color now that they invested
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: _isLoading 
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text("Create Account", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
              }, 
              child: Text("Already have an account? Log In", style: TextStyle(color: Colors.grey[600])),
            ),
          ),
        ],
      ),
    );
  }

  // Step 5
  Widget _buildPartnerStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Find your Pal",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            "Fitness is better together. Connect with your accountability partner now.",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 40),
          
          // My Code Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Text("YOUR INVITE CODE", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                const SizedBox(height: 12),
                Text(
                  _myInviteCode ?? "LOADING...",
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 4),
                ),
                const SizedBox(height: 8),
                const Text("Share this with your partner", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),

          const SizedBox(height: 40),
          const Center(child: Text("OR", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))),
          const SizedBox(height: 20),

          // Join Section
          if (!_expandJoin)
            OutlinedButton(
              onPressed: () => setState(() => _expandJoin = true),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text("I have a code"),
            )
          else ...[
            TextField(
              controller: _partnerCodeController,
              decoration: _inputDecoration(context, "Enter Partner's Code", Icons.qr_code),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2, color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _handleMatch,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Connect", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
          
          const SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: () {
                _finishOnboarding();
              },
              child: const Text("Skip & Find Later", style: TextStyle(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }

  // Step 6 (Success)
  Widget _buildSuccessStep() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_rounded, size: 100, color: Colors.green),
          const SizedBox(height: 40),
          const Text(
            "It's Official!",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Text(
            "You are all set.\nLet's get to work.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, height: 1.6, color: Colors.grey[600]),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: _finishOnboarding,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text("Open Dashboard", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(BuildContext context, String hint, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
      prefixIcon: Icon(icon, color: isDark ? Colors.grey[400] : Colors.grey),
      filled: true,
      fillColor: isDark ? AppColors.darkCardBackground : Colors.grey[100],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    );
  }
}
