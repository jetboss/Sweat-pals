import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../services/partnership_service.dart';
import '../../providers/user_provider.dart';

class FindPartnerScreen extends ConsumerStatefulWidget {
  const FindPartnerScreen({super.key});

  @override
  ConsumerState<FindPartnerScreen> createState() => _FindPartnerScreenState();
}

class _FindPartnerScreenState extends ConsumerState<FindPartnerScreen> {
  final _inviteCodeController = TextEditingController();
  bool _isLoading = false;
  String? _statusMessage;

  Future<void> _connectWithPartner() async {
    final code = _inviteCodeController.text.trim().toUpperCase();
    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-character code.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _statusMessage = null;
    });

    try {
      await PartnershipService().matchWithPartner(code);
      if (mounted) {
        setState(() {
          _statusMessage = 'Success! You are now partners! 🎉';
          _inviteCodeController.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Partner linked successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _statusMessage = 'Error: ${e.toString().replaceAll("Exception:", "")}');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final myCode = user.value?.inviteCode ?? 'LOADING';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Find a Pal"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Your Code Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text("YOUR INVITE CODE", 
                    style: TextStyle(color: Colors.white70, letterSpacing: 1.5, fontSize: 12, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: myCode));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Code copied! 📋')));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         Text(
                          myCode,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.copy, color: Colors.white70, size: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text("Share this with your gym buddy to link up!", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),

            // Enter Code Section
            const Text("ENTER A FRIEND'S CODE", 
               style: TextStyle(color: Colors.grey, letterSpacing: 1.5, fontSize: 12, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _inviteCodeController,
              textAlign: TextAlign.center,
              textCapitalization: TextCapitalization.characters,
              maxLength: 6,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 4),
              decoration: InputDecoration(
                hintText: 'XYZ123',
                counterText: '',
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
              ),
            ),
            const SizedBox(height: 24),
            
            if (_statusMessage != null)
              Container(
                 padding: const EdgeInsets.all(12),
                 margin: const EdgeInsets.only(bottom: 16),
                 decoration: BoxDecoration(
                   color: _statusMessage!.startsWith('Success') ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Text(_statusMessage!, 
                   style: TextStyle(color: _statusMessage!.startsWith('Success') ? Colors.green : Colors.red, fontWeight: FontWeight.bold)
                 ),
              ),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _connectWithPartner,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: _isLoading 
                  ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                  : const Text("LINK PARTNER", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
