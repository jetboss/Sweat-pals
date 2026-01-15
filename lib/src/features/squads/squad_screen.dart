import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_colors.dart';
import '../../services/database_service.dart';
import '../../services/auth_service.dart';
import '../../models/squad.dart';
import 'create_squad_screen.dart';

class SquadScreen extends StatefulWidget {
  const SquadScreen({super.key});

  @override
  State<SquadScreen> createState() => _SquadScreenState();
}

class _SquadScreenState extends State<SquadScreen> {
  final _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Map<String, dynamic>?>(
        stream: _db.streamMySquad(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final squadData = snapshot.data;
          
          if (squadData == null) {
            return _buildNoSquadView(context);
          }

          final squad = Squad.fromJson(squadData);
          
          // Initialize presence for this squad
          // This might be called multiple times, DatabaseService handles cleanup
          _db.initializePresence(squad.id);

          return ValueListenableBuilder<Map<String, Map<String, dynamic>>>(
            valueListenable: _db.presenceState,
            builder: (context, presenceMap, child) {
              return _buildSquadDashboard(context, squad, presenceMap);
            },
          );
        },
      ),
    );
  }

  Widget _buildNoSquadView(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.groups_3_rounded, size: 80, color: AppColors.textSecondary),
            const SizedBox(height: 24),
            const Text(
              "Flying Solo",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              "Fitness is better with a Pack.\nJoin a squad or start your own.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 48),
            
            // Create Squad Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CreateSquadScreen()),
                  );
                },
                child: const Text("Create a Squad"),
              ),
            ),
            const SizedBox(height: 16),
            
            // Join Squad Button (Outlined)
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: () => _showJoinUi(context),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  side: const BorderSide(color: AppColors.primary),
                ),
                child: const Text("Join with Code"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showJoinUi(BuildContext context) {
    final codeController = TextEditingController();
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          top: 24, left: 24, right: 24
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Text("Enter Invite Code", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
             const SizedBox(height: 12),
             TextField(
               controller: codeController,
               decoration: const InputDecoration(
                 hintText: "e.g. 8329XW",
                 border: OutlineInputBorder(),
               ),
             ),
             const SizedBox(height: 24),
             SizedBox(
               width: double.infinity,
               height: 50,
               child: ElevatedButton(
                 onPressed: () async {
                   final success = await _db.joinSquad(codeController.text.trim());
                   Navigator.pop(ctx);
                   if (!success) {
                     ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text("Invalid code or already in squad.")),
                     );
                   }
                 }, 
                 child: const Text("Join Pack")
               ),
             ),
          ],
        ),
      ),
    );
  }

  void _showShareModal(BuildContext context, Squad squad) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Icon(Icons.groups_rounded, size: 48, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(
              "Invite to ${squad.name}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Share this code with friends",
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            // Big invite code display
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: [
                  Text(
                    squad.inviteCode,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text("INVITE CODE", style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Copy button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: squad.inviteCode));
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Invite code copied! 📋"),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
                icon: const Icon(Icons.copy),
                label: const Text("Copy Code"),
              ),
            ),
            const SizedBox(height: 12),
            // Share message button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  // Could integrate with share_plus package for native sharing
                  Clipboard.setData(ClipboardData(
                    text: "Join my Sweat Pals squad '${squad.name}'! Use code: ${squad.inviteCode}",
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Message copied! Share with friends 💪"),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
                icon: const Icon(Icons.message),
                label: const Text("Copy Invite Message"),
              ),
            ),
            SizedBox(height: MediaQuery.of(ctx).padding.bottom + 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSquadDashboard(BuildContext context, Squad squad, Map<String, Map<String, dynamic>> presenceMap) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 120,
          floating: true,
          pinned: true,
          backgroundColor: squad.isWolfPack ? Colors.red[900] : AppColors.primary,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(squad.name),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: squad.isWolfPack 
                    ? [Colors.red, Colors.red[900]!] 
                    : [Colors.blue, Colors.blue[900]!],
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () => _showShareModal(context, squad),
            ),
          ],
        ),
        
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: StreamBuilder<List<Map<String, dynamic>>>(
            stream: _db.streamSquadMembers(squad.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SliverToBoxAdapter(child: LinearProgressIndicator());
              
              final members = snapshot.data!;
              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final member = members[index];
                    final userId = member['user_id'] as String;
                    final presence = presenceMap[userId];
                    
                    return _SquadMemberTile(
                      member: member, 
                      isWolfPack: squad.isWolfPack,
                      presence: presence,
                    );
                  },
                  childCount: members.length,
                ),
              );
            },
          ),
        ),

        // Chat Teaser
        StreamBuilder<List<Map<String, dynamic>>>(
          stream: _db.streamSquadMembers(squad.id),
          builder: (context, membersSnapshot) {
            if (!membersSnapshot.hasData) return const SliverToBoxAdapter(child: SizedBox.shrink());
            
            final members = membersSnapshot.data!;
            final ghostCount = members.where((m) => m['status'] == 'ghost').length;
            final totalMembers = members.length;
            
            // Only show locked message for Wolf Pack tier
            if (!squad.isWolfPack || ghostCount == 0) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Navigate to chat
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Chat coming soon!')),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.success.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.chat_bubble_rounded, color: AppColors.success),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Chat is unlocked! Tap to start.",
                              style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(Icons.chevron_right, color: AppColors.success),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.lock_rounded, color: AppColors.textSecondary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          ghostCount == 1
                            ? "Chat locked. 1 ghost hasn't paid rent."
                            : "Chat locked. $ghostCount ghosts haven't paid rent.",
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SquadMemberTile extends StatelessWidget {
  final Map<String, dynamic> member;
  final bool isWolfPack;
  final Map<String, dynamic>? presence; // e.g. {'status': 'online'}

  const _SquadMemberTile({required this.member, required this.isWolfPack, this.presence});

  @override
  Widget build(BuildContext context) {
    final status = member['status']; // 'active', 'ghost'
    final isActive = status == 'active';
    final userId = member['user_id'];

    return FutureBuilder<Map<String, dynamic>?>(
      future: DatabaseService().getProfile(userId),
      builder: (context, snapshot) {
        final profile = snapshot.data;
        // Fall back to email prefix or 'Pal' if no name
        String name = profile?['name'] ?? 'Pal';
        if (name == 'Pal' || name.isEmpty) {
          // Try to get first part of email as fallback
          name = 'Pal ${userId.length >= 4 ? userId.substring(0, 4) : userId}';
        }
        
        return FutureBuilder<int>(
          future: DatabaseService().getWeeklyWorkoutCount(userId),
          builder: (context, workoutSnapshot) {
            final workoutCount = workoutSnapshot.data ?? 0;
            
            return GestureDetector(
              onTap: () async {
                // Don't nudge yourself
                if (userId == AuthService().currentUserId) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("That's you, pal! 😄")),
                  );
                  return;
                }
                
                try {
                  await DatabaseService().sendNudge(userId);
                  HapticFeedback.mediumImpact();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Nudged $name! 👆'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not nudge: $e')),
                  );
                }
              },
              child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.cardBackground : AppColors.divider,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isActive ? AppColors.primary : AppColors.textSecondary,
                      width: isActive ? 2 : 1,
                    ),
                    boxShadow: isActive ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ] : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: isActive ? AppColors.divider : AppColors.textSecondary,
                        child: Text(
                          name.isNotEmpty ? name.substring(0, 1).toUpperCase() : '?',
                          style: TextStyle(
                            fontSize: 20,
                            color: isActive ? AppColors.textPrimary : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      
                      // Presence Indicator
                      if (presence != null)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: presence!['status'] == 'working_out' 
                                  ? Colors.purpleAccent 
                                  : Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: (presence!['status'] == 'working_out' 
                                      ? Colors.purpleAccent 
                                      : Colors.green).withOpacity(0.5),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: presence!['status'] == 'working_out'
                                ? const Icon(Icons.bolt, size: 8, color: Colors.white)
                                : null,
                          ),
                        ),
                      const SizedBox(height: 6),
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.fitness_center, size: 12, color: AppColors.primary),
                          const SizedBox(width: 2),
                          Text(
                            '$workoutCount this week',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Crown for top performer (show if workoutCount > 0)
                if (workoutCount > 0)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '🔥$workoutCount',
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
              ),
            );
          },
        );
      },
    );
  }
}
