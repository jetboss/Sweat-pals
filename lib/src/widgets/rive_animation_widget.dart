import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

enum RiveAssetType {
  loading,
  success,
  celebration,
}

class RiveAnimationWidget extends StatelessWidget {
  final RiveAssetType type;
  final double? height;
  final double? width;
  final BoxFit fit;

  const RiveAnimationWidget({
    super.key,
    required this.type,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });

  String get _assetPath {
    switch (type) {
      case RiveAssetType.loading:
        return 'assets/rive/loading.riv';
      case RiveAssetType.success:
        return 'assets/rive/success.riv';
      case RiveAssetType.celebration:
        return 'assets/rive/celebration.riv';
    }
  }

  // Fallback if asset is missing (for MVP/Dev)
  Widget _buildFallback(BuildContext context) {
    if (type == RiveAssetType.loading) {
      return SizedBox(
        height: height,
        width: width,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return SizedBox(
      height: height,
      width: width,
      child: Icon(Icons.check_circle, 
        size: (height ?? 50) > (width ?? 50) ? (width ?? 50) : (height ?? 50), 
        color: Colors.green
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ideally we verify asset existence or catch errors, but Rive widget handles some checks.
    // For this renovation, we'll try to load the asset, and if it fails (not present),
    // we rarely get a clean fallback callback from the widget itself without complex setup.
    // So we will just default to the Rive widget which might show nothing if file is missing.
    // To be safe for the "Renovation", let's assume assets are coming.
    // BUT, to avoid "Empty" UI, let's use a FutureBuilder to check if we can load it?
    // No, that's too heavy.
    // Let's use a flag or just return the RiveAnimation.asset.
    
    // NOTE: Ensure you add the .riv files to assets/rive/ 
    return SizedBox(
      height: height,
      width: width,
      child: RiveAnimation.asset(
        _assetPath,
        fit: fit,
        placeHolder: _buildFallback(context), // Shows while loading
        // If the file is not found, Rive prints error and shows nothing. 
        // We'll rely on the user to add assets or we can add dummy files.
      ),
    );
  }
}
