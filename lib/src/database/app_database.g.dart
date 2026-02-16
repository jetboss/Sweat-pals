// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('New User'),
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fitnessLevelMeta = const VerificationMeta(
    'fitnessLevel',
  );
  @override
  late final GeneratedColumn<String> fitnessLevel = GeneratedColumn<String>(
    'fitness_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('beginner'),
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('prefer_not_to_say'),
  );
  static const VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedColumn<String> bio = GeneratedColumn<String>(
    'bio',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sweatCoinsMeta = const VerificationMeta(
    'sweatCoins',
  );
  @override
  late final GeneratedColumn<int> sweatCoins = GeneratedColumn<int>(
    'sweat_coins',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _dailyStreakMeta = const VerificationMeta(
    'dailyStreak',
  );
  @override
  late final GeneratedColumn<int> dailyStreak = GeneratedColumn<int>(
    'daily_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastCheckInMeta = const VerificationMeta(
    'lastCheckIn',
  );
  @override
  late final GeneratedColumn<DateTime> lastCheckIn = GeneratedColumn<DateTime>(
    'last_check_in',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _preferredWorkoutHourMeta =
      const VerificationMeta('preferredWorkoutHour');
  @override
  late final GeneratedColumn<String> preferredWorkoutHour =
      GeneratedColumn<String>(
        'preferred_workout_hour',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('08:00'),
      );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _aiTrainerModeMeta = const VerificationMeta(
    'aiTrainerMode',
  );
  @override
  late final GeneratedColumn<String> aiTrainerMode = GeneratedColumn<String>(
    'ai_trainer_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('friend'),
  );
  static const VerificationMeta _partnerIdMeta = const VerificationMeta(
    'partnerId',
  );
  @override
  late final GeneratedColumn<String> partnerId = GeneratedColumn<String>(
    'partner_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startingWeightMeta = const VerificationMeta(
    'startingWeight',
  );
  @override
  late final GeneratedColumn<double> startingWeight = GeneratedColumn<double>(
    'starting_weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(70.0),
  );
  static const VerificationMeta _targetWeightMeta = const VerificationMeta(
    'targetWeight',
  );
  @override
  late final GeneratedColumn<double> targetWeight = GeneratedColumn<double>(
    'target_weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(70.0),
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
    'height',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(170.0),
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(25),
  );
  static const VerificationMeta _foodsToAvoidMeta = const VerificationMeta(
    'foodsToAvoid',
  );
  @override
  late final GeneratedColumn<String> foodsToAvoid = GeneratedColumn<String>(
    'foods_to_avoid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _restTokensMeta = const VerificationMeta(
    'restTokens',
  );
  @override
  late final GeneratedColumn<int> restTokens = GeneratedColumn<int>(
    'rest_tokens',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _subscriptionTierMeta = const VerificationMeta(
    'subscriptionTier',
  );
  @override
  late final GeneratedColumn<String> subscriptionTier = GeneratedColumn<String>(
    'subscription_tier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('free'),
  );
  static const VerificationMeta _consistencyScoreMeta = const VerificationMeta(
    'consistencyScore',
  );
  @override
  late final GeneratedColumn<double> consistencyScore = GeneratedColumn<double>(
    'consistency_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _inviteCodeMeta = const VerificationMeta(
    'inviteCode',
  );
  @override
  late final GeneratedColumn<String> inviteCode = GeneratedColumn<String>(
    'invite_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    email,
    name,
    avatarUrl,
    fitnessLevel,
    gender,
    bio,
    sweatCoins,
    dailyStreak,
    lastCheckIn,
    preferredWorkoutHour,
    themeMode,
    aiTrainerMode,
    partnerId,
    startingWeight,
    targetWeight,
    height,
    age,
    foodsToAvoid,
    startDate,
    restTokens,
    subscriptionTier,
    consistencyScore,
    timezone,
    inviteCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('fitness_level')) {
      context.handle(
        _fitnessLevelMeta,
        fitnessLevel.isAcceptableOrUnknown(
          data['fitness_level']!,
          _fitnessLevelMeta,
        ),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('bio')) {
      context.handle(
        _bioMeta,
        bio.isAcceptableOrUnknown(data['bio']!, _bioMeta),
      );
    }
    if (data.containsKey('sweat_coins')) {
      context.handle(
        _sweatCoinsMeta,
        sweatCoins.isAcceptableOrUnknown(data['sweat_coins']!, _sweatCoinsMeta),
      );
    }
    if (data.containsKey('daily_streak')) {
      context.handle(
        _dailyStreakMeta,
        dailyStreak.isAcceptableOrUnknown(
          data['daily_streak']!,
          _dailyStreakMeta,
        ),
      );
    }
    if (data.containsKey('last_check_in')) {
      context.handle(
        _lastCheckInMeta,
        lastCheckIn.isAcceptableOrUnknown(
          data['last_check_in']!,
          _lastCheckInMeta,
        ),
      );
    }
    if (data.containsKey('preferred_workout_hour')) {
      context.handle(
        _preferredWorkoutHourMeta,
        preferredWorkoutHour.isAcceptableOrUnknown(
          data['preferred_workout_hour']!,
          _preferredWorkoutHourMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('ai_trainer_mode')) {
      context.handle(
        _aiTrainerModeMeta,
        aiTrainerMode.isAcceptableOrUnknown(
          data['ai_trainer_mode']!,
          _aiTrainerModeMeta,
        ),
      );
    }
    if (data.containsKey('partner_id')) {
      context.handle(
        _partnerIdMeta,
        partnerId.isAcceptableOrUnknown(data['partner_id']!, _partnerIdMeta),
      );
    }
    if (data.containsKey('starting_weight')) {
      context.handle(
        _startingWeightMeta,
        startingWeight.isAcceptableOrUnknown(
          data['starting_weight']!,
          _startingWeightMeta,
        ),
      );
    }
    if (data.containsKey('target_weight')) {
      context.handle(
        _targetWeightMeta,
        targetWeight.isAcceptableOrUnknown(
          data['target_weight']!,
          _targetWeightMeta,
        ),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    }
    if (data.containsKey('foods_to_avoid')) {
      context.handle(
        _foodsToAvoidMeta,
        foodsToAvoid.isAcceptableOrUnknown(
          data['foods_to_avoid']!,
          _foodsToAvoidMeta,
        ),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('rest_tokens')) {
      context.handle(
        _restTokensMeta,
        restTokens.isAcceptableOrUnknown(data['rest_tokens']!, _restTokensMeta),
      );
    }
    if (data.containsKey('subscription_tier')) {
      context.handle(
        _subscriptionTierMeta,
        subscriptionTier.isAcceptableOrUnknown(
          data['subscription_tier']!,
          _subscriptionTierMeta,
        ),
      );
    }
    if (data.containsKey('consistency_score')) {
      context.handle(
        _consistencyScoreMeta,
        consistencyScore.isAcceptableOrUnknown(
          data['consistency_score']!,
          _consistencyScoreMeta,
        ),
      );
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    }
    if (data.containsKey('invite_code')) {
      context.handle(
        _inviteCodeMeta,
        inviteCode.isAcceptableOrUnknown(data['invite_code']!, _inviteCodeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      fitnessLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fitness_level'],
      )!,
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      )!,
      bio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bio'],
      ),
      sweatCoins: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sweat_coins'],
      )!,
      dailyStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_streak'],
      )!,
      lastCheckIn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_check_in'],
      ),
      preferredWorkoutHour: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_workout_hour'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      aiTrainerMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ai_trainer_mode'],
      )!,
      partnerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}partner_id'],
      ),
      startingWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}starting_weight'],
      )!,
      targetWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_weight'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      )!,
      foodsToAvoid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}foods_to_avoid'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      restTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rest_tokens'],
      )!,
      subscriptionTier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subscription_tier'],
      )!,
      consistencyScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}consistency_score'],
      )!,
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      ),
      inviteCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invite_code'],
      ),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String? email;
  final String name;
  final String? avatarUrl;
  final String fitnessLevel;
  final String gender;
  final String? bio;
  final int sweatCoins;
  final int dailyStreak;
  final DateTime? lastCheckIn;
  final String preferredWorkoutHour;
  final String themeMode;
  final String aiTrainerMode;
  final String? partnerId;
  final double startingWeight;
  final double targetWeight;
  final double height;
  final int age;
  final String foodsToAvoid;
  final DateTime startDate;
  final int restTokens;
  final String subscriptionTier;
  final double consistencyScore;
  final String? timezone;
  final String? inviteCode;
  const User({
    required this.id,
    this.email,
    required this.name,
    this.avatarUrl,
    required this.fitnessLevel,
    required this.gender,
    this.bio,
    required this.sweatCoins,
    required this.dailyStreak,
    this.lastCheckIn,
    required this.preferredWorkoutHour,
    required this.themeMode,
    required this.aiTrainerMode,
    this.partnerId,
    required this.startingWeight,
    required this.targetWeight,
    required this.height,
    required this.age,
    required this.foodsToAvoid,
    required this.startDate,
    required this.restTokens,
    required this.subscriptionTier,
    required this.consistencyScore,
    this.timezone,
    this.inviteCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['fitness_level'] = Variable<String>(fitnessLevel);
    map['gender'] = Variable<String>(gender);
    if (!nullToAbsent || bio != null) {
      map['bio'] = Variable<String>(bio);
    }
    map['sweat_coins'] = Variable<int>(sweatCoins);
    map['daily_streak'] = Variable<int>(dailyStreak);
    if (!nullToAbsent || lastCheckIn != null) {
      map['last_check_in'] = Variable<DateTime>(lastCheckIn);
    }
    map['preferred_workout_hour'] = Variable<String>(preferredWorkoutHour);
    map['theme_mode'] = Variable<String>(themeMode);
    map['ai_trainer_mode'] = Variable<String>(aiTrainerMode);
    if (!nullToAbsent || partnerId != null) {
      map['partner_id'] = Variable<String>(partnerId);
    }
    map['starting_weight'] = Variable<double>(startingWeight);
    map['target_weight'] = Variable<double>(targetWeight);
    map['height'] = Variable<double>(height);
    map['age'] = Variable<int>(age);
    map['foods_to_avoid'] = Variable<String>(foodsToAvoid);
    map['start_date'] = Variable<DateTime>(startDate);
    map['rest_tokens'] = Variable<int>(restTokens);
    map['subscription_tier'] = Variable<String>(subscriptionTier);
    map['consistency_score'] = Variable<double>(consistencyScore);
    if (!nullToAbsent || timezone != null) {
      map['timezone'] = Variable<String>(timezone);
    }
    if (!nullToAbsent || inviteCode != null) {
      map['invite_code'] = Variable<String>(inviteCode);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      name: Value(name),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      fitnessLevel: Value(fitnessLevel),
      gender: Value(gender),
      bio: bio == null && nullToAbsent ? const Value.absent() : Value(bio),
      sweatCoins: Value(sweatCoins),
      dailyStreak: Value(dailyStreak),
      lastCheckIn: lastCheckIn == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCheckIn),
      preferredWorkoutHour: Value(preferredWorkoutHour),
      themeMode: Value(themeMode),
      aiTrainerMode: Value(aiTrainerMode),
      partnerId: partnerId == null && nullToAbsent
          ? const Value.absent()
          : Value(partnerId),
      startingWeight: Value(startingWeight),
      targetWeight: Value(targetWeight),
      height: Value(height),
      age: Value(age),
      foodsToAvoid: Value(foodsToAvoid),
      startDate: Value(startDate),
      restTokens: Value(restTokens),
      subscriptionTier: Value(subscriptionTier),
      consistencyScore: Value(consistencyScore),
      timezone: timezone == null && nullToAbsent
          ? const Value.absent()
          : Value(timezone),
      inviteCode: inviteCode == null && nullToAbsent
          ? const Value.absent()
          : Value(inviteCode),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String?>(json['email']),
      name: serializer.fromJson<String>(json['name']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      fitnessLevel: serializer.fromJson<String>(json['fitnessLevel']),
      gender: serializer.fromJson<String>(json['gender']),
      bio: serializer.fromJson<String?>(json['bio']),
      sweatCoins: serializer.fromJson<int>(json['sweatCoins']),
      dailyStreak: serializer.fromJson<int>(json['dailyStreak']),
      lastCheckIn: serializer.fromJson<DateTime?>(json['lastCheckIn']),
      preferredWorkoutHour: serializer.fromJson<String>(
        json['preferredWorkoutHour'],
      ),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      aiTrainerMode: serializer.fromJson<String>(json['aiTrainerMode']),
      partnerId: serializer.fromJson<String?>(json['partnerId']),
      startingWeight: serializer.fromJson<double>(json['startingWeight']),
      targetWeight: serializer.fromJson<double>(json['targetWeight']),
      height: serializer.fromJson<double>(json['height']),
      age: serializer.fromJson<int>(json['age']),
      foodsToAvoid: serializer.fromJson<String>(json['foodsToAvoid']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      restTokens: serializer.fromJson<int>(json['restTokens']),
      subscriptionTier: serializer.fromJson<String>(json['subscriptionTier']),
      consistencyScore: serializer.fromJson<double>(json['consistencyScore']),
      timezone: serializer.fromJson<String?>(json['timezone']),
      inviteCode: serializer.fromJson<String?>(json['inviteCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String?>(email),
      'name': serializer.toJson<String>(name),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'fitnessLevel': serializer.toJson<String>(fitnessLevel),
      'gender': serializer.toJson<String>(gender),
      'bio': serializer.toJson<String?>(bio),
      'sweatCoins': serializer.toJson<int>(sweatCoins),
      'dailyStreak': serializer.toJson<int>(dailyStreak),
      'lastCheckIn': serializer.toJson<DateTime?>(lastCheckIn),
      'preferredWorkoutHour': serializer.toJson<String>(preferredWorkoutHour),
      'themeMode': serializer.toJson<String>(themeMode),
      'aiTrainerMode': serializer.toJson<String>(aiTrainerMode),
      'partnerId': serializer.toJson<String?>(partnerId),
      'startingWeight': serializer.toJson<double>(startingWeight),
      'targetWeight': serializer.toJson<double>(targetWeight),
      'height': serializer.toJson<double>(height),
      'age': serializer.toJson<int>(age),
      'foodsToAvoid': serializer.toJson<String>(foodsToAvoid),
      'startDate': serializer.toJson<DateTime>(startDate),
      'restTokens': serializer.toJson<int>(restTokens),
      'subscriptionTier': serializer.toJson<String>(subscriptionTier),
      'consistencyScore': serializer.toJson<double>(consistencyScore),
      'timezone': serializer.toJson<String?>(timezone),
      'inviteCode': serializer.toJson<String?>(inviteCode),
    };
  }

  User copyWith({
    String? id,
    Value<String?> email = const Value.absent(),
    String? name,
    Value<String?> avatarUrl = const Value.absent(),
    String? fitnessLevel,
    String? gender,
    Value<String?> bio = const Value.absent(),
    int? sweatCoins,
    int? dailyStreak,
    Value<DateTime?> lastCheckIn = const Value.absent(),
    String? preferredWorkoutHour,
    String? themeMode,
    String? aiTrainerMode,
    Value<String?> partnerId = const Value.absent(),
    double? startingWeight,
    double? targetWeight,
    double? height,
    int? age,
    String? foodsToAvoid,
    DateTime? startDate,
    int? restTokens,
    String? subscriptionTier,
    double? consistencyScore,
    Value<String?> timezone = const Value.absent(),
    Value<String?> inviteCode = const Value.absent(),
  }) => User(
    id: id ?? this.id,
    email: email.present ? email.value : this.email,
    name: name ?? this.name,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    fitnessLevel: fitnessLevel ?? this.fitnessLevel,
    gender: gender ?? this.gender,
    bio: bio.present ? bio.value : this.bio,
    sweatCoins: sweatCoins ?? this.sweatCoins,
    dailyStreak: dailyStreak ?? this.dailyStreak,
    lastCheckIn: lastCheckIn.present ? lastCheckIn.value : this.lastCheckIn,
    preferredWorkoutHour: preferredWorkoutHour ?? this.preferredWorkoutHour,
    themeMode: themeMode ?? this.themeMode,
    aiTrainerMode: aiTrainerMode ?? this.aiTrainerMode,
    partnerId: partnerId.present ? partnerId.value : this.partnerId,
    startingWeight: startingWeight ?? this.startingWeight,
    targetWeight: targetWeight ?? this.targetWeight,
    height: height ?? this.height,
    age: age ?? this.age,
    foodsToAvoid: foodsToAvoid ?? this.foodsToAvoid,
    startDate: startDate ?? this.startDate,
    restTokens: restTokens ?? this.restTokens,
    subscriptionTier: subscriptionTier ?? this.subscriptionTier,
    consistencyScore: consistencyScore ?? this.consistencyScore,
    timezone: timezone.present ? timezone.value : this.timezone,
    inviteCode: inviteCode.present ? inviteCode.value : this.inviteCode,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      name: data.name.present ? data.name.value : this.name,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      fitnessLevel: data.fitnessLevel.present
          ? data.fitnessLevel.value
          : this.fitnessLevel,
      gender: data.gender.present ? data.gender.value : this.gender,
      bio: data.bio.present ? data.bio.value : this.bio,
      sweatCoins: data.sweatCoins.present
          ? data.sweatCoins.value
          : this.sweatCoins,
      dailyStreak: data.dailyStreak.present
          ? data.dailyStreak.value
          : this.dailyStreak,
      lastCheckIn: data.lastCheckIn.present
          ? data.lastCheckIn.value
          : this.lastCheckIn,
      preferredWorkoutHour: data.preferredWorkoutHour.present
          ? data.preferredWorkoutHour.value
          : this.preferredWorkoutHour,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      aiTrainerMode: data.aiTrainerMode.present
          ? data.aiTrainerMode.value
          : this.aiTrainerMode,
      partnerId: data.partnerId.present ? data.partnerId.value : this.partnerId,
      startingWeight: data.startingWeight.present
          ? data.startingWeight.value
          : this.startingWeight,
      targetWeight: data.targetWeight.present
          ? data.targetWeight.value
          : this.targetWeight,
      height: data.height.present ? data.height.value : this.height,
      age: data.age.present ? data.age.value : this.age,
      foodsToAvoid: data.foodsToAvoid.present
          ? data.foodsToAvoid.value
          : this.foodsToAvoid,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      restTokens: data.restTokens.present
          ? data.restTokens.value
          : this.restTokens,
      subscriptionTier: data.subscriptionTier.present
          ? data.subscriptionTier.value
          : this.subscriptionTier,
      consistencyScore: data.consistencyScore.present
          ? data.consistencyScore.value
          : this.consistencyScore,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      inviteCode: data.inviteCode.present
          ? data.inviteCode.value
          : this.inviteCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('fitnessLevel: $fitnessLevel, ')
          ..write('gender: $gender, ')
          ..write('bio: $bio, ')
          ..write('sweatCoins: $sweatCoins, ')
          ..write('dailyStreak: $dailyStreak, ')
          ..write('lastCheckIn: $lastCheckIn, ')
          ..write('preferredWorkoutHour: $preferredWorkoutHour, ')
          ..write('themeMode: $themeMode, ')
          ..write('aiTrainerMode: $aiTrainerMode, ')
          ..write('partnerId: $partnerId, ')
          ..write('startingWeight: $startingWeight, ')
          ..write('targetWeight: $targetWeight, ')
          ..write('height: $height, ')
          ..write('age: $age, ')
          ..write('foodsToAvoid: $foodsToAvoid, ')
          ..write('startDate: $startDate, ')
          ..write('restTokens: $restTokens, ')
          ..write('subscriptionTier: $subscriptionTier, ')
          ..write('consistencyScore: $consistencyScore, ')
          ..write('timezone: $timezone, ')
          ..write('inviteCode: $inviteCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    email,
    name,
    avatarUrl,
    fitnessLevel,
    gender,
    bio,
    sweatCoins,
    dailyStreak,
    lastCheckIn,
    preferredWorkoutHour,
    themeMode,
    aiTrainerMode,
    partnerId,
    startingWeight,
    targetWeight,
    height,
    age,
    foodsToAvoid,
    startDate,
    restTokens,
    subscriptionTier,
    consistencyScore,
    timezone,
    inviteCode,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.email == this.email &&
          other.name == this.name &&
          other.avatarUrl == this.avatarUrl &&
          other.fitnessLevel == this.fitnessLevel &&
          other.gender == this.gender &&
          other.bio == this.bio &&
          other.sweatCoins == this.sweatCoins &&
          other.dailyStreak == this.dailyStreak &&
          other.lastCheckIn == this.lastCheckIn &&
          other.preferredWorkoutHour == this.preferredWorkoutHour &&
          other.themeMode == this.themeMode &&
          other.aiTrainerMode == this.aiTrainerMode &&
          other.partnerId == this.partnerId &&
          other.startingWeight == this.startingWeight &&
          other.targetWeight == this.targetWeight &&
          other.height == this.height &&
          other.age == this.age &&
          other.foodsToAvoid == this.foodsToAvoid &&
          other.startDate == this.startDate &&
          other.restTokens == this.restTokens &&
          other.subscriptionTier == this.subscriptionTier &&
          other.consistencyScore == this.consistencyScore &&
          other.timezone == this.timezone &&
          other.inviteCode == this.inviteCode);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String?> email;
  final Value<String> name;
  final Value<String?> avatarUrl;
  final Value<String> fitnessLevel;
  final Value<String> gender;
  final Value<String?> bio;
  final Value<int> sweatCoins;
  final Value<int> dailyStreak;
  final Value<DateTime?> lastCheckIn;
  final Value<String> preferredWorkoutHour;
  final Value<String> themeMode;
  final Value<String> aiTrainerMode;
  final Value<String?> partnerId;
  final Value<double> startingWeight;
  final Value<double> targetWeight;
  final Value<double> height;
  final Value<int> age;
  final Value<String> foodsToAvoid;
  final Value<DateTime> startDate;
  final Value<int> restTokens;
  final Value<String> subscriptionTier;
  final Value<double> consistencyScore;
  final Value<String?> timezone;
  final Value<String?> inviteCode;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.name = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.fitnessLevel = const Value.absent(),
    this.gender = const Value.absent(),
    this.bio = const Value.absent(),
    this.sweatCoins = const Value.absent(),
    this.dailyStreak = const Value.absent(),
    this.lastCheckIn = const Value.absent(),
    this.preferredWorkoutHour = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.aiTrainerMode = const Value.absent(),
    this.partnerId = const Value.absent(),
    this.startingWeight = const Value.absent(),
    this.targetWeight = const Value.absent(),
    this.height = const Value.absent(),
    this.age = const Value.absent(),
    this.foodsToAvoid = const Value.absent(),
    this.startDate = const Value.absent(),
    this.restTokens = const Value.absent(),
    this.subscriptionTier = const Value.absent(),
    this.consistencyScore = const Value.absent(),
    this.timezone = const Value.absent(),
    this.inviteCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    this.email = const Value.absent(),
    this.name = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.fitnessLevel = const Value.absent(),
    this.gender = const Value.absent(),
    this.bio = const Value.absent(),
    this.sweatCoins = const Value.absent(),
    this.dailyStreak = const Value.absent(),
    this.lastCheckIn = const Value.absent(),
    this.preferredWorkoutHour = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.aiTrainerMode = const Value.absent(),
    this.partnerId = const Value.absent(),
    this.startingWeight = const Value.absent(),
    this.targetWeight = const Value.absent(),
    this.height = const Value.absent(),
    this.age = const Value.absent(),
    this.foodsToAvoid = const Value.absent(),
    this.startDate = const Value.absent(),
    this.restTokens = const Value.absent(),
    this.subscriptionTier = const Value.absent(),
    this.consistencyScore = const Value.absent(),
    this.timezone = const Value.absent(),
    this.inviteCode = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? name,
    Expression<String>? avatarUrl,
    Expression<String>? fitnessLevel,
    Expression<String>? gender,
    Expression<String>? bio,
    Expression<int>? sweatCoins,
    Expression<int>? dailyStreak,
    Expression<DateTime>? lastCheckIn,
    Expression<String>? preferredWorkoutHour,
    Expression<String>? themeMode,
    Expression<String>? aiTrainerMode,
    Expression<String>? partnerId,
    Expression<double>? startingWeight,
    Expression<double>? targetWeight,
    Expression<double>? height,
    Expression<int>? age,
    Expression<String>? foodsToAvoid,
    Expression<DateTime>? startDate,
    Expression<int>? restTokens,
    Expression<String>? subscriptionTier,
    Expression<double>? consistencyScore,
    Expression<String>? timezone,
    Expression<String>? inviteCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (fitnessLevel != null) 'fitness_level': fitnessLevel,
      if (gender != null) 'gender': gender,
      if (bio != null) 'bio': bio,
      if (sweatCoins != null) 'sweat_coins': sweatCoins,
      if (dailyStreak != null) 'daily_streak': dailyStreak,
      if (lastCheckIn != null) 'last_check_in': lastCheckIn,
      if (preferredWorkoutHour != null)
        'preferred_workout_hour': preferredWorkoutHour,
      if (themeMode != null) 'theme_mode': themeMode,
      if (aiTrainerMode != null) 'ai_trainer_mode': aiTrainerMode,
      if (partnerId != null) 'partner_id': partnerId,
      if (startingWeight != null) 'starting_weight': startingWeight,
      if (targetWeight != null) 'target_weight': targetWeight,
      if (height != null) 'height': height,
      if (age != null) 'age': age,
      if (foodsToAvoid != null) 'foods_to_avoid': foodsToAvoid,
      if (startDate != null) 'start_date': startDate,
      if (restTokens != null) 'rest_tokens': restTokens,
      if (subscriptionTier != null) 'subscription_tier': subscriptionTier,
      if (consistencyScore != null) 'consistency_score': consistencyScore,
      if (timezone != null) 'timezone': timezone,
      if (inviteCode != null) 'invite_code': inviteCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String?>? email,
    Value<String>? name,
    Value<String?>? avatarUrl,
    Value<String>? fitnessLevel,
    Value<String>? gender,
    Value<String?>? bio,
    Value<int>? sweatCoins,
    Value<int>? dailyStreak,
    Value<DateTime?>? lastCheckIn,
    Value<String>? preferredWorkoutHour,
    Value<String>? themeMode,
    Value<String>? aiTrainerMode,
    Value<String?>? partnerId,
    Value<double>? startingWeight,
    Value<double>? targetWeight,
    Value<double>? height,
    Value<int>? age,
    Value<String>? foodsToAvoid,
    Value<DateTime>? startDate,
    Value<int>? restTokens,
    Value<String>? subscriptionTier,
    Value<double>? consistencyScore,
    Value<String?>? timezone,
    Value<String?>? inviteCode,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      gender: gender ?? this.gender,
      bio: bio ?? this.bio,
      sweatCoins: sweatCoins ?? this.sweatCoins,
      dailyStreak: dailyStreak ?? this.dailyStreak,
      lastCheckIn: lastCheckIn ?? this.lastCheckIn,
      preferredWorkoutHour: preferredWorkoutHour ?? this.preferredWorkoutHour,
      themeMode: themeMode ?? this.themeMode,
      aiTrainerMode: aiTrainerMode ?? this.aiTrainerMode,
      partnerId: partnerId ?? this.partnerId,
      startingWeight: startingWeight ?? this.startingWeight,
      targetWeight: targetWeight ?? this.targetWeight,
      height: height ?? this.height,
      age: age ?? this.age,
      foodsToAvoid: foodsToAvoid ?? this.foodsToAvoid,
      startDate: startDate ?? this.startDate,
      restTokens: restTokens ?? this.restTokens,
      subscriptionTier: subscriptionTier ?? this.subscriptionTier,
      consistencyScore: consistencyScore ?? this.consistencyScore,
      timezone: timezone ?? this.timezone,
      inviteCode: inviteCode ?? this.inviteCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (fitnessLevel.present) {
      map['fitness_level'] = Variable<String>(fitnessLevel.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    if (sweatCoins.present) {
      map['sweat_coins'] = Variable<int>(sweatCoins.value);
    }
    if (dailyStreak.present) {
      map['daily_streak'] = Variable<int>(dailyStreak.value);
    }
    if (lastCheckIn.present) {
      map['last_check_in'] = Variable<DateTime>(lastCheckIn.value);
    }
    if (preferredWorkoutHour.present) {
      map['preferred_workout_hour'] = Variable<String>(
        preferredWorkoutHour.value,
      );
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (aiTrainerMode.present) {
      map['ai_trainer_mode'] = Variable<String>(aiTrainerMode.value);
    }
    if (partnerId.present) {
      map['partner_id'] = Variable<String>(partnerId.value);
    }
    if (startingWeight.present) {
      map['starting_weight'] = Variable<double>(startingWeight.value);
    }
    if (targetWeight.present) {
      map['target_weight'] = Variable<double>(targetWeight.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (foodsToAvoid.present) {
      map['foods_to_avoid'] = Variable<String>(foodsToAvoid.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (restTokens.present) {
      map['rest_tokens'] = Variable<int>(restTokens.value);
    }
    if (subscriptionTier.present) {
      map['subscription_tier'] = Variable<String>(subscriptionTier.value);
    }
    if (consistencyScore.present) {
      map['consistency_score'] = Variable<double>(consistencyScore.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (inviteCode.present) {
      map['invite_code'] = Variable<String>(inviteCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('fitnessLevel: $fitnessLevel, ')
          ..write('gender: $gender, ')
          ..write('bio: $bio, ')
          ..write('sweatCoins: $sweatCoins, ')
          ..write('dailyStreak: $dailyStreak, ')
          ..write('lastCheckIn: $lastCheckIn, ')
          ..write('preferredWorkoutHour: $preferredWorkoutHour, ')
          ..write('themeMode: $themeMode, ')
          ..write('aiTrainerMode: $aiTrainerMode, ')
          ..write('partnerId: $partnerId, ')
          ..write('startingWeight: $startingWeight, ')
          ..write('targetWeight: $targetWeight, ')
          ..write('height: $height, ')
          ..write('age: $age, ')
          ..write('foodsToAvoid: $foodsToAvoid, ')
          ..write('startDate: $startDate, ')
          ..write('restTokens: $restTokens, ')
          ..write('subscriptionTier: $subscriptionTier, ')
          ..write('consistencyScore: $consistencyScore, ')
          ..write('timezone: $timezone, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyCheckInsTableTable extends DailyCheckInsTable
    with TableInfo<$DailyCheckInsTableTable, DailyCheckInsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyCheckInsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moodGoodMeta = const VerificationMeta(
    'moodGood',
  );
  @override
  late final GeneratedColumn<bool> moodGood = GeneratedColumn<bool>(
    'mood_good',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("mood_good" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _energyLevelMeta = const VerificationMeta(
    'energyLevel',
  );
  @override
  late final GeneratedColumn<int> energyLevel = GeneratedColumn<int>(
    'energy_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    moodGood,
    energyLevel,
    weight,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_check_ins_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyCheckInsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('mood_good')) {
      context.handle(
        _moodGoodMeta,
        moodGood.isAcceptableOrUnknown(data['mood_good']!, _moodGoodMeta),
      );
    }
    if (data.containsKey('energy_level')) {
      context.handle(
        _energyLevelMeta,
        energyLevel.isAcceptableOrUnknown(
          data['energy_level']!,
          _energyLevelMeta,
        ),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyCheckInsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyCheckInsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      moodGood: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}mood_good'],
      )!,
      energyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}energy_level'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $DailyCheckInsTableTable createAlias(String alias) {
    return $DailyCheckInsTableTable(attachedDatabase, alias);
  }
}

class DailyCheckInsTableData extends DataClass
    implements Insertable<DailyCheckInsTableData> {
  final String id;
  final DateTime date;
  final bool moodGood;
  final int energyLevel;
  final double? weight;
  final String? notes;
  const DailyCheckInsTableData({
    required this.id,
    required this.date,
    required this.moodGood,
    required this.energyLevel,
    this.weight,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['mood_good'] = Variable<bool>(moodGood);
    map['energy_level'] = Variable<int>(energyLevel);
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  DailyCheckInsTableCompanion toCompanion(bool nullToAbsent) {
    return DailyCheckInsTableCompanion(
      id: Value(id),
      date: Value(date),
      moodGood: Value(moodGood),
      energyLevel: Value(energyLevel),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory DailyCheckInsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyCheckInsTableData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      moodGood: serializer.fromJson<bool>(json['moodGood']),
      energyLevel: serializer.fromJson<int>(json['energyLevel']),
      weight: serializer.fromJson<double?>(json['weight']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'moodGood': serializer.toJson<bool>(moodGood),
      'energyLevel': serializer.toJson<int>(energyLevel),
      'weight': serializer.toJson<double?>(weight),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  DailyCheckInsTableData copyWith({
    String? id,
    DateTime? date,
    bool? moodGood,
    int? energyLevel,
    Value<double?> weight = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => DailyCheckInsTableData(
    id: id ?? this.id,
    date: date ?? this.date,
    moodGood: moodGood ?? this.moodGood,
    energyLevel: energyLevel ?? this.energyLevel,
    weight: weight.present ? weight.value : this.weight,
    notes: notes.present ? notes.value : this.notes,
  );
  DailyCheckInsTableData copyWithCompanion(DailyCheckInsTableCompanion data) {
    return DailyCheckInsTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      moodGood: data.moodGood.present ? data.moodGood.value : this.moodGood,
      energyLevel: data.energyLevel.present
          ? data.energyLevel.value
          : this.energyLevel,
      weight: data.weight.present ? data.weight.value : this.weight,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyCheckInsTableData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('moodGood: $moodGood, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('weight: $weight, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, moodGood, energyLevel, weight, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyCheckInsTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.moodGood == this.moodGood &&
          other.energyLevel == this.energyLevel &&
          other.weight == this.weight &&
          other.notes == this.notes);
}

class DailyCheckInsTableCompanion
    extends UpdateCompanion<DailyCheckInsTableData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<bool> moodGood;
  final Value<int> energyLevel;
  final Value<double?> weight;
  final Value<String?> notes;
  final Value<int> rowid;
  const DailyCheckInsTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.moodGood = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.weight = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyCheckInsTableCompanion.insert({
    required String id,
    required DateTime date,
    this.moodGood = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.weight = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date);
  static Insertable<DailyCheckInsTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<bool>? moodGood,
    Expression<int>? energyLevel,
    Expression<double>? weight,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (moodGood != null) 'mood_good': moodGood,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (weight != null) 'weight': weight,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyCheckInsTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<bool>? moodGood,
    Value<int>? energyLevel,
    Value<double?>? weight,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return DailyCheckInsTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      moodGood: moodGood ?? this.moodGood,
      energyLevel: energyLevel ?? this.energyLevel,
      weight: weight ?? this.weight,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (moodGood.present) {
      map['mood_good'] = Variable<bool>(moodGood.value);
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<int>(energyLevel.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyCheckInsTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('moodGood: $moodGood, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('weight: $weight, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Map<String, dynamic>>($SyncQueueTable.$converterpayload);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, type, payload, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      payload: $SyncQueueTable.$converterpayload.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}payload'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>, String> $converterpayload =
      const MapConverter();
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final String id;
  final String type;
  final Map<String, dynamic> payload;
  final DateTime createdAt;
  const SyncQueueData({
    required this.id,
    required this.type,
    required this.payload,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    {
      map['payload'] = Variable<String>(
        $SyncQueueTable.$converterpayload.toSql(payload),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      type: Value(type),
      payload: Value(payload),
      createdAt: Value(createdAt),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      payload: serializer.fromJson<Map<String, dynamic>>(json['payload']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'payload': serializer.toJson<Map<String, dynamic>>(payload),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncQueueData copyWith({
    String? id,
    String? type,
    Map<String, dynamic>? payload,
    DateTime? createdAt,
  }) => SyncQueueData(
    id: id ?? this.id,
    type: type ?? this.type,
    payload: payload ?? this.payload,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, payload, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.type == this.type &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<String> id;
  final Value<String> type;
  final Value<Map<String, dynamic>> payload;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    required String id,
    required String type,
    required Map<String, dynamic> payload,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       payload = Value(payload),
       createdAt = Value(createdAt);
  static Insertable<SyncQueueData> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? payload,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<Map<String, dynamic>>? payload,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(
        $SyncQueueTable.$converterpayload.toSql(payload.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSessionsTableTable extends WorkoutSessionsTable
    with TableInfo<$WorkoutSessionsTableTable, WorkoutSessionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSessionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workoutIdMeta = const VerificationMeta(
    'workoutId',
  );
  @override
  late final GeneratedColumn<String> workoutId = GeneratedColumn<String>(
    'workout_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    workoutId,
    completedAt,
    durationMinutes,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sessions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutSessionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('workout_id')) {
      context.handle(
        _workoutIdMeta,
        workoutId.isAcceptableOrUnknown(data['workout_id']!, _workoutIdMeta),
      );
    } else if (isInserting) {
      context.missing(_workoutIdMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSessionsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSessionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      workoutId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_id'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $WorkoutSessionsTableTable createAlias(String alias) {
    return $WorkoutSessionsTableTable(attachedDatabase, alias);
  }
}

class WorkoutSessionsTableData extends DataClass
    implements Insertable<WorkoutSessionsTableData> {
  final String id;
  final String userId;
  final String workoutId;
  final DateTime completedAt;
  final int? durationMinutes;
  final String? notes;
  const WorkoutSessionsTableData({
    required this.id,
    required this.userId,
    required this.workoutId,
    required this.completedAt,
    this.durationMinutes,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['workout_id'] = Variable<String>(workoutId);
    map['completed_at'] = Variable<DateTime>(completedAt);
    if (!nullToAbsent || durationMinutes != null) {
      map['duration_minutes'] = Variable<int>(durationMinutes);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  WorkoutSessionsTableCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSessionsTableCompanion(
      id: Value(id),
      userId: Value(userId),
      workoutId: Value(workoutId),
      completedAt: Value(completedAt),
      durationMinutes: durationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMinutes),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory WorkoutSessionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSessionsTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      workoutId: serializer.fromJson<String>(json['workoutId']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      durationMinutes: serializer.fromJson<int?>(json['durationMinutes']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'workoutId': serializer.toJson<String>(workoutId),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'durationMinutes': serializer.toJson<int?>(durationMinutes),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  WorkoutSessionsTableData copyWith({
    String? id,
    String? userId,
    String? workoutId,
    DateTime? completedAt,
    Value<int?> durationMinutes = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => WorkoutSessionsTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    workoutId: workoutId ?? this.workoutId,
    completedAt: completedAt ?? this.completedAt,
    durationMinutes: durationMinutes.present
        ? durationMinutes.value
        : this.durationMinutes,
    notes: notes.present ? notes.value : this.notes,
  );
  WorkoutSessionsTableData copyWithCompanion(
    WorkoutSessionsTableCompanion data,
  ) {
    return WorkoutSessionsTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      workoutId: data.workoutId.present ? data.workoutId.value : this.workoutId,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('workoutId: $workoutId, ')
          ..write('completedAt: $completedAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, workoutId, completedAt, durationMinutes, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSessionsTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.workoutId == this.workoutId &&
          other.completedAt == this.completedAt &&
          other.durationMinutes == this.durationMinutes &&
          other.notes == this.notes);
}

class WorkoutSessionsTableCompanion
    extends UpdateCompanion<WorkoutSessionsTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> workoutId;
  final Value<DateTime> completedAt;
  final Value<int?> durationMinutes;
  final Value<String?> notes;
  final Value<int> rowid;
  const WorkoutSessionsTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutSessionsTableCompanion.insert({
    required String id,
    required String userId,
    required String workoutId,
    required DateTime completedAt,
    this.durationMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       workoutId = Value(workoutId),
       completedAt = Value(completedAt);
  static Insertable<WorkoutSessionsTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? workoutId,
    Expression<DateTime>? completedAt,
    Expression<int>? durationMinutes,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (workoutId != null) 'workout_id': workoutId,
      if (completedAt != null) 'completed_at': completedAt,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutSessionsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? workoutId,
    Value<DateTime>? completedAt,
    Value<int?>? durationMinutes,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return WorkoutSessionsTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      workoutId: workoutId ?? this.workoutId,
      completedAt: completedAt ?? this.completedAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (workoutId.present) {
      map['workout_id'] = Variable<String>(workoutId.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('workoutId: $workoutId, ')
          ..write('completedAt: $completedAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScheduledWorkoutsTableTable extends ScheduledWorkoutsTable
    with TableInfo<$ScheduledWorkoutsTableTable, ScheduledWorkoutsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduledWorkoutsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workoutIdMeta = const VerificationMeta(
    'workoutId',
  );
  @override
  late final GeneratedColumn<String> workoutId = GeneratedColumn<String>(
    'workout_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledDateMeta = const VerificationMeta(
    'scheduledDate',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledDate =
      GeneratedColumn<DateTime>(
        'scheduled_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    workoutId,
    scheduledDate,
    isCompleted,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scheduled_workouts_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScheduledWorkoutsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('workout_id')) {
      context.handle(
        _workoutIdMeta,
        workoutId.isAcceptableOrUnknown(data['workout_id']!, _workoutIdMeta),
      );
    } else if (isInserting) {
      context.missing(_workoutIdMeta);
    }
    if (data.containsKey('scheduled_date')) {
      context.handle(
        _scheduledDateMeta,
        scheduledDate.isAcceptableOrUnknown(
          data['scheduled_date']!,
          _scheduledDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledDateMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduledWorkoutsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduledWorkoutsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      workoutId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_id'],
      )!,
      scheduledDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_date'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $ScheduledWorkoutsTableTable createAlias(String alias) {
    return $ScheduledWorkoutsTableTable(attachedDatabase, alias);
  }
}

class ScheduledWorkoutsTableData extends DataClass
    implements Insertable<ScheduledWorkoutsTableData> {
  final String id;
  final String userId;
  final String workoutId;
  final DateTime scheduledDate;
  final bool isCompleted;
  final DateTime? completedAt;
  const ScheduledWorkoutsTableData({
    required this.id,
    required this.userId,
    required this.workoutId,
    required this.scheduledDate,
    required this.isCompleted,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['workout_id'] = Variable<String>(workoutId);
    map['scheduled_date'] = Variable<DateTime>(scheduledDate);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  ScheduledWorkoutsTableCompanion toCompanion(bool nullToAbsent) {
    return ScheduledWorkoutsTableCompanion(
      id: Value(id),
      userId: Value(userId),
      workoutId: Value(workoutId),
      scheduledDate: Value(scheduledDate),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory ScheduledWorkoutsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduledWorkoutsTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      workoutId: serializer.fromJson<String>(json['workoutId']),
      scheduledDate: serializer.fromJson<DateTime>(json['scheduledDate']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'workoutId': serializer.toJson<String>(workoutId),
      'scheduledDate': serializer.toJson<DateTime>(scheduledDate),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  ScheduledWorkoutsTableData copyWith({
    String? id,
    String? userId,
    String? workoutId,
    DateTime? scheduledDate,
    bool? isCompleted,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => ScheduledWorkoutsTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    workoutId: workoutId ?? this.workoutId,
    scheduledDate: scheduledDate ?? this.scheduledDate,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  ScheduledWorkoutsTableData copyWithCompanion(
    ScheduledWorkoutsTableCompanion data,
  ) {
    return ScheduledWorkoutsTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      workoutId: data.workoutId.present ? data.workoutId.value : this.workoutId,
      scheduledDate: data.scheduledDate.present
          ? data.scheduledDate.value
          : this.scheduledDate,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduledWorkoutsTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('workoutId: $workoutId, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    workoutId,
    scheduledDate,
    isCompleted,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduledWorkoutsTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.workoutId == this.workoutId &&
          other.scheduledDate == this.scheduledDate &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt);
}

class ScheduledWorkoutsTableCompanion
    extends UpdateCompanion<ScheduledWorkoutsTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> workoutId;
  final Value<DateTime> scheduledDate;
  final Value<bool> isCompleted;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const ScheduledWorkoutsTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.scheduledDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScheduledWorkoutsTableCompanion.insert({
    required String id,
    required String userId,
    required String workoutId,
    required DateTime scheduledDate,
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       workoutId = Value(workoutId),
       scheduledDate = Value(scheduledDate);
  static Insertable<ScheduledWorkoutsTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? workoutId,
    Expression<DateTime>? scheduledDate,
    Expression<bool>? isCompleted,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (workoutId != null) 'workout_id': workoutId,
      if (scheduledDate != null) 'scheduled_date': scheduledDate,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScheduledWorkoutsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? workoutId,
    Value<DateTime>? scheduledDate,
    Value<bool>? isCompleted,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return ScheduledWorkoutsTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      workoutId: workoutId ?? this.workoutId,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (workoutId.present) {
      map['workout_id'] = Variable<String>(workoutId.value);
    }
    if (scheduledDate.present) {
      map['scheduled_date'] = Variable<DateTime>(scheduledDate.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduledWorkoutsTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('workoutId: $workoutId, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProgressPhotosTableTable extends ProgressPhotosTable
    with TableInfo<$ProgressPhotosTableTable, ProgressPhotosTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgressPhotosTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    date,
    imagePath,
    weight,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'progress_photos_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgressPhotosTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProgressPhotosTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgressPhotosTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $ProgressPhotosTableTable createAlias(String alias) {
    return $ProgressPhotosTableTable(attachedDatabase, alias);
  }
}

class ProgressPhotosTableData extends DataClass
    implements Insertable<ProgressPhotosTableData> {
  final String id;
  final String userId;
  final DateTime date;
  final String imagePath;
  final double? weight;
  final String notes;
  const ProgressPhotosTableData({
    required this.id,
    required this.userId,
    required this.date,
    required this.imagePath,
    this.weight,
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['date'] = Variable<DateTime>(date);
    map['image_path'] = Variable<String>(imagePath);
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    map['notes'] = Variable<String>(notes);
    return map;
  }

  ProgressPhotosTableCompanion toCompanion(bool nullToAbsent) {
    return ProgressPhotosTableCompanion(
      id: Value(id),
      userId: Value(userId),
      date: Value(date),
      imagePath: Value(imagePath),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      notes: Value(notes),
    );
  }

  factory ProgressPhotosTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgressPhotosTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      date: serializer.fromJson<DateTime>(json['date']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      weight: serializer.fromJson<double?>(json['weight']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'date': serializer.toJson<DateTime>(date),
      'imagePath': serializer.toJson<String>(imagePath),
      'weight': serializer.toJson<double?>(weight),
      'notes': serializer.toJson<String>(notes),
    };
  }

  ProgressPhotosTableData copyWith({
    String? id,
    String? userId,
    DateTime? date,
    String? imagePath,
    Value<double?> weight = const Value.absent(),
    String? notes,
  }) => ProgressPhotosTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    date: date ?? this.date,
    imagePath: imagePath ?? this.imagePath,
    weight: weight.present ? weight.value : this.weight,
    notes: notes ?? this.notes,
  );
  ProgressPhotosTableData copyWithCompanion(ProgressPhotosTableCompanion data) {
    return ProgressPhotosTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      weight: data.weight.present ? data.weight.value : this.weight,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgressPhotosTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('imagePath: $imagePath, ')
          ..write('weight: $weight, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, date, imagePath, weight, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgressPhotosTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.imagePath == this.imagePath &&
          other.weight == this.weight &&
          other.notes == this.notes);
}

class ProgressPhotosTableCompanion
    extends UpdateCompanion<ProgressPhotosTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<DateTime> date;
  final Value<String> imagePath;
  final Value<double?> weight;
  final Value<String> notes;
  final Value<int> rowid;
  const ProgressPhotosTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.weight = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProgressPhotosTableCompanion.insert({
    required String id,
    required String userId,
    required DateTime date,
    required String imagePath,
    this.weight = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       date = Value(date),
       imagePath = Value(imagePath);
  static Insertable<ProgressPhotosTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? date,
    Expression<String>? imagePath,
    Expression<double>? weight,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (imagePath != null) 'image_path': imagePath,
      if (weight != null) 'weight': weight,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProgressPhotosTableCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<DateTime>? date,
    Value<String>? imagePath,
    Value<double?>? weight,
    Value<String>? notes,
    Value<int>? rowid,
  }) {
    return ProgressPhotosTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      imagePath: imagePath ?? this.imagePath,
      weight: weight ?? this.weight,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgressPhotosTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('imagePath: $imagePath, ')
          ..write('weight: $weight, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JournalEntriesTableTable extends JournalEntriesTable
    with TableInfo<$JournalEntriesTableTable, JournalEntriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<String> mood = GeneratedColumn<String>(
    'mood',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entryDateTimeMeta = const VerificationMeta(
    'entryDateTime',
  );
  @override
  late final GeneratedColumn<DateTime> entryDateTime =
      GeneratedColumn<DateTime>(
        'entry_date_time',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    content,
    mood,
    entryDateTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalEntriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    } else if (isInserting) {
      context.missing(_moodMeta);
    }
    if (data.containsKey('entry_date_time')) {
      context.handle(
        _entryDateTimeMeta,
        entryDateTime.isAcceptableOrUnknown(
          data['entry_date_time']!,
          _entryDateTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_entryDateTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalEntriesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      mood: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood'],
      )!,
      entryDateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}entry_date_time'],
      )!,
    );
  }

  @override
  $JournalEntriesTableTable createAlias(String alias) {
    return $JournalEntriesTableTable(attachedDatabase, alias);
  }
}

class JournalEntriesTableData extends DataClass
    implements Insertable<JournalEntriesTableData> {
  final String id;
  final String userId;
  final String content;
  final String mood;
  final DateTime entryDateTime;
  const JournalEntriesTableData({
    required this.id,
    required this.userId,
    required this.content,
    required this.mood,
    required this.entryDateTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['content'] = Variable<String>(content);
    map['mood'] = Variable<String>(mood);
    map['entry_date_time'] = Variable<DateTime>(entryDateTime);
    return map;
  }

  JournalEntriesTableCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesTableCompanion(
      id: Value(id),
      userId: Value(userId),
      content: Value(content),
      mood: Value(mood),
      entryDateTime: Value(entryDateTime),
    );
  }

  factory JournalEntriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntriesTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      content: serializer.fromJson<String>(json['content']),
      mood: serializer.fromJson<String>(json['mood']),
      entryDateTime: serializer.fromJson<DateTime>(json['entryDateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'content': serializer.toJson<String>(content),
      'mood': serializer.toJson<String>(mood),
      'entryDateTime': serializer.toJson<DateTime>(entryDateTime),
    };
  }

  JournalEntriesTableData copyWith({
    String? id,
    String? userId,
    String? content,
    String? mood,
    DateTime? entryDateTime,
  }) => JournalEntriesTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    content: content ?? this.content,
    mood: mood ?? this.mood,
    entryDateTime: entryDateTime ?? this.entryDateTime,
  );
  JournalEntriesTableData copyWithCompanion(JournalEntriesTableCompanion data) {
    return JournalEntriesTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      content: data.content.present ? data.content.value : this.content,
      mood: data.mood.present ? data.mood.value : this.mood,
      entryDateTime: data.entryDateTime.present
          ? data.entryDateTime.value
          : this.entryDateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('content: $content, ')
          ..write('mood: $mood, ')
          ..write('entryDateTime: $entryDateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, content, mood, entryDateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntriesTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.content == this.content &&
          other.mood == this.mood &&
          other.entryDateTime == this.entryDateTime);
}

class JournalEntriesTableCompanion
    extends UpdateCompanion<JournalEntriesTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> content;
  final Value<String> mood;
  final Value<DateTime> entryDateTime;
  final Value<int> rowid;
  const JournalEntriesTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.content = const Value.absent(),
    this.mood = const Value.absent(),
    this.entryDateTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JournalEntriesTableCompanion.insert({
    required String id,
    required String userId,
    required String content,
    required String mood,
    required DateTime entryDateTime,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       content = Value(content),
       mood = Value(mood),
       entryDateTime = Value(entryDateTime);
  static Insertable<JournalEntriesTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? content,
    Expression<String>? mood,
    Expression<DateTime>? entryDateTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (content != null) 'content': content,
      if (mood != null) 'mood': mood,
      if (entryDateTime != null) 'entry_date_time': entryDateTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JournalEntriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? content,
    Value<String>? mood,
    Value<DateTime>? entryDateTime,
    Value<int>? rowid,
  }) {
    return JournalEntriesTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      mood: mood ?? this.mood,
      entryDateTime: entryDateTime ?? this.entryDateTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (mood.present) {
      map['mood'] = Variable<String>(mood.value);
    }
    if (entryDateTime.present) {
      map['entry_date_time'] = Variable<DateTime>(entryDateTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('content: $content, ')
          ..write('mood: $mood, ')
          ..write('entryDateTime: $entryDateTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeeklyReviewsTableTable extends WeeklyReviewsTable
    with TableInfo<$WeeklyReviewsTableTable, WeeklyReviewsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklyReviewsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _waistMeta = const VerificationMeta('waist');
  @override
  late final GeneratedColumn<double> waist = GeneratedColumn<double>(
    'waist',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _consistencyScoreMeta = const VerificationMeta(
    'consistencyScore',
  );
  @override
  late final GeneratedColumn<int> consistencyScore = GeneratedColumn<int>(
    'consistency_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    date,
    weight,
    waist,
    consistencyScore,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_reviews_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeeklyReviewsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('waist')) {
      context.handle(
        _waistMeta,
        waist.isAcceptableOrUnknown(data['waist']!, _waistMeta),
      );
    } else if (isInserting) {
      context.missing(_waistMeta);
    }
    if (data.containsKey('consistency_score')) {
      context.handle(
        _consistencyScoreMeta,
        consistencyScore.isAcceptableOrUnknown(
          data['consistency_score']!,
          _consistencyScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_consistencyScoreMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeeklyReviewsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklyReviewsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      )!,
      waist: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}waist'],
      )!,
      consistencyScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}consistency_score'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $WeeklyReviewsTableTable createAlias(String alias) {
    return $WeeklyReviewsTableTable(attachedDatabase, alias);
  }
}

class WeeklyReviewsTableData extends DataClass
    implements Insertable<WeeklyReviewsTableData> {
  final String id;
  final String userId;
  final DateTime date;
  final double weight;
  final double waist;
  final int consistencyScore;
  final String notes;
  const WeeklyReviewsTableData({
    required this.id,
    required this.userId,
    required this.date,
    required this.weight,
    required this.waist,
    required this.consistencyScore,
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['date'] = Variable<DateTime>(date);
    map['weight'] = Variable<double>(weight);
    map['waist'] = Variable<double>(waist);
    map['consistency_score'] = Variable<int>(consistencyScore);
    map['notes'] = Variable<String>(notes);
    return map;
  }

  WeeklyReviewsTableCompanion toCompanion(bool nullToAbsent) {
    return WeeklyReviewsTableCompanion(
      id: Value(id),
      userId: Value(userId),
      date: Value(date),
      weight: Value(weight),
      waist: Value(waist),
      consistencyScore: Value(consistencyScore),
      notes: Value(notes),
    );
  }

  factory WeeklyReviewsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklyReviewsTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      date: serializer.fromJson<DateTime>(json['date']),
      weight: serializer.fromJson<double>(json['weight']),
      waist: serializer.fromJson<double>(json['waist']),
      consistencyScore: serializer.fromJson<int>(json['consistencyScore']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'date': serializer.toJson<DateTime>(date),
      'weight': serializer.toJson<double>(weight),
      'waist': serializer.toJson<double>(waist),
      'consistencyScore': serializer.toJson<int>(consistencyScore),
      'notes': serializer.toJson<String>(notes),
    };
  }

  WeeklyReviewsTableData copyWith({
    String? id,
    String? userId,
    DateTime? date,
    double? weight,
    double? waist,
    int? consistencyScore,
    String? notes,
  }) => WeeklyReviewsTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    date: date ?? this.date,
    weight: weight ?? this.weight,
    waist: waist ?? this.waist,
    consistencyScore: consistencyScore ?? this.consistencyScore,
    notes: notes ?? this.notes,
  );
  WeeklyReviewsTableData copyWithCompanion(WeeklyReviewsTableCompanion data) {
    return WeeklyReviewsTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      weight: data.weight.present ? data.weight.value : this.weight,
      waist: data.waist.present ? data.waist.value : this.waist,
      consistencyScore: data.consistencyScore.present
          ? data.consistencyScore.value
          : this.consistencyScore,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyReviewsTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('waist: $waist, ')
          ..write('consistencyScore: $consistencyScore, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, date, weight, waist, consistencyScore, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklyReviewsTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.weight == this.weight &&
          other.waist == this.waist &&
          other.consistencyScore == this.consistencyScore &&
          other.notes == this.notes);
}

class WeeklyReviewsTableCompanion
    extends UpdateCompanion<WeeklyReviewsTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<DateTime> date;
  final Value<double> weight;
  final Value<double> waist;
  final Value<int> consistencyScore;
  final Value<String> notes;
  final Value<int> rowid;
  const WeeklyReviewsTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.weight = const Value.absent(),
    this.waist = const Value.absent(),
    this.consistencyScore = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeklyReviewsTableCompanion.insert({
    required String id,
    required String userId,
    required DateTime date,
    required double weight,
    required double waist,
    required int consistencyScore,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       date = Value(date),
       weight = Value(weight),
       waist = Value(waist),
       consistencyScore = Value(consistencyScore);
  static Insertable<WeeklyReviewsTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? date,
    Expression<double>? weight,
    Expression<double>? waist,
    Expression<int>? consistencyScore,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (weight != null) 'weight': weight,
      if (waist != null) 'waist': waist,
      if (consistencyScore != null) 'consistency_score': consistencyScore,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeklyReviewsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<DateTime>? date,
    Value<double>? weight,
    Value<double>? waist,
    Value<int>? consistencyScore,
    Value<String>? notes,
    Value<int>? rowid,
  }) {
    return WeeklyReviewsTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      waist: waist ?? this.waist,
      consistencyScore: consistencyScore ?? this.consistencyScore,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (waist.present) {
      map['waist'] = Variable<double>(waist.value);
    }
    if (consistencyScore.present) {
      map['consistency_score'] = Variable<int>(consistencyScore.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyReviewsTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('waist: $waist, ')
          ..write('consistencyScore: $consistencyScore, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomWorkoutsTableTable extends CustomWorkoutsTable
    with TableInfo<$CustomWorkoutsTableTable, CustomWorkoutsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomWorkoutsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  exercises =
      GeneratedColumn<String>(
        'exercises',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Map<String, dynamic>>(
        $CustomWorkoutsTableTable.$converterexercises,
      );
  static const VerificationMeta _estimatedDurationMeta = const VerificationMeta(
    'estimatedDuration',
  );
  @override
  late final GeneratedColumn<int> estimatedDuration = GeneratedColumn<int>(
    'estimated_duration',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('beginner'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    name,
    description,
    exercises,
    estimatedDuration,
    difficulty,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_workouts_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomWorkoutsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('estimated_duration')) {
      context.handle(
        _estimatedDurationMeta,
        estimatedDuration.isAcceptableOrUnknown(
          data['estimated_duration']!,
          _estimatedDurationMeta,
        ),
      );
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomWorkoutsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomWorkoutsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      exercises: $CustomWorkoutsTableTable.$converterexercises.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}exercises'],
        )!,
      ),
      estimatedDuration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_duration'],
      ),
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CustomWorkoutsTableTable createAlias(String alias) {
    return $CustomWorkoutsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>, String> $converterexercises =
      const MapConverter();
}

class CustomWorkoutsTableData extends DataClass
    implements Insertable<CustomWorkoutsTableData> {
  final String id;
  final String userId;
  final String name;
  final String? description;
  final Map<String, dynamic> exercises;
  final int? estimatedDuration;
  final String difficulty;
  final DateTime createdAt;
  const CustomWorkoutsTableData({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.exercises,
    this.estimatedDuration,
    required this.difficulty,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    {
      map['exercises'] = Variable<String>(
        $CustomWorkoutsTableTable.$converterexercises.toSql(exercises),
      );
    }
    if (!nullToAbsent || estimatedDuration != null) {
      map['estimated_duration'] = Variable<int>(estimatedDuration);
    }
    map['difficulty'] = Variable<String>(difficulty);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomWorkoutsTableCompanion toCompanion(bool nullToAbsent) {
    return CustomWorkoutsTableCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      exercises: Value(exercises),
      estimatedDuration: estimatedDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedDuration),
      difficulty: Value(difficulty),
      createdAt: Value(createdAt),
    );
  }

  factory CustomWorkoutsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomWorkoutsTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      exercises: serializer.fromJson<Map<String, dynamic>>(json['exercises']),
      estimatedDuration: serializer.fromJson<int?>(json['estimatedDuration']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'exercises': serializer.toJson<Map<String, dynamic>>(exercises),
      'estimatedDuration': serializer.toJson<int?>(estimatedDuration),
      'difficulty': serializer.toJson<String>(difficulty),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CustomWorkoutsTableData copyWith({
    String? id,
    String? userId,
    String? name,
    Value<String?> description = const Value.absent(),
    Map<String, dynamic>? exercises,
    Value<int?> estimatedDuration = const Value.absent(),
    String? difficulty,
    DateTime? createdAt,
  }) => CustomWorkoutsTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    exercises: exercises ?? this.exercises,
    estimatedDuration: estimatedDuration.present
        ? estimatedDuration.value
        : this.estimatedDuration,
    difficulty: difficulty ?? this.difficulty,
    createdAt: createdAt ?? this.createdAt,
  );
  CustomWorkoutsTableData copyWithCompanion(CustomWorkoutsTableCompanion data) {
    return CustomWorkoutsTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      exercises: data.exercises.present ? data.exercises.value : this.exercises,
      estimatedDuration: data.estimatedDuration.present
          ? data.estimatedDuration.value
          : this.estimatedDuration,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomWorkoutsTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('exercises: $exercises, ')
          ..write('estimatedDuration: $estimatedDuration, ')
          ..write('difficulty: $difficulty, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    name,
    description,
    exercises,
    estimatedDuration,
    difficulty,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomWorkoutsTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.description == this.description &&
          other.exercises == this.exercises &&
          other.estimatedDuration == this.estimatedDuration &&
          other.difficulty == this.difficulty &&
          other.createdAt == this.createdAt);
}

class CustomWorkoutsTableCompanion
    extends UpdateCompanion<CustomWorkoutsTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String?> description;
  final Value<Map<String, dynamic>> exercises;
  final Value<int?> estimatedDuration;
  final Value<String> difficulty;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CustomWorkoutsTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.exercises = const Value.absent(),
    this.estimatedDuration = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomWorkoutsTableCompanion.insert({
    required String id,
    required String userId,
    required String name,
    this.description = const Value.absent(),
    required Map<String, dynamic> exercises,
    this.estimatedDuration = const Value.absent(),
    this.difficulty = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       name = Value(name),
       exercises = Value(exercises),
       createdAt = Value(createdAt);
  static Insertable<CustomWorkoutsTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? exercises,
    Expression<int>? estimatedDuration,
    Expression<String>? difficulty,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (exercises != null) 'exercises': exercises,
      if (estimatedDuration != null) 'estimated_duration': estimatedDuration,
      if (difficulty != null) 'difficulty': difficulty,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomWorkoutsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? name,
    Value<String?>? description,
    Value<Map<String, dynamic>>? exercises,
    Value<int?>? estimatedDuration,
    Value<String>? difficulty,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CustomWorkoutsTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      exercises: exercises ?? this.exercises,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      difficulty: difficulty ?? this.difficulty,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (exercises.present) {
      map['exercises'] = Variable<String>(
        $CustomWorkoutsTableTable.$converterexercises.toSql(exercises.value),
      );
    }
    if (estimatedDuration.present) {
      map['estimated_duration'] = Variable<int>(estimatedDuration.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomWorkoutsTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('exercises: $exercises, ')
          ..write('estimatedDuration: $estimatedDuration, ')
          ..write('difficulty: $difficulty, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PactsTableTable extends PactsTable
    with TableInfo<$PactsTableTable, PactsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PactsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _squadIdMeta = const VerificationMeta(
    'squadId',
  );
  @override
  late final GeneratedColumn<String> squadId = GeneratedColumn<String>(
    'squad_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetCountMeta = const VerificationMeta(
    'targetCount',
  );
  @override
  late final GeneratedColumn<int> targetCount = GeneratedColumn<int>(
    'target_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentStreakMeta = const VerificationMeta(
    'currentStreak',
  );
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
    'current_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _lastCheckedAtMeta = const VerificationMeta(
    'lastCheckedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastCheckedAt =
      GeneratedColumn<DateTime>(
        'last_checked_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wagerAmountMeta = const VerificationMeta(
    'wagerAmount',
  );
  @override
  late final GeneratedColumn<double> wagerAmount = GeneratedColumn<double>(
    'wager_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _deadlineMeta = const VerificationMeta(
    'deadline',
  );
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
    'deadline',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    squadId,
    frequency,
    targetCount,
    currentStreak,
    status,
    lastCheckedAt,
    createdAt,
    wagerAmount,
    deadline,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pacts_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PactsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('squad_id')) {
      context.handle(
        _squadIdMeta,
        squadId.isAcceptableOrUnknown(data['squad_id']!, _squadIdMeta),
      );
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('target_count')) {
      context.handle(
        _targetCountMeta,
        targetCount.isAcceptableOrUnknown(
          data['target_count']!,
          _targetCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetCountMeta);
    }
    if (data.containsKey('current_streak')) {
      context.handle(
        _currentStreakMeta,
        currentStreak.isAcceptableOrUnknown(
          data['current_streak']!,
          _currentStreakMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('last_checked_at')) {
      context.handle(
        _lastCheckedAtMeta,
        lastCheckedAt.isAcceptableOrUnknown(
          data['last_checked_at']!,
          _lastCheckedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('wager_amount')) {
      context.handle(
        _wagerAmountMeta,
        wagerAmount.isAcceptableOrUnknown(
          data['wager_amount']!,
          _wagerAmountMeta,
        ),
      );
    }
    if (data.containsKey('deadline')) {
      context.handle(
        _deadlineMeta,
        deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PactsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PactsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      squadId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}squad_id'],
      ),
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      )!,
      targetCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_count'],
      )!,
      currentStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_streak'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      lastCheckedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_checked_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      wagerAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wager_amount'],
      )!,
      deadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deadline'],
      ),
    );
  }

  @override
  $PactsTableTable createAlias(String alias) {
    return $PactsTableTable(attachedDatabase, alias);
  }
}

class PactsTableData extends DataClass implements Insertable<PactsTableData> {
  final String id;
  final String title;
  final String? squadId;
  final String frequency;
  final int targetCount;
  final int currentStreak;
  final String status;
  final DateTime? lastCheckedAt;
  final DateTime createdAt;
  final double wagerAmount;
  final DateTime? deadline;
  const PactsTableData({
    required this.id,
    required this.title,
    this.squadId,
    required this.frequency,
    required this.targetCount,
    required this.currentStreak,
    required this.status,
    this.lastCheckedAt,
    required this.createdAt,
    required this.wagerAmount,
    this.deadline,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || squadId != null) {
      map['squad_id'] = Variable<String>(squadId);
    }
    map['frequency'] = Variable<String>(frequency);
    map['target_count'] = Variable<int>(targetCount);
    map['current_streak'] = Variable<int>(currentStreak);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || lastCheckedAt != null) {
      map['last_checked_at'] = Variable<DateTime>(lastCheckedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['wager_amount'] = Variable<double>(wagerAmount);
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<DateTime>(deadline);
    }
    return map;
  }

  PactsTableCompanion toCompanion(bool nullToAbsent) {
    return PactsTableCompanion(
      id: Value(id),
      title: Value(title),
      squadId: squadId == null && nullToAbsent
          ? const Value.absent()
          : Value(squadId),
      frequency: Value(frequency),
      targetCount: Value(targetCount),
      currentStreak: Value(currentStreak),
      status: Value(status),
      lastCheckedAt: lastCheckedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCheckedAt),
      createdAt: Value(createdAt),
      wagerAmount: Value(wagerAmount),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
    );
  }

  factory PactsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PactsTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      squadId: serializer.fromJson<String?>(json['squadId']),
      frequency: serializer.fromJson<String>(json['frequency']),
      targetCount: serializer.fromJson<int>(json['targetCount']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      status: serializer.fromJson<String>(json['status']),
      lastCheckedAt: serializer.fromJson<DateTime?>(json['lastCheckedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      wagerAmount: serializer.fromJson<double>(json['wagerAmount']),
      deadline: serializer.fromJson<DateTime?>(json['deadline']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'squadId': serializer.toJson<String?>(squadId),
      'frequency': serializer.toJson<String>(frequency),
      'targetCount': serializer.toJson<int>(targetCount),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'status': serializer.toJson<String>(status),
      'lastCheckedAt': serializer.toJson<DateTime?>(lastCheckedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'wagerAmount': serializer.toJson<double>(wagerAmount),
      'deadline': serializer.toJson<DateTime?>(deadline),
    };
  }

  PactsTableData copyWith({
    String? id,
    String? title,
    Value<String?> squadId = const Value.absent(),
    String? frequency,
    int? targetCount,
    int? currentStreak,
    String? status,
    Value<DateTime?> lastCheckedAt = const Value.absent(),
    DateTime? createdAt,
    double? wagerAmount,
    Value<DateTime?> deadline = const Value.absent(),
  }) => PactsTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    squadId: squadId.present ? squadId.value : this.squadId,
    frequency: frequency ?? this.frequency,
    targetCount: targetCount ?? this.targetCount,
    currentStreak: currentStreak ?? this.currentStreak,
    status: status ?? this.status,
    lastCheckedAt: lastCheckedAt.present
        ? lastCheckedAt.value
        : this.lastCheckedAt,
    createdAt: createdAt ?? this.createdAt,
    wagerAmount: wagerAmount ?? this.wagerAmount,
    deadline: deadline.present ? deadline.value : this.deadline,
  );
  PactsTableData copyWithCompanion(PactsTableCompanion data) {
    return PactsTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      squadId: data.squadId.present ? data.squadId.value : this.squadId,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      targetCount: data.targetCount.present
          ? data.targetCount.value
          : this.targetCount,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      status: data.status.present ? data.status.value : this.status,
      lastCheckedAt: data.lastCheckedAt.present
          ? data.lastCheckedAt.value
          : this.lastCheckedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      wagerAmount: data.wagerAmount.present
          ? data.wagerAmount.value
          : this.wagerAmount,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PactsTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('squadId: $squadId, ')
          ..write('frequency: $frequency, ')
          ..write('targetCount: $targetCount, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('status: $status, ')
          ..write('lastCheckedAt: $lastCheckedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('wagerAmount: $wagerAmount, ')
          ..write('deadline: $deadline')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    squadId,
    frequency,
    targetCount,
    currentStreak,
    status,
    lastCheckedAt,
    createdAt,
    wagerAmount,
    deadline,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PactsTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.squadId == this.squadId &&
          other.frequency == this.frequency &&
          other.targetCount == this.targetCount &&
          other.currentStreak == this.currentStreak &&
          other.status == this.status &&
          other.lastCheckedAt == this.lastCheckedAt &&
          other.createdAt == this.createdAt &&
          other.wagerAmount == this.wagerAmount &&
          other.deadline == this.deadline);
}

class PactsTableCompanion extends UpdateCompanion<PactsTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> squadId;
  final Value<String> frequency;
  final Value<int> targetCount;
  final Value<int> currentStreak;
  final Value<String> status;
  final Value<DateTime?> lastCheckedAt;
  final Value<DateTime> createdAt;
  final Value<double> wagerAmount;
  final Value<DateTime?> deadline;
  final Value<int> rowid;
  const PactsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.squadId = const Value.absent(),
    this.frequency = const Value.absent(),
    this.targetCount = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.status = const Value.absent(),
    this.lastCheckedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.wagerAmount = const Value.absent(),
    this.deadline = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PactsTableCompanion.insert({
    required String id,
    required String title,
    this.squadId = const Value.absent(),
    required String frequency,
    required int targetCount,
    this.currentStreak = const Value.absent(),
    this.status = const Value.absent(),
    this.lastCheckedAt = const Value.absent(),
    required DateTime createdAt,
    this.wagerAmount = const Value.absent(),
    this.deadline = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       frequency = Value(frequency),
       targetCount = Value(targetCount),
       createdAt = Value(createdAt);
  static Insertable<PactsTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? squadId,
    Expression<String>? frequency,
    Expression<int>? targetCount,
    Expression<int>? currentStreak,
    Expression<String>? status,
    Expression<DateTime>? lastCheckedAt,
    Expression<DateTime>? createdAt,
    Expression<double>? wagerAmount,
    Expression<DateTime>? deadline,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (squadId != null) 'squad_id': squadId,
      if (frequency != null) 'frequency': frequency,
      if (targetCount != null) 'target_count': targetCount,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (status != null) 'status': status,
      if (lastCheckedAt != null) 'last_checked_at': lastCheckedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (wagerAmount != null) 'wager_amount': wagerAmount,
      if (deadline != null) 'deadline': deadline,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PactsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? squadId,
    Value<String>? frequency,
    Value<int>? targetCount,
    Value<int>? currentStreak,
    Value<String>? status,
    Value<DateTime?>? lastCheckedAt,
    Value<DateTime>? createdAt,
    Value<double>? wagerAmount,
    Value<DateTime?>? deadline,
    Value<int>? rowid,
  }) {
    return PactsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      squadId: squadId ?? this.squadId,
      frequency: frequency ?? this.frequency,
      targetCount: targetCount ?? this.targetCount,
      currentStreak: currentStreak ?? this.currentStreak,
      status: status ?? this.status,
      lastCheckedAt: lastCheckedAt ?? this.lastCheckedAt,
      createdAt: createdAt ?? this.createdAt,
      wagerAmount: wagerAmount ?? this.wagerAmount,
      deadline: deadline ?? this.deadline,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (squadId.present) {
      map['squad_id'] = Variable<String>(squadId.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (targetCount.present) {
      map['target_count'] = Variable<int>(targetCount.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (lastCheckedAt.present) {
      map['last_checked_at'] = Variable<DateTime>(lastCheckedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (wagerAmount.present) {
      map['wager_amount'] = Variable<double>(wagerAmount.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PactsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('squadId: $squadId, ')
          ..write('frequency: $frequency, ')
          ..write('targetCount: $targetCount, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('status: $status, ')
          ..write('lastCheckedAt: $lastCheckedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('wagerAmount: $wagerAmount, ')
          ..write('deadline: $deadline, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SquadsTableTable extends SquadsTable
    with TableInfo<$SquadsTableTable, SquadsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SquadsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inviteCodeMeta = const VerificationMeta(
    'inviteCode',
  );
  @override
  late final GeneratedColumn<String> inviteCode = GeneratedColumn<String>(
    'invite_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
    'tier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('social'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> members =
      GeneratedColumn<String>(
        'members',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<String>>($SquadsTableTable.$convertermembers);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    inviteCode,
    tier,
    members,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'squads_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SquadsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('invite_code')) {
      context.handle(
        _inviteCodeMeta,
        inviteCode.isAcceptableOrUnknown(data['invite_code']!, _inviteCodeMeta),
      );
    }
    if (data.containsKey('tier')) {
      context.handle(
        _tierMeta,
        tier.isAcceptableOrUnknown(data['tier']!, _tierMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SquadsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SquadsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      inviteCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invite_code'],
      ),
      tier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tier'],
      )!,
      members: $SquadsTableTable.$convertermembers.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}members'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SquadsTableTable createAlias(String alias) {
    return $SquadsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $convertermembers =
      const ListConverter();
}

class SquadsTableData extends DataClass implements Insertable<SquadsTableData> {
  final String id;
  final String name;
  final String? inviteCode;
  final String tier;
  final List<String> members;
  final DateTime createdAt;
  const SquadsTableData({
    required this.id,
    required this.name,
    this.inviteCode,
    required this.tier,
    required this.members,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || inviteCode != null) {
      map['invite_code'] = Variable<String>(inviteCode);
    }
    map['tier'] = Variable<String>(tier);
    {
      map['members'] = Variable<String>(
        $SquadsTableTable.$convertermembers.toSql(members),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SquadsTableCompanion toCompanion(bool nullToAbsent) {
    return SquadsTableCompanion(
      id: Value(id),
      name: Value(name),
      inviteCode: inviteCode == null && nullToAbsent
          ? const Value.absent()
          : Value(inviteCode),
      tier: Value(tier),
      members: Value(members),
      createdAt: Value(createdAt),
    );
  }

  factory SquadsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SquadsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      inviteCode: serializer.fromJson<String?>(json['inviteCode']),
      tier: serializer.fromJson<String>(json['tier']),
      members: serializer.fromJson<List<String>>(json['members']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'inviteCode': serializer.toJson<String?>(inviteCode),
      'tier': serializer.toJson<String>(tier),
      'members': serializer.toJson<List<String>>(members),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SquadsTableData copyWith({
    String? id,
    String? name,
    Value<String?> inviteCode = const Value.absent(),
    String? tier,
    List<String>? members,
    DateTime? createdAt,
  }) => SquadsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    inviteCode: inviteCode.present ? inviteCode.value : this.inviteCode,
    tier: tier ?? this.tier,
    members: members ?? this.members,
    createdAt: createdAt ?? this.createdAt,
  );
  SquadsTableData copyWithCompanion(SquadsTableCompanion data) {
    return SquadsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      inviteCode: data.inviteCode.present
          ? data.inviteCode.value
          : this.inviteCode,
      tier: data.tier.present ? data.tier.value : this.tier,
      members: data.members.present ? data.members.value : this.members,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SquadsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('tier: $tier, ')
          ..write('members: $members, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, inviteCode, tier, members, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SquadsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.inviteCode == this.inviteCode &&
          other.tier == this.tier &&
          other.members == this.members &&
          other.createdAt == this.createdAt);
}

class SquadsTableCompanion extends UpdateCompanion<SquadsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> inviteCode;
  final Value<String> tier;
  final Value<List<String>> members;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SquadsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.inviteCode = const Value.absent(),
    this.tier = const Value.absent(),
    this.members = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SquadsTableCompanion.insert({
    required String id,
    required String name,
    this.inviteCode = const Value.absent(),
    this.tier = const Value.absent(),
    required List<String> members,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       members = Value(members),
       createdAt = Value(createdAt);
  static Insertable<SquadsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? inviteCode,
    Expression<String>? tier,
    Expression<String>? members,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (inviteCode != null) 'invite_code': inviteCode,
      if (tier != null) 'tier': tier,
      if (members != null) 'members': members,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SquadsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? inviteCode,
    Value<String>? tier,
    Value<List<String>>? members,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SquadsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      inviteCode: inviteCode ?? this.inviteCode,
      tier: tier ?? this.tier,
      members: members ?? this.members,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (inviteCode.present) {
      map['invite_code'] = Variable<String>(inviteCode.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (members.present) {
      map['members'] = Variable<String>(
        $SquadsTableTable.$convertermembers.toSql(members.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SquadsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('tier: $tier, ')
          ..write('members: $members, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $DailyCheckInsTableTable dailyCheckInsTable =
      $DailyCheckInsTableTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $WorkoutSessionsTableTable workoutSessionsTable =
      $WorkoutSessionsTableTable(this);
  late final $ScheduledWorkoutsTableTable scheduledWorkoutsTable =
      $ScheduledWorkoutsTableTable(this);
  late final $ProgressPhotosTableTable progressPhotosTable =
      $ProgressPhotosTableTable(this);
  late final $JournalEntriesTableTable journalEntriesTable =
      $JournalEntriesTableTable(this);
  late final $WeeklyReviewsTableTable weeklyReviewsTable =
      $WeeklyReviewsTableTable(this);
  late final $CustomWorkoutsTableTable customWorkoutsTable =
      $CustomWorkoutsTableTable(this);
  late final $PactsTableTable pactsTable = $PactsTableTable(this);
  late final $SquadsTableTable squadsTable = $SquadsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    dailyCheckInsTable,
    syncQueue,
    workoutSessionsTable,
    scheduledWorkoutsTable,
    progressPhotosTable,
    journalEntriesTable,
    weeklyReviewsTable,
    customWorkoutsTable,
    pactsTable,
    squadsTable,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String id,
      Value<String?> email,
      Value<String> name,
      Value<String?> avatarUrl,
      Value<String> fitnessLevel,
      Value<String> gender,
      Value<String?> bio,
      Value<int> sweatCoins,
      Value<int> dailyStreak,
      Value<DateTime?> lastCheckIn,
      Value<String> preferredWorkoutHour,
      Value<String> themeMode,
      Value<String> aiTrainerMode,
      Value<String?> partnerId,
      Value<double> startingWeight,
      Value<double> targetWeight,
      Value<double> height,
      Value<int> age,
      Value<String> foodsToAvoid,
      Value<DateTime> startDate,
      Value<int> restTokens,
      Value<String> subscriptionTier,
      Value<double> consistencyScore,
      Value<String?> timezone,
      Value<String?> inviteCode,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> id,
      Value<String?> email,
      Value<String> name,
      Value<String?> avatarUrl,
      Value<String> fitnessLevel,
      Value<String> gender,
      Value<String?> bio,
      Value<int> sweatCoins,
      Value<int> dailyStreak,
      Value<DateTime?> lastCheckIn,
      Value<String> preferredWorkoutHour,
      Value<String> themeMode,
      Value<String> aiTrainerMode,
      Value<String?> partnerId,
      Value<double> startingWeight,
      Value<double> targetWeight,
      Value<double> height,
      Value<int> age,
      Value<String> foodsToAvoid,
      Value<DateTime> startDate,
      Value<int> restTokens,
      Value<String> subscriptionTier,
      Value<double> consistencyScore,
      Value<String?> timezone,
      Value<String?> inviteCode,
      Value<int> rowid,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fitnessLevel => $composableBuilder(
    column: $table.fitnessLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sweatCoins => $composableBuilder(
    column: $table.sweatCoins,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dailyStreak => $composableBuilder(
    column: $table.dailyStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastCheckIn => $composableBuilder(
    column: $table.lastCheckIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredWorkoutHour => $composableBuilder(
    column: $table.preferredWorkoutHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aiTrainerMode => $composableBuilder(
    column: $table.aiTrainerMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partnerId => $composableBuilder(
    column: $table.partnerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startingWeight => $composableBuilder(
    column: $table.startingWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetWeight => $composableBuilder(
    column: $table.targetWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get foodsToAvoid => $composableBuilder(
    column: $table.foodsToAvoid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restTokens => $composableBuilder(
    column: $table.restTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subscriptionTier => $composableBuilder(
    column: $table.subscriptionTier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get consistencyScore => $composableBuilder(
    column: $table.consistencyScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fitnessLevel => $composableBuilder(
    column: $table.fitnessLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sweatCoins => $composableBuilder(
    column: $table.sweatCoins,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dailyStreak => $composableBuilder(
    column: $table.dailyStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastCheckIn => $composableBuilder(
    column: $table.lastCheckIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredWorkoutHour => $composableBuilder(
    column: $table.preferredWorkoutHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aiTrainerMode => $composableBuilder(
    column: $table.aiTrainerMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partnerId => $composableBuilder(
    column: $table.partnerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startingWeight => $composableBuilder(
    column: $table.startingWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetWeight => $composableBuilder(
    column: $table.targetWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get foodsToAvoid => $composableBuilder(
    column: $table.foodsToAvoid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restTokens => $composableBuilder(
    column: $table.restTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subscriptionTier => $composableBuilder(
    column: $table.subscriptionTier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get consistencyScore => $composableBuilder(
    column: $table.consistencyScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get fitnessLevel => $composableBuilder(
    column: $table.fitnessLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get bio =>
      $composableBuilder(column: $table.bio, builder: (column) => column);

  GeneratedColumn<int> get sweatCoins => $composableBuilder(
    column: $table.sweatCoins,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dailyStreak => $composableBuilder(
    column: $table.dailyStreak,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastCheckIn => $composableBuilder(
    column: $table.lastCheckIn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preferredWorkoutHour => $composableBuilder(
    column: $table.preferredWorkoutHour,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get aiTrainerMode => $composableBuilder(
    column: $table.aiTrainerMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get partnerId =>
      $composableBuilder(column: $table.partnerId, builder: (column) => column);

  GeneratedColumn<double> get startingWeight => $composableBuilder(
    column: $table.startingWeight,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetWeight => $composableBuilder(
    column: $table.targetWeight,
    builder: (column) => column,
  );

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get foodsToAvoid => $composableBuilder(
    column: $table.foodsToAvoid,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<int> get restTokens => $composableBuilder(
    column: $table.restTokens,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subscriptionTier => $composableBuilder(
    column: $table.subscriptionTier,
    builder: (column) => column,
  );

  GeneratedColumn<double> get consistencyScore => $composableBuilder(
    column: $table.consistencyScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => column,
  );
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String> fitnessLevel = const Value.absent(),
                Value<String> gender = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<int> sweatCoins = const Value.absent(),
                Value<int> dailyStreak = const Value.absent(),
                Value<DateTime?> lastCheckIn = const Value.absent(),
                Value<String> preferredWorkoutHour = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> aiTrainerMode = const Value.absent(),
                Value<String?> partnerId = const Value.absent(),
                Value<double> startingWeight = const Value.absent(),
                Value<double> targetWeight = const Value.absent(),
                Value<double> height = const Value.absent(),
                Value<int> age = const Value.absent(),
                Value<String> foodsToAvoid = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<int> restTokens = const Value.absent(),
                Value<String> subscriptionTier = const Value.absent(),
                Value<double> consistencyScore = const Value.absent(),
                Value<String?> timezone = const Value.absent(),
                Value<String?> inviteCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                email: email,
                name: name,
                avatarUrl: avatarUrl,
                fitnessLevel: fitnessLevel,
                gender: gender,
                bio: bio,
                sweatCoins: sweatCoins,
                dailyStreak: dailyStreak,
                lastCheckIn: lastCheckIn,
                preferredWorkoutHour: preferredWorkoutHour,
                themeMode: themeMode,
                aiTrainerMode: aiTrainerMode,
                partnerId: partnerId,
                startingWeight: startingWeight,
                targetWeight: targetWeight,
                height: height,
                age: age,
                foodsToAvoid: foodsToAvoid,
                startDate: startDate,
                restTokens: restTokens,
                subscriptionTier: subscriptionTier,
                consistencyScore: consistencyScore,
                timezone: timezone,
                inviteCode: inviteCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> email = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String> fitnessLevel = const Value.absent(),
                Value<String> gender = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<int> sweatCoins = const Value.absent(),
                Value<int> dailyStreak = const Value.absent(),
                Value<DateTime?> lastCheckIn = const Value.absent(),
                Value<String> preferredWorkoutHour = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> aiTrainerMode = const Value.absent(),
                Value<String?> partnerId = const Value.absent(),
                Value<double> startingWeight = const Value.absent(),
                Value<double> targetWeight = const Value.absent(),
                Value<double> height = const Value.absent(),
                Value<int> age = const Value.absent(),
                Value<String> foodsToAvoid = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<int> restTokens = const Value.absent(),
                Value<String> subscriptionTier = const Value.absent(),
                Value<double> consistencyScore = const Value.absent(),
                Value<String?> timezone = const Value.absent(),
                Value<String?> inviteCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                email: email,
                name: name,
                avatarUrl: avatarUrl,
                fitnessLevel: fitnessLevel,
                gender: gender,
                bio: bio,
                sweatCoins: sweatCoins,
                dailyStreak: dailyStreak,
                lastCheckIn: lastCheckIn,
                preferredWorkoutHour: preferredWorkoutHour,
                themeMode: themeMode,
                aiTrainerMode: aiTrainerMode,
                partnerId: partnerId,
                startingWeight: startingWeight,
                targetWeight: targetWeight,
                height: height,
                age: age,
                foodsToAvoid: foodsToAvoid,
                startDate: startDate,
                restTokens: restTokens,
                subscriptionTier: subscriptionTier,
                consistencyScore: consistencyScore,
                timezone: timezone,
                inviteCode: inviteCode,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$DailyCheckInsTableTableCreateCompanionBuilder =
    DailyCheckInsTableCompanion Function({
      required String id,
      required DateTime date,
      Value<bool> moodGood,
      Value<int> energyLevel,
      Value<double?> weight,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$DailyCheckInsTableTableUpdateCompanionBuilder =
    DailyCheckInsTableCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<bool> moodGood,
      Value<int> energyLevel,
      Value<double?> weight,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$DailyCheckInsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DailyCheckInsTableTable> {
  $$DailyCheckInsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get moodGood => $composableBuilder(
    column: $table.moodGood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyCheckInsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyCheckInsTableTable> {
  $$DailyCheckInsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get moodGood => $composableBuilder(
    column: $table.moodGood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyCheckInsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyCheckInsTableTable> {
  $$DailyCheckInsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get moodGood =>
      $composableBuilder(column: $table.moodGood, builder: (column) => column);

  GeneratedColumn<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$DailyCheckInsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyCheckInsTableTable,
          DailyCheckInsTableData,
          $$DailyCheckInsTableTableFilterComposer,
          $$DailyCheckInsTableTableOrderingComposer,
          $$DailyCheckInsTableTableAnnotationComposer,
          $$DailyCheckInsTableTableCreateCompanionBuilder,
          $$DailyCheckInsTableTableUpdateCompanionBuilder,
          (
            DailyCheckInsTableData,
            BaseReferences<
              _$AppDatabase,
              $DailyCheckInsTableTable,
              DailyCheckInsTableData
            >,
          ),
          DailyCheckInsTableData,
          PrefetchHooks Function()
        > {
  $$DailyCheckInsTableTableTableManager(
    _$AppDatabase db,
    $DailyCheckInsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyCheckInsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyCheckInsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyCheckInsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<bool> moodGood = const Value.absent(),
                Value<int> energyLevel = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyCheckInsTableCompanion(
                id: id,
                date: date,
                moodGood: moodGood,
                energyLevel: energyLevel,
                weight: weight,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                Value<bool> moodGood = const Value.absent(),
                Value<int> energyLevel = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyCheckInsTableCompanion.insert(
                id: id,
                date: date,
                moodGood: moodGood,
                energyLevel: energyLevel,
                weight: weight,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyCheckInsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyCheckInsTableTable,
      DailyCheckInsTableData,
      $$DailyCheckInsTableTableFilterComposer,
      $$DailyCheckInsTableTableOrderingComposer,
      $$DailyCheckInsTableTableAnnotationComposer,
      $$DailyCheckInsTableTableCreateCompanionBuilder,
      $$DailyCheckInsTableTableUpdateCompanionBuilder,
      (
        DailyCheckInsTableData,
        BaseReferences<
          _$AppDatabase,
          $DailyCheckInsTableTable,
          DailyCheckInsTableData
        >,
      ),
      DailyCheckInsTableData,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      required String id,
      required String type,
      required Map<String, dynamic> payload,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<Map<String, dynamic>> payload,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>,
    Map<String, dynamic>,
    String
  >
  get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>, String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (
            SyncQueueData,
            BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<Map<String, dynamic>> payload = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                type: type,
                payload: payload,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required Map<String, dynamic> payload,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueCompanion.insert(
                id: id,
                type: type,
                payload: payload,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (
        SyncQueueData,
        BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;
typedef $$WorkoutSessionsTableTableCreateCompanionBuilder =
    WorkoutSessionsTableCompanion Function({
      required String id,
      required String userId,
      required String workoutId,
      required DateTime completedAt,
      Value<int?> durationMinutes,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$WorkoutSessionsTableTableUpdateCompanionBuilder =
    WorkoutSessionsTableCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> workoutId,
      Value<DateTime> completedAt,
      Value<int?> durationMinutes,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$WorkoutSessionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTableTable> {
  $$WorkoutSessionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workoutId => $composableBuilder(
    column: $table.workoutId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutSessionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTableTable> {
  $$WorkoutSessionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workoutId => $composableBuilder(
    column: $table.workoutId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutSessionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTableTable> {
  $$WorkoutSessionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get workoutId =>
      $composableBuilder(column: $table.workoutId, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$WorkoutSessionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutSessionsTableTable,
          WorkoutSessionsTableData,
          $$WorkoutSessionsTableTableFilterComposer,
          $$WorkoutSessionsTableTableOrderingComposer,
          $$WorkoutSessionsTableTableAnnotationComposer,
          $$WorkoutSessionsTableTableCreateCompanionBuilder,
          $$WorkoutSessionsTableTableUpdateCompanionBuilder,
          (
            WorkoutSessionsTableData,
            BaseReferences<
              _$AppDatabase,
              $WorkoutSessionsTableTable,
              WorkoutSessionsTableData
            >,
          ),
          WorkoutSessionsTableData,
          PrefetchHooks Function()
        > {
  $$WorkoutSessionsTableTableTableManager(
    _$AppDatabase db,
    $WorkoutSessionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSessionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSessionsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WorkoutSessionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> workoutId = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSessionsTableCompanion(
                id: id,
                userId: userId,
                workoutId: workoutId,
                completedAt: completedAt,
                durationMinutes: durationMinutes,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String workoutId,
                required DateTime completedAt,
                Value<int?> durationMinutes = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSessionsTableCompanion.insert(
                id: id,
                userId: userId,
                workoutId: workoutId,
                completedAt: completedAt,
                durationMinutes: durationMinutes,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutSessionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutSessionsTableTable,
      WorkoutSessionsTableData,
      $$WorkoutSessionsTableTableFilterComposer,
      $$WorkoutSessionsTableTableOrderingComposer,
      $$WorkoutSessionsTableTableAnnotationComposer,
      $$WorkoutSessionsTableTableCreateCompanionBuilder,
      $$WorkoutSessionsTableTableUpdateCompanionBuilder,
      (
        WorkoutSessionsTableData,
        BaseReferences<
          _$AppDatabase,
          $WorkoutSessionsTableTable,
          WorkoutSessionsTableData
        >,
      ),
      WorkoutSessionsTableData,
      PrefetchHooks Function()
    >;
typedef $$ScheduledWorkoutsTableTableCreateCompanionBuilder =
    ScheduledWorkoutsTableCompanion Function({
      required String id,
      required String userId,
      required String workoutId,
      required DateTime scheduledDate,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });
typedef $$ScheduledWorkoutsTableTableUpdateCompanionBuilder =
    ScheduledWorkoutsTableCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> workoutId,
      Value<DateTime> scheduledDate,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });

class $$ScheduledWorkoutsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduledWorkoutsTableTable> {
  $$ScheduledWorkoutsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workoutId => $composableBuilder(
    column: $table.workoutId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScheduledWorkoutsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduledWorkoutsTableTable> {
  $$ScheduledWorkoutsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workoutId => $composableBuilder(
    column: $table.workoutId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScheduledWorkoutsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduledWorkoutsTableTable> {
  $$ScheduledWorkoutsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get workoutId =>
      $composableBuilder(column: $table.workoutId, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$ScheduledWorkoutsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScheduledWorkoutsTableTable,
          ScheduledWorkoutsTableData,
          $$ScheduledWorkoutsTableTableFilterComposer,
          $$ScheduledWorkoutsTableTableOrderingComposer,
          $$ScheduledWorkoutsTableTableAnnotationComposer,
          $$ScheduledWorkoutsTableTableCreateCompanionBuilder,
          $$ScheduledWorkoutsTableTableUpdateCompanionBuilder,
          (
            ScheduledWorkoutsTableData,
            BaseReferences<
              _$AppDatabase,
              $ScheduledWorkoutsTableTable,
              ScheduledWorkoutsTableData
            >,
          ),
          ScheduledWorkoutsTableData,
          PrefetchHooks Function()
        > {
  $$ScheduledWorkoutsTableTableTableManager(
    _$AppDatabase db,
    $ScheduledWorkoutsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduledWorkoutsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ScheduledWorkoutsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ScheduledWorkoutsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> workoutId = const Value.absent(),
                Value<DateTime> scheduledDate = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScheduledWorkoutsTableCompanion(
                id: id,
                userId: userId,
                workoutId: workoutId,
                scheduledDate: scheduledDate,
                isCompleted: isCompleted,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String workoutId,
                required DateTime scheduledDate,
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScheduledWorkoutsTableCompanion.insert(
                id: id,
                userId: userId,
                workoutId: workoutId,
                scheduledDate: scheduledDate,
                isCompleted: isCompleted,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScheduledWorkoutsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScheduledWorkoutsTableTable,
      ScheduledWorkoutsTableData,
      $$ScheduledWorkoutsTableTableFilterComposer,
      $$ScheduledWorkoutsTableTableOrderingComposer,
      $$ScheduledWorkoutsTableTableAnnotationComposer,
      $$ScheduledWorkoutsTableTableCreateCompanionBuilder,
      $$ScheduledWorkoutsTableTableUpdateCompanionBuilder,
      (
        ScheduledWorkoutsTableData,
        BaseReferences<
          _$AppDatabase,
          $ScheduledWorkoutsTableTable,
          ScheduledWorkoutsTableData
        >,
      ),
      ScheduledWorkoutsTableData,
      PrefetchHooks Function()
    >;
typedef $$ProgressPhotosTableTableCreateCompanionBuilder =
    ProgressPhotosTableCompanion Function({
      required String id,
      required String userId,
      required DateTime date,
      required String imagePath,
      Value<double?> weight,
      Value<String> notes,
      Value<int> rowid,
    });
typedef $$ProgressPhotosTableTableUpdateCompanionBuilder =
    ProgressPhotosTableCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<DateTime> date,
      Value<String> imagePath,
      Value<double?> weight,
      Value<String> notes,
      Value<int> rowid,
    });

class $$ProgressPhotosTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProgressPhotosTableTable> {
  $$ProgressPhotosTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProgressPhotosTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgressPhotosTableTable> {
  $$ProgressPhotosTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProgressPhotosTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgressPhotosTableTable> {
  $$ProgressPhotosTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$ProgressPhotosTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgressPhotosTableTable,
          ProgressPhotosTableData,
          $$ProgressPhotosTableTableFilterComposer,
          $$ProgressPhotosTableTableOrderingComposer,
          $$ProgressPhotosTableTableAnnotationComposer,
          $$ProgressPhotosTableTableCreateCompanionBuilder,
          $$ProgressPhotosTableTableUpdateCompanionBuilder,
          (
            ProgressPhotosTableData,
            BaseReferences<
              _$AppDatabase,
              $ProgressPhotosTableTable,
              ProgressPhotosTableData
            >,
          ),
          ProgressPhotosTableData,
          PrefetchHooks Function()
        > {
  $$ProgressPhotosTableTableTableManager(
    _$AppDatabase db,
    $ProgressPhotosTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgressPhotosTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgressPhotosTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ProgressPhotosTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgressPhotosTableCompanion(
                id: id,
                userId: userId,
                date: date,
                imagePath: imagePath,
                weight: weight,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required DateTime date,
                required String imagePath,
                Value<double?> weight = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgressPhotosTableCompanion.insert(
                id: id,
                userId: userId,
                date: date,
                imagePath: imagePath,
                weight: weight,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProgressPhotosTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgressPhotosTableTable,
      ProgressPhotosTableData,
      $$ProgressPhotosTableTableFilterComposer,
      $$ProgressPhotosTableTableOrderingComposer,
      $$ProgressPhotosTableTableAnnotationComposer,
      $$ProgressPhotosTableTableCreateCompanionBuilder,
      $$ProgressPhotosTableTableUpdateCompanionBuilder,
      (
        ProgressPhotosTableData,
        BaseReferences<
          _$AppDatabase,
          $ProgressPhotosTableTable,
          ProgressPhotosTableData
        >,
      ),
      ProgressPhotosTableData,
      PrefetchHooks Function()
    >;
typedef $$JournalEntriesTableTableCreateCompanionBuilder =
    JournalEntriesTableCompanion Function({
      required String id,
      required String userId,
      required String content,
      required String mood,
      required DateTime entryDateTime,
      Value<int> rowid,
    });
typedef $$JournalEntriesTableTableUpdateCompanionBuilder =
    JournalEntriesTableCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> content,
      Value<String> mood,
      Value<DateTime> entryDateTime,
      Value<int> rowid,
    });

class $$JournalEntriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $JournalEntriesTableTable> {
  $$JournalEntriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get entryDateTime => $composableBuilder(
    column: $table.entryDateTime,
    builder: (column) => ColumnFilters(column),
  );
}

class $$JournalEntriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalEntriesTableTable> {
  $$JournalEntriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get entryDateTime => $composableBuilder(
    column: $table.entryDateTime,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JournalEntriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalEntriesTableTable> {
  $$JournalEntriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<DateTime> get entryDateTime => $composableBuilder(
    column: $table.entryDateTime,
    builder: (column) => column,
  );
}

class $$JournalEntriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalEntriesTableTable,
          JournalEntriesTableData,
          $$JournalEntriesTableTableFilterComposer,
          $$JournalEntriesTableTableOrderingComposer,
          $$JournalEntriesTableTableAnnotationComposer,
          $$JournalEntriesTableTableCreateCompanionBuilder,
          $$JournalEntriesTableTableUpdateCompanionBuilder,
          (
            JournalEntriesTableData,
            BaseReferences<
              _$AppDatabase,
              $JournalEntriesTableTable,
              JournalEntriesTableData
            >,
          ),
          JournalEntriesTableData,
          PrefetchHooks Function()
        > {
  $$JournalEntriesTableTableTableManager(
    _$AppDatabase db,
    $JournalEntriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntriesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$JournalEntriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> mood = const Value.absent(),
                Value<DateTime> entryDateTime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JournalEntriesTableCompanion(
                id: id,
                userId: userId,
                content: content,
                mood: mood,
                entryDateTime: entryDateTime,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String content,
                required String mood,
                required DateTime entryDateTime,
                Value<int> rowid = const Value.absent(),
              }) => JournalEntriesTableCompanion.insert(
                id: id,
                userId: userId,
                content: content,
                mood: mood,
                entryDateTime: entryDateTime,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$JournalEntriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalEntriesTableTable,
      JournalEntriesTableData,
      $$JournalEntriesTableTableFilterComposer,
      $$JournalEntriesTableTableOrderingComposer,
      $$JournalEntriesTableTableAnnotationComposer,
      $$JournalEntriesTableTableCreateCompanionBuilder,
      $$JournalEntriesTableTableUpdateCompanionBuilder,
      (
        JournalEntriesTableData,
        BaseReferences<
          _$AppDatabase,
          $JournalEntriesTableTable,
          JournalEntriesTableData
        >,
      ),
      JournalEntriesTableData,
      PrefetchHooks Function()
    >;
typedef $$WeeklyReviewsTableTableCreateCompanionBuilder =
    WeeklyReviewsTableCompanion Function({
      required String id,
      required String userId,
      required DateTime date,
      required double weight,
      required double waist,
      required int consistencyScore,
      Value<String> notes,
      Value<int> rowid,
    });
typedef $$WeeklyReviewsTableTableUpdateCompanionBuilder =
    WeeklyReviewsTableCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<DateTime> date,
      Value<double> weight,
      Value<double> waist,
      Value<int> consistencyScore,
      Value<String> notes,
      Value<int> rowid,
    });

class $$WeeklyReviewsTableTableFilterComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTableTable> {
  $$WeeklyReviewsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waist => $composableBuilder(
    column: $table.waist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get consistencyScore => $composableBuilder(
    column: $table.consistencyScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WeeklyReviewsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTableTable> {
  $$WeeklyReviewsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waist => $composableBuilder(
    column: $table.waist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get consistencyScore => $composableBuilder(
    column: $table.consistencyScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeeklyReviewsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTableTable> {
  $$WeeklyReviewsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<double> get waist =>
      $composableBuilder(column: $table.waist, builder: (column) => column);

  GeneratedColumn<int> get consistencyScore => $composableBuilder(
    column: $table.consistencyScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$WeeklyReviewsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeeklyReviewsTableTable,
          WeeklyReviewsTableData,
          $$WeeklyReviewsTableTableFilterComposer,
          $$WeeklyReviewsTableTableOrderingComposer,
          $$WeeklyReviewsTableTableAnnotationComposer,
          $$WeeklyReviewsTableTableCreateCompanionBuilder,
          $$WeeklyReviewsTableTableUpdateCompanionBuilder,
          (
            WeeklyReviewsTableData,
            BaseReferences<
              _$AppDatabase,
              $WeeklyReviewsTableTable,
              WeeklyReviewsTableData
            >,
          ),
          WeeklyReviewsTableData,
          PrefetchHooks Function()
        > {
  $$WeeklyReviewsTableTableTableManager(
    _$AppDatabase db,
    $WeeklyReviewsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeeklyReviewsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeeklyReviewsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeeklyReviewsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<double> waist = const Value.absent(),
                Value<int> consistencyScore = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklyReviewsTableCompanion(
                id: id,
                userId: userId,
                date: date,
                weight: weight,
                waist: waist,
                consistencyScore: consistencyScore,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required DateTime date,
                required double weight,
                required double waist,
                required int consistencyScore,
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklyReviewsTableCompanion.insert(
                id: id,
                userId: userId,
                date: date,
                weight: weight,
                waist: waist,
                consistencyScore: consistencyScore,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeeklyReviewsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeeklyReviewsTableTable,
      WeeklyReviewsTableData,
      $$WeeklyReviewsTableTableFilterComposer,
      $$WeeklyReviewsTableTableOrderingComposer,
      $$WeeklyReviewsTableTableAnnotationComposer,
      $$WeeklyReviewsTableTableCreateCompanionBuilder,
      $$WeeklyReviewsTableTableUpdateCompanionBuilder,
      (
        WeeklyReviewsTableData,
        BaseReferences<
          _$AppDatabase,
          $WeeklyReviewsTableTable,
          WeeklyReviewsTableData
        >,
      ),
      WeeklyReviewsTableData,
      PrefetchHooks Function()
    >;
typedef $$CustomWorkoutsTableTableCreateCompanionBuilder =
    CustomWorkoutsTableCompanion Function({
      required String id,
      required String userId,
      required String name,
      Value<String?> description,
      required Map<String, dynamic> exercises,
      Value<int?> estimatedDuration,
      Value<String> difficulty,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$CustomWorkoutsTableTableUpdateCompanionBuilder =
    CustomWorkoutsTableCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> name,
      Value<String?> description,
      Value<Map<String, dynamic>> exercises,
      Value<int?> estimatedDuration,
      Value<String> difficulty,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$CustomWorkoutsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CustomWorkoutsTableTable> {
  $$CustomWorkoutsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>,
    Map<String, dynamic>,
    String
  >
  get exercises => $composableBuilder(
    column: $table.exercises,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get estimatedDuration => $composableBuilder(
    column: $table.estimatedDuration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomWorkoutsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomWorkoutsTableTable> {
  $$CustomWorkoutsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exercises => $composableBuilder(
    column: $table.exercises,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedDuration => $composableBuilder(
    column: $table.estimatedDuration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomWorkoutsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomWorkoutsTableTable> {
  $$CustomWorkoutsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  get exercises =>
      $composableBuilder(column: $table.exercises, builder: (column) => column);

  GeneratedColumn<int> get estimatedDuration => $composableBuilder(
    column: $table.estimatedDuration,
    builder: (column) => column,
  );

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CustomWorkoutsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomWorkoutsTableTable,
          CustomWorkoutsTableData,
          $$CustomWorkoutsTableTableFilterComposer,
          $$CustomWorkoutsTableTableOrderingComposer,
          $$CustomWorkoutsTableTableAnnotationComposer,
          $$CustomWorkoutsTableTableCreateCompanionBuilder,
          $$CustomWorkoutsTableTableUpdateCompanionBuilder,
          (
            CustomWorkoutsTableData,
            BaseReferences<
              _$AppDatabase,
              $CustomWorkoutsTableTable,
              CustomWorkoutsTableData
            >,
          ),
          CustomWorkoutsTableData,
          PrefetchHooks Function()
        > {
  $$CustomWorkoutsTableTableTableManager(
    _$AppDatabase db,
    $CustomWorkoutsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomWorkoutsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomWorkoutsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CustomWorkoutsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<Map<String, dynamic>> exercises = const Value.absent(),
                Value<int?> estimatedDuration = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomWorkoutsTableCompanion(
                id: id,
                userId: userId,
                name: name,
                description: description,
                exercises: exercises,
                estimatedDuration: estimatedDuration,
                difficulty: difficulty,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String name,
                Value<String?> description = const Value.absent(),
                required Map<String, dynamic> exercises,
                Value<int?> estimatedDuration = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CustomWorkoutsTableCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                description: description,
                exercises: exercises,
                estimatedDuration: estimatedDuration,
                difficulty: difficulty,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomWorkoutsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomWorkoutsTableTable,
      CustomWorkoutsTableData,
      $$CustomWorkoutsTableTableFilterComposer,
      $$CustomWorkoutsTableTableOrderingComposer,
      $$CustomWorkoutsTableTableAnnotationComposer,
      $$CustomWorkoutsTableTableCreateCompanionBuilder,
      $$CustomWorkoutsTableTableUpdateCompanionBuilder,
      (
        CustomWorkoutsTableData,
        BaseReferences<
          _$AppDatabase,
          $CustomWorkoutsTableTable,
          CustomWorkoutsTableData
        >,
      ),
      CustomWorkoutsTableData,
      PrefetchHooks Function()
    >;
typedef $$PactsTableTableCreateCompanionBuilder =
    PactsTableCompanion Function({
      required String id,
      required String title,
      Value<String?> squadId,
      required String frequency,
      required int targetCount,
      Value<int> currentStreak,
      Value<String> status,
      Value<DateTime?> lastCheckedAt,
      required DateTime createdAt,
      Value<double> wagerAmount,
      Value<DateTime?> deadline,
      Value<int> rowid,
    });
typedef $$PactsTableTableUpdateCompanionBuilder =
    PactsTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> squadId,
      Value<String> frequency,
      Value<int> targetCount,
      Value<int> currentStreak,
      Value<String> status,
      Value<DateTime?> lastCheckedAt,
      Value<DateTime> createdAt,
      Value<double> wagerAmount,
      Value<DateTime?> deadline,
      Value<int> rowid,
    });

class $$PactsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PactsTableTable> {
  $$PactsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get squadId => $composableBuilder(
    column: $table.squadId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetCount => $composableBuilder(
    column: $table.targetCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastCheckedAt => $composableBuilder(
    column: $table.lastCheckedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wagerAmount => $composableBuilder(
    column: $table.wagerAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PactsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PactsTableTable> {
  $$PactsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get squadId => $composableBuilder(
    column: $table.squadId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetCount => $composableBuilder(
    column: $table.targetCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastCheckedAt => $composableBuilder(
    column: $table.lastCheckedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wagerAmount => $composableBuilder(
    column: $table.wagerAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PactsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PactsTableTable> {
  $$PactsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get squadId =>
      $composableBuilder(column: $table.squadId, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get targetCount => $composableBuilder(
    column: $table.targetCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get lastCheckedAt => $composableBuilder(
    column: $table.lastCheckedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get wagerAmount => $composableBuilder(
    column: $table.wagerAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);
}

class $$PactsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PactsTableTable,
          PactsTableData,
          $$PactsTableTableFilterComposer,
          $$PactsTableTableOrderingComposer,
          $$PactsTableTableAnnotationComposer,
          $$PactsTableTableCreateCompanionBuilder,
          $$PactsTableTableUpdateCompanionBuilder,
          (
            PactsTableData,
            BaseReferences<_$AppDatabase, $PactsTableTable, PactsTableData>,
          ),
          PactsTableData,
          PrefetchHooks Function()
        > {
  $$PactsTableTableTableManager(_$AppDatabase db, $PactsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PactsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PactsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PactsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> squadId = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                Value<int> targetCount = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> lastCheckedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double> wagerAmount = const Value.absent(),
                Value<DateTime?> deadline = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PactsTableCompanion(
                id: id,
                title: title,
                squadId: squadId,
                frequency: frequency,
                targetCount: targetCount,
                currentStreak: currentStreak,
                status: status,
                lastCheckedAt: lastCheckedAt,
                createdAt: createdAt,
                wagerAmount: wagerAmount,
                deadline: deadline,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> squadId = const Value.absent(),
                required String frequency,
                required int targetCount,
                Value<int> currentStreak = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> lastCheckedAt = const Value.absent(),
                required DateTime createdAt,
                Value<double> wagerAmount = const Value.absent(),
                Value<DateTime?> deadline = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PactsTableCompanion.insert(
                id: id,
                title: title,
                squadId: squadId,
                frequency: frequency,
                targetCount: targetCount,
                currentStreak: currentStreak,
                status: status,
                lastCheckedAt: lastCheckedAt,
                createdAt: createdAt,
                wagerAmount: wagerAmount,
                deadline: deadline,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PactsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PactsTableTable,
      PactsTableData,
      $$PactsTableTableFilterComposer,
      $$PactsTableTableOrderingComposer,
      $$PactsTableTableAnnotationComposer,
      $$PactsTableTableCreateCompanionBuilder,
      $$PactsTableTableUpdateCompanionBuilder,
      (
        PactsTableData,
        BaseReferences<_$AppDatabase, $PactsTableTable, PactsTableData>,
      ),
      PactsTableData,
      PrefetchHooks Function()
    >;
typedef $$SquadsTableTableCreateCompanionBuilder =
    SquadsTableCompanion Function({
      required String id,
      required String name,
      Value<String?> inviteCode,
      Value<String> tier,
      required List<String> members,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SquadsTableTableUpdateCompanionBuilder =
    SquadsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> inviteCode,
      Value<String> tier,
      Value<List<String>> members,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SquadsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SquadsTableTable> {
  $$SquadsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get members => $composableBuilder(
    column: $table.members,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SquadsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SquadsTableTable> {
  $$SquadsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get members => $composableBuilder(
    column: $table.members,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SquadsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SquadsTableTable> {
  $$SquadsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get members =>
      $composableBuilder(column: $table.members, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SquadsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SquadsTableTable,
          SquadsTableData,
          $$SquadsTableTableFilterComposer,
          $$SquadsTableTableOrderingComposer,
          $$SquadsTableTableAnnotationComposer,
          $$SquadsTableTableCreateCompanionBuilder,
          $$SquadsTableTableUpdateCompanionBuilder,
          (
            SquadsTableData,
            BaseReferences<_$AppDatabase, $SquadsTableTable, SquadsTableData>,
          ),
          SquadsTableData,
          PrefetchHooks Function()
        > {
  $$SquadsTableTableTableManager(_$AppDatabase db, $SquadsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SquadsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SquadsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SquadsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> inviteCode = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<List<String>> members = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SquadsTableCompanion(
                id: id,
                name: name,
                inviteCode: inviteCode,
                tier: tier,
                members: members,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> inviteCode = const Value.absent(),
                Value<String> tier = const Value.absent(),
                required List<String> members,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SquadsTableCompanion.insert(
                id: id,
                name: name,
                inviteCode: inviteCode,
                tier: tier,
                members: members,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SquadsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SquadsTableTable,
      SquadsTableData,
      $$SquadsTableTableFilterComposer,
      $$SquadsTableTableOrderingComposer,
      $$SquadsTableTableAnnotationComposer,
      $$SquadsTableTableCreateCompanionBuilder,
      $$SquadsTableTableUpdateCompanionBuilder,
      (
        SquadsTableData,
        BaseReferences<_$AppDatabase, $SquadsTableTable, SquadsTableData>,
      ),
      SquadsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$DailyCheckInsTableTableTableManager get dailyCheckInsTable =>
      $$DailyCheckInsTableTableTableManager(_db, _db.dailyCheckInsTable);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$WorkoutSessionsTableTableTableManager get workoutSessionsTable =>
      $$WorkoutSessionsTableTableTableManager(_db, _db.workoutSessionsTable);
  $$ScheduledWorkoutsTableTableTableManager get scheduledWorkoutsTable =>
      $$ScheduledWorkoutsTableTableTableManager(
        _db,
        _db.scheduledWorkoutsTable,
      );
  $$ProgressPhotosTableTableTableManager get progressPhotosTable =>
      $$ProgressPhotosTableTableTableManager(_db, _db.progressPhotosTable);
  $$JournalEntriesTableTableTableManager get journalEntriesTable =>
      $$JournalEntriesTableTableTableManager(_db, _db.journalEntriesTable);
  $$WeeklyReviewsTableTableTableManager get weeklyReviewsTable =>
      $$WeeklyReviewsTableTableTableManager(_db, _db.weeklyReviewsTable);
  $$CustomWorkoutsTableTableTableManager get customWorkoutsTable =>
      $$CustomWorkoutsTableTableTableManager(_db, _db.customWorkoutsTable);
  $$PactsTableTableTableManager get pactsTable =>
      $$PactsTableTableTableManager(_db, _db.pactsTable);
  $$SquadsTableTableTableManager get squadsTable =>
      $$SquadsTableTableTableManager(_db, _db.squadsTable);
}
