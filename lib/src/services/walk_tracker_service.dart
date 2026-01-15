import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/walk_session.dart';

/// Service for GPS-based walk tracking
class WalkTrackerService {
  static WalkTrackerService? _instance;
  static WalkTrackerService get instance => _instance ??= WalkTrackerService._();
  
  WalkTrackerService._();
  
  StreamSubscription<Position>? _positionSubscription;
  final _locationController = StreamController<Position>.broadcast();
  final _sessionController = StreamController<WalkSession>.broadcast();
  
  WalkSession? _currentSession;
  final List<GpsPoint> _currentRoute = [];
  double _totalDistance = 0;
  Position? _lastPosition;
  
  /// Whether currently tracking a walk
  bool get isTracking => _currentSession != null && _positionSubscription != null;
  
  /// Stream of location updates
  Stream<Position> get locationStream => _locationController.stream;
  
  /// Stream of session updates (distance, duration changes)
  Stream<WalkSession> get sessionStream => _sessionController.stream;
  
  /// Current session (if tracking)
  WalkSession? get currentSession => _currentSession;
  
  /// Request location permission
  Future<bool> requestPermission() async {
    // First check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services disabled');
      return false;
    }
    
    // Request permission
    final status = await Permission.locationWhenInUse.request();
    debugPrint('Location permission: $status');
    return status.isGranted;
  }
  
  /// Check if permission is granted
  Future<bool> hasPermission() async {
    return await Permission.locationWhenInUse.isGranted;
  }
  
  /// Start tracking a walk
  Future<bool> startWalk() async {
    if (isTracking) {
      debugPrint('Already tracking a walk');
      return false;
    }
    
    final granted = await requestPermission();
    if (!granted) {
      debugPrint('Location permission denied');
      return false;
    }
    
    // Get initial position
    try {
      final initialPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      _lastPosition = initialPosition;
      _currentRoute.clear();
      _totalDistance = 0;
      
      // Add initial point
      _currentRoute.add(GpsPoint(
        latitude: initialPosition.latitude,
        longitude: initialPosition.longitude,
        timestamp: DateTime.now(),
      ));
      
      // Create session
      _currentSession = WalkSession(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        startTime: DateTime.now(),
        route: List.from(_currentRoute),
        distanceMeters: 0,
      );
      
      // Start listening to position updates
      _positionSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 5, // Update every 5 meters
        ),
      ).listen(_onPositionUpdate, onError: (e) {
        debugPrint('Position stream error: $e');
      });
      
      debugPrint('Walk tracking started');
      _sessionController.add(_currentSession!);
      return true;
    } catch (e) {
      debugPrint('Error starting walk: $e');
      return false;
    }
  }
  
  /// Handle position updates
  void _onPositionUpdate(Position position) {
    if (_currentSession == null) return;
    
    _locationController.add(position);
    
    // Add point to route
    _currentRoute.add(GpsPoint(
      latitude: position.latitude,
      longitude: position.longitude,
      timestamp: DateTime.now(),
    ));
    
    // Calculate distance from last position
    if (_lastPosition != null) {
      final distance = _calculateDistance(
        _lastPosition!.latitude,
        _lastPosition!.longitude,
        position.latitude,
        position.longitude,
      );
      _totalDistance += distance;
    }
    
    _lastPosition = position;
    
    // Update session
    _currentSession = _currentSession!.copyWith(
      route: List.from(_currentRoute),
      distanceMeters: _totalDistance,
    );
    
    _sessionController.add(_currentSession!);
    debugPrint('Distance: ${_totalDistance.toStringAsFixed(0)}m, Points: ${_currentRoute.length}');
  }
  
  /// Stop tracking and return the completed session
  WalkSession? stopWalk() {
    if (!isTracking) {
      debugPrint('Not tracking a walk');
      return null;
    }
    
    _positionSubscription?.cancel();
    _positionSubscription = null;
    
    // Finalize session
    final completedSession = _currentSession?.copyWith(
      endTime: DateTime.now(),
      route: List.from(_currentRoute),
      distanceMeters: _totalDistance,
    );
    
    _currentSession = null;
    _currentRoute.clear();
    _totalDistance = 0;
    _lastPosition = null;
    
    debugPrint('Walk tracking stopped: ${completedSession?.distanceMeters.toStringAsFixed(0)}m');
    return completedSession;
  }
  
  /// Pause tracking (keeps session but stops updates)
  void pauseWalk() {
    _positionSubscription?.pause();
    debugPrint('Walk tracking paused');
  }
  
  /// Resume tracking
  void resumeWalk() {
    _positionSubscription?.resume();
    debugPrint('Walk tracking resumed');
  }
  
  /// Calculate distance between two coordinates using Haversine formula
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371000.0; // meters
    
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) * math.cos(_toRadians(lat2)) *
        math.sin(dLon / 2) * math.sin(dLon / 2);
    
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    
    return earthRadius * c;
  }
  
  double _toRadians(double degrees) => degrees * math.pi / 180;
  
  /// Dispose resources
  void dispose() {
    _positionSubscription?.cancel();
    _locationController.close();
    _sessionController.close();
  }
}
