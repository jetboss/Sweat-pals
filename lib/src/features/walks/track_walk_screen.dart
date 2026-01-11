import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../providers/walk_tracker_provider.dart';
import '../../providers/workout_progress_provider.dart';
import '../../services/walk_tracker_service.dart';
import '../../theme/app_colors.dart';

/// Screen for tracking a walk with GPS
class TrackWalkScreen extends ConsumerStatefulWidget {
  const TrackWalkScreen({super.key});

  @override
  ConsumerState<TrackWalkScreen> createState() => _TrackWalkScreenState();
}

class _TrackWalkScreenState extends ConsumerState<TrackWalkScreen> {
  final MapController _mapController = MapController();
  Timer? _durationTimer;
  Duration _elapsed = Duration.zero;
  final List<LatLng> _routePoints = [];

  @override
  void initState() {
    super.initState();
    _listenToLocationUpdates();
  }

  void _listenToLocationUpdates() {
    WalkTrackerService.instance.locationStream.listen((position) {
      if (mounted) {
        setState(() {
          _routePoints.add(LatLng(position.latitude, position.longitude));
        });
        // Center map on current location
        _mapController.move(
          LatLng(position.latitude, position.longitude),
          _mapController.camera.zoom,
        );
      }
    });
  }

  void _startDurationTimer() {
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        final session = WalkTrackerService.instance.currentSession;
        if (session != null) {
          setState(() {
            _elapsed = session.duration;
          });
        }
      }
    });
  }

  void _stopDurationTimer() {
    _durationTimer?.cancel();
    _durationTimer = null;
  }

  @override
  void dispose() {
    _stopDurationTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trackerState = ref.watch(walkTrackerProvider);
    final session = WalkTrackerService.instance.currentSession;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Walk'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _routePoints.isNotEmpty 
                  ? _routePoints.last 
                  : const LatLng(18.5204, -69.9585), // Default: Santo Domingo
              initialZoom: 17,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.sweatpals',
              ),
              // Route polyline
              if (_routePoints.length >= 2)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      color: AppColors.primary,
                      strokeWidth: 5,
                    ),
                  ],
                ),
              // Current location marker
              if (_routePoints.isNotEmpty)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _routePoints.last,
                      width: 30,
                      height: 30,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.directions_walk,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          
          // Stats overlay
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: _buildStatsCard(session),
          ),
          
          // Control buttons
          Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: _buildControls(trackerState),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(dynamic session) {
    final distance = session?.distanceKm ?? 0.0;
    final pace = session?.formattedPace ?? '--:-- /km';
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
              _formatDuration(_elapsed),
              'Time',
              Icons.timer,
            ),
            Container(height: 40, width: 1, color: Colors.grey[300]),
            _buildStatItem(
              '${distance.toStringAsFixed(2)} km',
              'Distance',
              Icons.straighten,
            ),
            Container(height: 40, width: 1, color: Colors.grey[300]),
            _buildStatItem(
              pace,
              'Pace',
              Icons.speed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildControls(WalkTrackerState state) {
    if (state.isIdle) {
      return _buildStartButton();
    } else if (state.isTracking) {
      return _buildTrackingControls();
    } else if (state.isPaused) {
      return _buildPausedControls();
    } else if (state.status == WalkTrackerStatus.starting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return _buildStartButton();
  }

  Widget _buildStartButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () async {
          await ref.read(walkTrackerProvider.notifier).startWalk();
          _routePoints.clear();
          _startDurationTimer();
        },
        icon: const Icon(Icons.play_arrow, size: 32),
        label: const Text('Start Walk', style: TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }

  Widget _buildTrackingControls() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              ref.read(walkTrackerProvider.notifier).pauseWalk();
            },
            icon: const Icon(Icons.pause),
            label: const Text('Pause'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _stopAndShowSummary(),
            icon: const Icon(Icons.stop),
            label: const Text('Stop'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPausedControls() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              ref.read(walkTrackerProvider.notifier).resumeWalk();
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Resume'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _stopAndShowSummary(),
            icon: const Icon(Icons.stop),
            label: const Text('Stop'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  void _stopAndShowSummary() {
    _stopDurationTimer();
    final session = ref.read(walkTrackerProvider.notifier).stopWalk();
    
    if (session != null) {
      // Award XP and update streak
      ref.read(workoutProgressProvider.notifier).completeWalk(
        distanceKm: session.distanceKm,
        duration: session.duration,
      );
      
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (ctx) => _WalkSummarySheet(session: session),
      ).then((_) {
        ref.read(walkTrackerProvider.notifier).reset();
        if (mounted) Navigator.pop(context);
      });
    }
  }

  String _formatDuration(Duration d) {
    if (d.inHours > 0) {
      return '${d.inHours}:${(d.inMinutes % 60).toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}

class _WalkSummarySheet extends StatelessWidget {
  final dynamic session;

  const _WalkSummarySheet({required this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 60),
          const SizedBox(height: 16),
          const Text(
            'Walk Complete!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryStat('${session.distanceKm.toStringAsFixed(2)} km', 'Distance'),
              _buildSummaryStat(session.formattedDuration, 'Duration'),
              _buildSummaryStat(session.formattedPace, 'Avg Pace'),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
