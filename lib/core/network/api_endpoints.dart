class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/api/v1.0/auth/login';
  static const String adminLogin = '/api/v1.0/auth/admin/login';
  static const String forceResetPassword = '/api/v1/auth/force-reset-password';
  static const String refreshToken = '/api/v1/identity/tokens/refresh';

  // Identity / admin management
  static const String registerAdmin = '/api/v1/identity/admins';

  // Users
  static const String currentUser = '/api/v1/users/me';
  static const String updateFcmToken = '/api/v1/users/me/fcm-token';
  static const String updatePreferredLanguage = '/api/v1/users/me/language';
  static const String currentAdminProfile = '/api/v1/admins/me';
  static const String changeAdminPassword = '/api/v1/admins/change-password';
  static const String currentDriverProfile = '/api/v1/drivers/me';

  // Maps
  static const String mapsDirections = '/api/v1/maps/directions';

  // Trips
  static const String trips = '/api/v1/trips';
  static const String adminTrips = '/api/v1/trips/admin';
  static String adminTripDetails(String tripId) =>
      '/api/v1/trips/$tripId/details';

  // Admin dashboard
  static const String drivers = '/api/v1/drivers';
  static const String driversStatus = '/api/v1/drivers/status';
  static const String auditLogs = '/api/v1/audit-logs';
  static const String vehicleTypes = '/api/v1/vehicle-types';
  static const String adminVehicleTypes = '/api/v1/vehicle-types/admin';
  static const String users = '/api/v1/users';
  static const String tripDiscount = '/api/v1/app-config/trip-discount';
  static const String currency = '/api/v1/app-config/currency';
  static const String clientConfig = '/api/v1/app-config/client';

  static String driverDocuments(String driverId) =>
      '/api/v1/drivers/$driverId/documents';

  static String reviewDriverDocument(String driverId, String documentId) =>
      '/api/v1/drivers/$driverId/documents/$documentId/review';

  static String approveDriver(String driverId) =>
      '/api/v1/drivers/$driverId/approve';

  static String suspendDriver(String driverId) =>
      '/api/v1/drivers/$driverId/suspend';

  static String assignDriverVehicleType(String driverId) =>
      '/api/v1/drivers/$driverId/vehicle-type';

  static String vehicleType(String vehicleTypeId) =>
      '/api/v1/vehicle-types/$vehicleTypeId';

  static String cancelTrip(String tripId) =>
      '/api/v1/trips/$tripId/cancellations';
  static String assignTrip(String tripId) => '/api/v1/trips/$tripId/assign';
  static String adminTakeTrip(String tripId) =>
      '/api/v1/trips/$tripId/admin-take';
  static String completeTripStop(String tripId, int sequence) =>
      '/api/v1/trips/$tripId/stops/$sequence/complete';
  static String driverCancelTrip(String tripId) =>
      '/api/v1/trips/$tripId/driver-cancellations';
  static String arriveResend(String tripId) =>
      '/api/v1/trips/$tripId/arrive/resend';
  static const String compensationClaims = '/api/v1/trips/compensation-claims';
  static String reviewCompensationClaim(String claimId) =>
      '/api/v1/trips/compensation-claims/$claimId/review';
}
