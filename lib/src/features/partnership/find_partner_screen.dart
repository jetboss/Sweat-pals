import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../services/database_service.dart';
import '../../models/user_profile.dart'; // Using UserProfile model or just Map
import '../../providers/user_provider.dart';
import '../profile/profile_screen.dart'; // Nav to profile if needed

class FindPartnerScreen extends ConsumerStatefulWidget {
  const FindPartnerScreen({super.key});

  @override
  ConsumerState<FindPartnerScreen> createState() => _FindPartnerScreenState();
}

class _FindPartnerScreenState extends ConsumerState<FindPartnerScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _matches = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMatches();
  }

  Future<void> _loadMatches() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final matches = await DatabaseService().findMatches();
      if (mounted) {
        setState(() {
          _matches = matches;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to find matches. Please try again.';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final hasPreferences = user?.preferredWorkoutHour != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Find a Pal"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: !hasPreferences 
          ? _buildEmptyStateNoPreferences(context)
          : _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
                  ? Center(child: Text(_error!))
                  : _matches.isEmpty
                      ? _buildEmptyStateNoMatches(context)
                      : _buildMatchList(),
    );
  }

  Widget _buildEmptyStateNoPreferences(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.access_time_filled, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              "Set Your Schedule",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "To find a workout partner, we need to know when you usually exercise.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text("Update Profile"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyStateNoMatches(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_search, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              "No Matches Yet",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "We couldn't find anyone with a similar schedule right now. Try adjusting your time or checking back later.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            OutlinedButton(
               onPressed: _loadMatches,
               child: const Text("Refresh"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchList() {
    return RefreshIndicator(
      onRefresh: _loadMatches,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _matches.length,
        itemBuilder: (context, index) {
          final match = _matches[index];
          return _MatchCard(match: match);
        },
      ),
    );
  }
}

class _MatchCard extends StatelessWidget {
  final Map<String, dynamic> match;

  const _MatchCard({required this.match});

  @override
  Widget build(BuildContext context) {
    final name = match['name'] ?? 'Unknown User';
    final bio = match['bio'] ?? 'No bio yet.';
    final hour = match['preferred_workout_hour'] as int?;
    final level = match['fitness_level'] as String? ?? 'Beginner';
    final matchScore = match['match_score'] as int? ?? 0;
    final avatarUrl = match['avatar_url'] as String?;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
                  child: avatarUrl == null ? Text(name[0].toUpperCase()) : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(level.toUpperCase(), style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ),
                Container(
                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                   decoration: BoxDecoration(
                     color: Colors.green.withOpacity(0.1),
                     borderRadius: BorderRadius.circular(8),
                   ),
                   child: Row(
                     children: [
                       const Icon(Icons.bolt, size: 14, color: Colors.green),
                       Text("$matchScore% Match", style: const TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.bold)),
                     ],
                   ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (hour != null)
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text("Works out around ${_formatHour(hour)}", style: const TextStyle(fontSize: 14)),
                ],
              ),
            const SizedBox(height: 8),
            Text(bio, style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                   // TODO: Implement invitation logic (just mock for now)
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('Invitation sent! 📨')),
                   );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Connect"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatHour(int hour) {
    if (hour == 0) return '12 AM';
    if (hour == 12) return '12 PM';
    return hour > 12 ? '${hour - 12} PM' : '$hour AM';
  }
}
