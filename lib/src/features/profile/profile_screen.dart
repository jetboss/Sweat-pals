import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../providers/user_provider.dart';
import '../../providers/theme_provider.dart';
import '../../models/user_profile.dart';
import '../../theme/app_colors.dart';
import '../../services/database_service.dart';
import '../../services/auth_service.dart';
import '../onboarding/onboarding_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _bioController = TextEditingController();
  int _selectedHour = 7; // Default 7 AM
  String _selectedFitnessLevel = 'beginner';
  bool _isEditing = false;
  bool _isSaving = false;
  bool _isUploadingAvatar = false;
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    _loadAvatarUrl();
  }

  void _loadProfileData() {
    final user = ref.read(userProvider);
    if (user != null) {
      _nameController.text = user.name;
      _weightController.text = user.startingWeight.toString();
      _weightController.text = user.startingWeight.toString();
      _heightController.text = user.height.toString();
      _bioController.text = user.bio ?? '';
      _selectedHour = user.preferredWorkoutHour ?? 7;
      _selectedFitnessLevel = user.fitnessLevel ?? 'beginner';
    }
  }

  Future<void> _loadAvatarUrl() async {
    final userId = AuthService().currentUserId;
    if (userId == null) return;
    
    try {
      final profile = await DatabaseService().getProfile(userId);
      if (profile != null && mounted) {
        setState(() {
          _avatarUrl = profile['avatar_url'];
        });
      }
    } catch (e) {
      debugPrint('Error loading avatar: $e');
    }
  }

  Future<void> _pickAndUploadAvatar() async {
    final picker = ImagePicker();
    
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );
      
      if (image == null) return;
      
      setState(() => _isUploadingAvatar = true);
      
      final userId = AuthService().currentUserId;
      if (userId == null) throw Exception('Not logged in');
      
      final bytes = await image.readAsBytes();
      final fileExt = image.path.split('.').last;
      final fileName = '$userId.$fileExt';
      
      // Upload to Supabase Storage
      await Supabase.instance.client.storage
          .from('avatars')
          .uploadBinary(
            fileName,
            bytes,
            fileOptions: FileOptions(contentType: 'image/$fileExt', upsert: true),
          );
      
      // Get public URL
      final publicUrl = Supabase.instance.client.storage
          .from('avatars')
          .getPublicUrl(fileName);
      
      // Update profile with avatar URL
      await DatabaseService().syncProfileToSupabase(
        name: _nameController.text.trim(),
        avatarUrl: publicUrl,
      );
      
      setState(() => _avatarUrl = publicUrl);
      
      HapticFeedback.mediumImpact();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Avatar updated! 📸'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error uploading avatar: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploadingAvatar = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              
              // Avatar
              Stack(
                children: [
                  _isUploadingAvatar
                    ? const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : _avatarUrl != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(_avatarUrl!),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                          child: Text(
                            (user?.name.isNotEmpty == true ? user!.name : 'P').substring(0, 1).toUpperCase(),
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _isUploadingAvatar ? null : _pickAndUploadAvatar,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Name
              if (_isEditing)
                TextField(
                  controller: _nameController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    hintText: 'Your name',
                    border: InputBorder.none,
                  ),
                )
              else
                Text(
                  user?.name ?? 'Sweat Pal',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              
              Text(
                AuthService().currentUserEmail ?? 'No email',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),
              
              // Stats Cards
              if (user != null) ...[
                Row(
                  children: [
                    Expanded(child: _buildStatCard('BMI', user.bmi.toStringAsFixed(1), Icons.monitor_weight)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatCard('TDEE', '${user.tdee.toStringAsFixed(0)} cal', Icons.local_fire_department)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildStatCard('Weight', '${user.startingWeight} kg', Icons.fitness_center)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatCard('Height', '${user.height} cm', Icons.height)),
                  ],
                ),
              ],
              const SizedBox(height: 32),
              
              if (_isEditing || (user != null && user.preferredWorkoutHour != null)) ...[
                const Align(
                   alignment: Alignment.centerLeft,
                   child: Text('Matching Preferences', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 16),
                
                // Workout Time
                if (_isEditing)
                  _buildDropdownTile(
                    icon: Icons.access_time_filled,
                    title: 'Usual Workout Time',
                    value: _formatHour(_selectedHour),
                    onTap: _showHourPicker,
                  )
                else
                   _buildSettingsTile(
                     icon: Icons.access_time_filled, 
                     title: 'Usual Workout Time', 
                     trailing: Text(_formatHour(user!.preferredWorkoutHour ?? 7), style: TextStyle(color: Colors.grey[600])),
                   ),
                
                const SizedBox(height: 12),
                
                // Fitness Level
                if (_isEditing)
                   _buildDropdownTile(
                     icon: Icons.fitness_center,
                     title: 'Fitness Level',
                     value: _selectedFitnessLevel.toUpperCase(),
                     onTap: _showFitnessLevelPicker,
                   )
                else
                   _buildSettingsTile(
                     icon: Icons.fitness_center,
                     title: 'Fitness Level',
                     trailing: Text((user!.fitnessLevel ?? 'BEGINNER').toUpperCase(), style: TextStyle(color: Colors.grey[600])),
                   ),
                   
                const SizedBox(height: 12),
                
                // Bio
                if (_isEditing)
                   Container(
                     padding: const EdgeInsets.all(16),
                     decoration: BoxDecoration(
                        color: isDark ? Colors.grey[850] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                     ),
                     child: TextField(
                       controller: _bioController,
                       maxLines: 3,
                       decoration: const InputDecoration.collapsed(hintText: 'Short bio for your future pal...'),
                     ),
                   )
                else if (user?.bio != null && user!.bio!.isNotEmpty)
                   Container(
                     width: double.infinity,
                     padding: const EdgeInsets.all(16),
                     decoration: BoxDecoration(
                        color: isDark ? Colors.grey[850] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                     ),
                     child: Text(user.bio!, style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic)),
                   ),
                   
                const SizedBox(height: 32),
              ],
              
              // Edit/Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _isSaving ? null : () async {
                    if (_isEditing) {
                      await _saveProfile();
                    } else {
                      setState(() => _isEditing = true);
                    }
                  },
                  icon: Icon(_isEditing ? Icons.save : Icons.edit),
                  label: Text(_isSaving ? 'Saving...' : (_isEditing ? 'Save Profile' : 'Edit Profile')),
                ),
              ),
              
              if (_isEditing) ...[
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    _loadProfileData();
                    setState(() => _isEditing = false);
                  },
                  child: const Text('Cancel'),
                ),
              ],
              
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 16),
              
              // Settings Section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              
              // Theme Toggle
              _buildSettingsTile(
                icon: isDark ? Icons.dark_mode : Icons.light_mode,
                title: 'Dark Mode',
                trailing: Switch(
                  value: isDark,
                  onChanged: (value) {
                    ref.read(themeModeProvider.notifier).setThemeMode(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
              ),
              
              // Notifications
              _buildSettingsTile(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                trailing: Switch(
                  value: true,
                  onChanged: (value) {
                    // TODO: Implement notification toggle
                  },
                ),
              ),
              
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              
              // Logout Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Log Out?'),
                        content: const Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text('Log Out', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                    
                    if (confirm == true) {
                      await AuthService().signOut();
                      if (mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                          (route) => false,
                        );
                      }
                    }
                  },
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                  icon: const Icon(Icons.logout),
                  label: const Text('Log Out'),
                ),
              ),
              
              const SizedBox(height: 24),
              Text(
                'Sweat Pals v1.0.0',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownTile({required IconData icon, required String title, required String value, required VoidCallback onTap}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  String _formatHour(int hour) {
    if (hour == 0) return '12 AM (Midnight)';
    if (hour == 12) return '12 PM (Noon)';
    return hour > 12 ? '${hour - 12} PM' : '$hour AM';
  }

  Future<void> _showHourPicker() async {
    final TimeOfDay initialTime = TimeOfDay(hour: _selectedHour, minute: 0);
    
    final picked = await showTimePicker(
      context: context, 
      initialTime: initialTime,
      builder: (context, child) {
         return MediaQuery(
           data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
           child: child!,
         );
      },
    );
    
    if (picked != null) {
      setState(() => _selectedHour = picked.hour);
    }
  }

  void _showFitnessLevelPicker() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['beginner', 'intermediate', 'advanced', 'pro'].map((level) {
            return ListTile(
              title: Text(level.toUpperCase()),
              onTap: () {
                setState(() => _selectedFitnessLevel = level);
                Navigator.pop(ctx);
              },
              trailing: _selectedFitnessLevel == level ? const Icon(Icons.check, color: AppColors.primary) : null,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required Widget trailing,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
          trailing,
        ],
      ),
    );
  }

  Future<void> _saveProfile() async {
    setState(() => _isSaving = true);
    
    try {
      final user = ref.read(userProvider);
      if (user == null) return;
      
      // Create updated profile
      final updatedProfile = UserProfile(
        name: _nameController.text.trim(),
        startingWeight: double.tryParse(_weightController.text) ?? user.startingWeight,
        targetWeight: user.targetWeight,
        height: double.tryParse(_heightController.text) ?? user.height,
        age: user.age,
        sex: user.sex,
        foodsToAvoid: user.foodsToAvoid,
        startDate: user.startDate,
        preferredWorkoutHour: _selectedHour,
        fitnessLevel: _selectedFitnessLevel,
        bio: _bioController.text.trim(),
      );
      
      // Save locally
      await ref.read(userProvider.notifier).saveProfile(updatedProfile);
      
      // Sync to Supabase
      await DatabaseService().syncProfileToSupabase(
        name: _nameController.text.trim(),
        preferredWorkoutHour: _selectedHour,
        fitnessLevel: _selectedFitnessLevel,
        bio: _bioController.text.trim(),
      );
      
      HapticFeedback.mediumImpact();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile saved! ✅'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() => _isEditing = false);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving: $e')),
      );
    } finally {
      setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _bioController.dispose();
    super.dispose();
  }
}
