import 'package:flutter/material.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

class GlobalLoader {
  static final String _imagePath = 'assets/check-list.png';
  static final double _appIconSize = 38.0;
  static final double _borderRadius = 35.0;
  static final double _overlayOpacity = 0.90;
  static final Color _circularProgressColor = Colors.amberAccent;
  static final Color _overlayBackgroundColor = Colors.black.withOpacity(0.5);

  static Widget build({
    required bool isLoading,
    required Widget child,
  }) {
    return OverlayLoaderWithAppIcon(
      isProgressEnabled: false,
      isLoading: isLoading,
      appIcon: Image.asset(_imagePath),
      appIconSize: _appIconSize,
      borderRadius: _borderRadius,
      overlayOpacity: _overlayOpacity,
      circularProgressColor: _circularProgressColor,
      overlayBackgroundColor: _overlayBackgroundColor,
      child: child,
    );
  }
}
