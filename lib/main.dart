import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'src/app.dart';
import 'src/services/notifications_service.dart';
import 'src/database/app_database.dart';

// Global database provider
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    debugPrint('Sweat Pals starting up...');

    // Initialize Supabase
    await Supabase.initialize(
      url: 'https://ymvnavmvipzpuynlqode.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inltdm5hdm12aXB6cHV5bmxxb2RlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjczNzg3NzksImV4cCI6MjA4Mjk1NDc3OX0.QoF6_H_hjZnFLQvNVnE9nYqNsIM3gf5QrNUbFQrbfgE',
    );
    debugPrint('Supabase initialized.');

    // TEMPORARY: Comment out to find initialization hang
    // Initialize Notifications
    await NotificationsService.init();
    debugPrint('Notifications initialized.');
    
    // Drift database will be initialized lazily by the provider
    debugPrint('Drift database ready (lazy init).');

    // TEMPORARY: Commented out to prevent app hang during startup
    // TODO: Fix SyncQueueService initialization
    // Sync Queue initialization handled in MainShell
    debugPrint('Sync Queue initialized in MainShell.');

    
    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  } catch (e, stack) {
    debugPrint('FATAL ERROR DURING STARTUP: $e');
    debugPrint(stack.toString());
    runApp(MaterialApp(home: Scaffold(body: Center(child: Text('Pal, we had a major snag! Check logs: $e')))));
  }
}
