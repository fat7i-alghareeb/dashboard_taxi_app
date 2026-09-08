class ApiEndpoints {
  ApiEndpoints._();

  // Auth (Constitution-compliant nouns)
  static const String login = '/api/v1/auth/sessions'; // legacy Firebase (deprecated)
  static const String adminLogin = '/api/v1/auth/admin-sessions';

  // Driver phone login via backend-owned OTP (CM.com SMS) — replaces Firebase phone auth.
  static const String phoneLoginOtp = '/api/v1/auth/phone/login/otp';
  static const String phoneLoginOtpVerify =
      '/api/v1/auth/phone/login/otp/verify';
  static const String forceResetPassword = '/api/v1/auth/me/password'; // PUT
  static const String refreshToken = '/api/v1/auth/tokens/refreshes';

  // Identity / admin management (moved to /admins)
  static const String registerAdmin = '/api/v1/admins';

  // Notifications (admin broadcast to an audience topic)
  static const String broadcastNotification =
      '/api/v1/notifications/broadcasts';

  // Users
  static const String currentUser = '/api/v1/users/me';
  static const String deleteAccount = '/api/v1/users/me'; // DELETE
  static const String updateFcmToken = '/api/v1/users/me/fcm-token';
  static const String updatePreferredLanguage = '/api/v1/users/me/language';
  static const String currentUserClaims = '/api/v1/users/me/claims';
  static const String currentAdminProfile = '/api/v1/admins/me';
  static const String changeAdminPassword = '/api/v1/admins/me/password'; // PUT
  static const String currentDriverProfile = '/api/v1/drivers/me';

  // Maps
  static const String mapsDirections = '/api/v1/maps/directions';

  // Trips
  static const String trips = '/api/v1/trips';
  static const String tripActive = '/api/v1/trips/active';
  // Admin-scoped collection view (sub-resource alias — documented exception).
  static const String adminTrips = '/api/v1/trips/admin';
  static String adminTripDetails(String tripId) =>
      '/api/v1/trips/$tripId/details';
  static String adminTripFinancials(String tripId) =>
      '/api/v1/trips/$tripId/financials';
  static String tripMessages(String tripId) => '/api/v1/trips/$tripId/messages';

  // In-trip safety recordings (admin).
  static const String adminRecordings = '/api/v1/trips/recordings';
  static String tripRecordings(String tripId) =>
      '/api/v1/trips/$tripId/recordings';

  // Admin dashboard
  static const String drivers = '/api/v1/drivers';
  static const String driversStatus = '/api/v1/drivers/status';
  static const String auditLogs = '/api/v1/audit-logs';
  static const String vehicleTypes = '/api/v1/vehicle-types';
  // Admin-scoped collection view (sub-resource alias — documented exception).
  static const String adminVehicleTypes = '/api/v1/vehicle-types/admin';
  static const String users = '/api/v1/users';
  static String userWallet(String userId) => '/api/v1/users/$userId/wallet';
  static const String tripDiscount = '/api/v1/app-config/trip-discount';
  static const String currency = '/api/v1/app-config/currency';
  static const String clientConfig = '/api/v1/app-config/client';
  static const String companyContact = '/api/v1/app-config/company-contact';
  static const String supportContact = '/api/v1/app-config/support-contact';
  static const String appVersionConfig = '/api/v1/app-config/app-version';

  static String driverDocuments(String driverId) =>
      '/api/v1/drivers/$driverId/documents';

  // POST (was PUT /review)
  static String reviewDriverDocument(String driverId, String documentId) =>
      '/api/v1/drivers/$driverId/documents/$documentId/reviews';

  static String approveDriver(String driverId) =>
      '/api/v1/drivers/$driverId/approvals';

  static String suspendDriver(String driverId) =>
      '/api/v1/drivers/$driverId/suspensions';

  static String assignDriverVehicleType(String driverId) =>
      '/api/v1/drivers/$driverId/vehicle-type';

  static String vehicleType(String vehicleTypeId) =>
      '/api/v1/vehicle-types/$vehicleTypeId';

  // Trip lifecycle (noun-modeled)
  static String cancelTrip(String tripId) =>
      '/api/v1/trips/$tripId/cancellations';
  static String assignTrip(String tripId) =>
      '/api/v1/trips/$tripId/assignments';
  static String adminTakeTrip(String tripId) =>
      '/api/v1/trips/$tripId/admin-takeovers';
  static String completeTripStop(String tripId, int sequence) =>
      '/api/v1/trips/$tripId/stops/$sequence/completions';
  static String driverCancelTrip(String tripId) =>
      '/api/v1/trips/$tripId/driver-cancellations';
  static String arriveResend(String tripId) =>
      '/api/v1/trips/$tripId/arrival-notifications';
  static const String compensationClaims = '/api/v1/trips/compensation-claims';
  static String reviewCompensationClaim(String claimId) =>
      '/api/v1/trips/compensation-claims/$claimId/reviews';

  // Customer incidents (admin)
  static const String customerIncidents = '/api/v1/customer-incidents';
  static String customerIncidentDetail(String id) =>
      '/api/v1/customer-incidents/$id';
  static String changeIncidentStatus(String id) =>
      '/api/v1/customer-incidents/$id/status';
  static String contactIncidentPassenger(String id) =>
      '/api/v1/customer-incidents/$id/messages';
  static String refundIncident(String id) =>
      '/api/v1/customer-incidents/$id/refunds';

  // Refund lifecycle (admin)
  static const String refunds = '/api/v1/refunds';
  static String refundDetail(String refundId) => '/api/v1/refunds/$refundId';
  static String refundCancellationDetail(String tripCancellationId) =>
      '/api/v1/refunds/cancellations/$tripCancellationId';
  static String retryRefund(String refundId) =>
      '/api/v1/refunds/$refundId/retry';
  static const String refundIssues = '/api/v1/refund-issues';
  static String reviewRefundIssue(String refundIssueId) =>
      '/api/v1/refund-issues/$refundIssueId/review';

  // Passenger moderation (admin)
  static String suspendUser(String userId) =>
      '/api/v1/users/$userId/suspensions';
}
