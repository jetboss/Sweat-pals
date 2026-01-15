import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../theme/app_colors.dart';
import '../../services/auth_service.dart';
import '../../providers/user_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleSignIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill in all fields')));
      return;
    }

    setState(() => _isLoading = true);
    try {
      final response = await AuthService().signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      
      if (response.user != null && mounted) {
        // Trigger generic user initialization to fetch profile
        // The provider inside MainShell/App usually handles this, but since we are manually navigating,
        // we might want to ensure the state is updated. 
        // Force refresh of user provider logic essentially happens on app rebuild or we can manually refresh.
        
        // Mark onboarding as complete since they are logging in
        // Note: Ideally we check if they actually finished setup, but for now assumption is yes.
        ref.read(onboardingCompleteProvider.notifier).state = true; 
        
        Navigator.pop(context); // Close login screen
        // Depending on where this was called from, might need to ensure we go to Home.
        // If from Onboarding, popping might return to Onboarding. 
        // We probably want to replace the route.
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Failed: ${e.toString().split("\n").first}')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome Back")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 32),
            TextField(
              controller: _emailController,
              decoration: _inputDecoration(context, "Email", Icons.email),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: _inputDecoration(context, "Password", Icons.lock),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : _handleSignIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: _isLoading 
                ? const CircularProgressIndicator(color: Colors.white) 
                : const Text("Log In", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
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
