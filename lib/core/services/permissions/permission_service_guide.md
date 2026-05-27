# Permissions Service Guide

## Purpose

This folder centralizes app permissions needed by startup flow and location/map features.

- Location permission is mandatory for entering the app flow.
- Notification permission is optional and requested softly after splash.
- Startup order is: Splash -> Permission Gate -> Onboarding/Auth/Root.

## Files

- location_permission_service.dart
  - permission_handler wrapper for foreground/background location permission.
  - exposes status checks, request methods, and settings shortcut.

- permissions_coordinator.dart
  - orchestrates notification soft prompt and mandatory location gate checks.
  - exposes reusable check methods for feature services and UI.
  - extends ChangeNotifier so router refresh can react to permission updates.

## Usage Pattern

For startup gate:

1. Router redirects to permission gate when foreground location is not granted.
2. Permission gate screen calls ensurePostSplashPermissions().
3. If granted, router continues normal onboarding/auth flow.

For map/location features:

1. Call isForegroundLocationGranted() before location-dependent logic.
2. Call ensureBackgroundLocationWhenNeeded() only when a background tracking flow is activated.

## Notes

- Notification permission remains non-blocking.
- Location permission is required and can block the user until granted.
- Permanently denied location should lead to app settings and a blocking state message.
