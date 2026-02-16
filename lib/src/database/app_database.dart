import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// --- Type Converters ---
class MapConverter extends TypeConverter<Map<String, dynamic>, String> {
  const MapConverter();
  @override
  Map<String, dynamic> fromSql(String fromDb) => json.decode(fromDb) as Map<String, dynamic>;
  @override
  String toSql(Map<String, dynamic> value) => json.encode(value);
}

class ListConverter extends TypeConverter<List<String>, String> {
  const ListConverter();
  @override
  List<String> fromSql(String fromDb) => List<String>.from(json.decode(fromDb));
  @override
  String toSql(List<String> value) => json.encode(value);
}

// --- Tables ---

class Users extends Table {
  TextColumn get id => text()(); // UUID from Supabase or generated locally
  TextColumn get email => text().nullable()();
  TextColumn get name => text().withDefault(const Constant('New User'))();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get fitnessLevel => text().withDefault(const Constant('beginner'))(); // stored as string
  TextColumn get gender => text().withDefault(const Constant('prefer_not_to_say'))();
  TextColumn get bio => text().nullable()();
  IntColumn get sweatCoins => integer().withDefault(const Constant(0))();
  IntColumn get dailyStreak => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastCheckIn => dateTime().nullable()(); // For streak calc
  TextColumn get preferredWorkoutHour => text().withDefault(const Constant('08:00'))();
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  TextColumn get aiTrainerMode => text().withDefault(const Constant('friend'))();
  TextColumn get partnerId => text().nullable()();
  
  // Missing Profile Fields
  RealColumn get startingWeight => real().withDefault(const Constant(70.0))();
  RealColumn get targetWeight => real().withDefault(const Constant(70.0))();
  RealColumn get height => real().withDefault(const Constant(170.0))(); // cm
  IntColumn get age => integer().withDefault(const Constant(25))();
  TextColumn get foodsToAvoid => text().withDefault(const Constant(''))();
  DateTimeColumn get startDate => dateTime().withDefault(currentDateAndTime)();
  IntColumn get restTokens => integer().withDefault(const Constant(3))();
  TextColumn get subscriptionTier => text().withDefault(const Constant('free'))();
  RealColumn get consistencyScore => real().withDefault(const Constant(0.0))();
  TextColumn get timezone => text().nullable()();
  TextColumn get inviteCode => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class DailyCheckInsTable extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  BoolColumn get moodGood => boolean().withDefault(const Constant(false))();
  IntColumn get energyLevel => integer().withDefault(const Constant(5))(); // 1-10
  RealColumn get weight => real().nullable()(); // kg/lbs
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncQueue extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()(); // 'log_workout', 'profile_update'
  TextColumn get payload => text().map(const MapConverter())(); // JSON payload
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Workout completion records (workout progress tracking)
class WorkoutSessionsTable extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get workoutId => text()(); // References the hardcoded or custom workout
  DateTimeColumn get completedAt => dateTime()();
  IntColumn get durationMinutes => integer().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Scheduled workouts for calendar
class ScheduledWorkoutsTable extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get workoutId => text()();
  DateTimeColumn get scheduledDate => dateTime()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Progress photos
class ProgressPhotosTable extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get imagePath => text()(); // Local file path
  RealColumn get weight => real().nullable()();
  TextColumn get notes => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}

// Journal entries
class JournalEntriesTable extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get content => text()();
  TextColumn get mood => text()(); // 'happy', 'motivated', 'tired', etc.
  DateTimeColumn get entryDateTime => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Weekly reviews
class WeeklyReviewsTable extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get date => dateTime()();
  RealColumn get weight => real()();
  RealColumn get waist => real()();
  IntColumn get consistencyScore => integer()(); // 1-10
  TextColumn get notes => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}

// Custom workouts created by users
class CustomWorkoutsTable extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get exercises => text().map(const MapConverter())(); // JSON array of exercises
  IntColumn get estimatedDuration => integer().nullable()();
  TextColumn get difficulty => text().withDefault(const Constant('beginner'))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class PactsTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get squadId => text().nullable()(); // Links to the squad/partner
  TextColumn get frequency => text()(); // 'daily', 'weekly'
  IntColumn get targetCount => integer()(); // e.g., 3 workouts/week
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  TextColumn get status => text().withDefault(const Constant('active'))(); // 'active', 'failed', 'completed'
  DateTimeColumn get lastCheckedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  RealColumn get wagerAmount => real().withDefault(const Constant(0.0))();
  DateTimeColumn get deadline => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class SquadsTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get inviteCode => text().nullable()();
  TextColumn get tier => text().withDefault(const Constant('social'))();
  TextColumn get members => text().map(const ListConverter())(); // JSON list of user IDs
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [
  Users,
  DailyCheckInsTable,
  SyncQueue,
  WorkoutSessionsTable,
  ScheduledWorkoutsTable,
  ProgressPhotosTable,
  JournalEntriesTable,
  WeeklyReviewsTable,
  CustomWorkoutsTable,
  PactsTable,
  SquadsTable,
])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class is where you write queries.
  // The `_$AppDatabase` mixin is generated by drift.

  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 3) {
        // Add new columns to users table
        await m.addColumn(users, users.startingWeight);
        await m.addColumn(users, users.targetWeight);
        await m.addColumn(users, users.height);
        await m.addColumn(users, users.age);
        await m.addColumn(users, users.foodsToAvoid);
        await m.addColumn(users, users.startDate);
        await m.addColumn(users, users.restTokens);
        await m.addColumn(users, users.subscriptionTier);
        await m.addColumn(users, users.consistencyScore);
        await m.addColumn(users, users.timezone);
        await m.addColumn(users, users.inviteCode);
      }
      
      if (from < 4) {
        // Schema v4: Pacts and Squads
        await m.createTable(pactsTable);
        await m.createTable(squadsTable);
      }
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'sweat_pals_db',
      native: const DriftNativeOptions(
        // By default, drift uses the application documents directory.
      ),
    );
  }
}
