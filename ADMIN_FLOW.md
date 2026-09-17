# Admin Flow — dashboardtaxi

## 1. Entry Point: Splash

```
App Launch
  → SplashScreen (/splash)
  → Waits for auth status + splash delay
  → Redirects based on AppRouteGuard
```

---

## 2. Login

**Screen:** `AdminLoginScreen` — `/admin_login`

- Form: `userName` + `password` (reactive_forms validation)
- Submit fires `AdminAuthBloc.AdminLoginRequested(userName, password)`
- Bloc calls `AuthFacade.adminLogin()` → `AuthRepository.adminLogin()` → backend `POST /auth/admin/login`
- On success: token stored in `JwtTokenStorage`, `AuthManager.setUser(user)`, `AuthStateNotifier` notified
- Router guard detects authenticated admin and redirects

**Force Password Reset check:**

```
requiresPasswordReset == true → ForcePasswordResetScreen (/force_password_reset)
requiresPasswordReset == false → continue
```

---

## 3. Permission Gate

**Screen:** `PermissionGateScreen` — `/permission_gate`

- Requests foreground location permission before entering the app
- On `granted` → navigates directly to `RootScreen`
- On `denied` → shows retry UI
- On `permanentlyDenied` → shows "Open Settings" UI
- Re-checks on app resume (`WidgetsBindingObserver`)

> Admins bypass the KYC screen entirely — router guard routes `isAdmin` straight past KYC.

---

## 4. Root Screen (Main Shell)

**Screen:** `RootScreen` — `/root_screen`

Provides:
- `RootBloc` — map bootstrap (last known → accurate GPS)
- `TripBloc` — active trip state

Renders `RootBody`: a 3-tab `PageView` + `Scaffold` with a **leading drawer**.

### Bottom Navigation Tabs

| Index | Tab | Widget |
|-------|-----|--------|
| 0 | Account | `RootProfileTabSection` |
| 1 | Home (default) | `RootHomeTabSection` |
| 2 | Trips | `RootTripTabSection` |

> Bottom nav is **hidden** when a trip sheet is active (sheetStage ≠ idle).

---

## 5. Home Tab (Map)

`RootHomeTabSection` — full-screen map

- `RootMapSection`: Google Map with cinematic camera animation on recenter
- `_HomeTopOverlay`: hamburger button (opens drawer) + `DriverHomeConnectionPillWidget`
- `_HomeBottomSheet`: `TripSheetSection` — idle content is `null` for admin (no online/offline toggle)

For admin, the home tab is a **live map view only** — no driver controls panel.

---

## 6. Account Tab (Admin Dashboard Overview)

`RootProfileTabSection` → detects `isAdmin` → creates `DashboardBloc.started()` → renders `DashboardBody`

- Calls `DashboardFacade.getOverview()` → backend `GET /dashboard/overview`
- Shows `DashboardOverviewSection` with KPIs (total trips, active drivers, revenue, etc.)
- Shimmer loading state, pull-to-refresh

---

## 7. Trips Tab

`RootTripTabSection`

- Fires `DashboardEvent.adminTripsRequested()`
- Renders `DashboardTripsBody` — filterable list of all system trips
- Each trip shows status, driver, passenger, fare
- Tap → `tripDetailsRequested(tripId)` for detail view

---

## 8. Drawer (Admin-Only Section)

Opens from hamburger button on the home tab.

### Common Items (driver + admin)
- Theme selector
- Language selector
- Logout (with confirmation dialog)

### Admin-Only Items
| Item | Destination |
|------|-------------|
| Dashboard | `DashboardScreen` — `/dashboard_screen` |
| Trips | `DashboardTripsScreen` — `/dashboard_trips` |
| Live Fleet | `DashboardLiveMapScreen` — `/dashboard_live_map` |
| Admin Operations | `DashboardAdminOperationsScreen` — `/dashboard_admin_operations` |
| System Settings | `AdminSettingsScreen` — `/admin_settings` |

---

## 9. Dashboard Screen

**Route:** `/dashboard_screen`

Same overview as the Account tab, but accessed as a standalone screen.

---

## 10. Admin Operations Screen

**Route:** `/dashboard_admin_operations`

Fires `DashboardBloc.adminOperationsRequested()` — fetches the full admin operations payload.

Renders 6 sections:

### 10.1 Admin Profile
- Displays logged-in admin's name, email, role

### 10.2 Config
- **Trip Discount %** → `tripDiscountUpdateRequested(percent)` → `PUT /app-config/trip-discount`
- **Currency Code** → `currencyUpdateRequested(code)` → `PUT /app-config/currency`

### 10.3 Drivers
- List of all registered drivers with approval status
- **Suspend / Unsuspend** → `driverSuspensionRequested(driverId)`
- **Assign Vehicle Type** → `driverVehicleTypeAssignmentRequested(driverId, vehicleTypeId)`
- **View Documents** → `driverDocumentsRequested(driverId)` → shows KYC docs
- **Approve / Reject Document** → `documentReviewRequested(driverId, documentId, approved, notes)`
- **Final Approve Driver** → `driverApprovalRequested(driverId)`

### 10.4 Vehicle Types
- List with enable/disable toggle → `vehicleTypeStatusToggleRequested(vehicleType)`
- Delete → `vehicleTypeRemovalRequested(vehicleTypeId)`

### 10.5 Users
- Read-only list of all registered users

### 10.6 Audit Logs
- Full system audit trail (actions, timestamps, actors)

---

## 11. System Settings Screen

**Route:** `/admin_settings`

Focused form using `DashboardBloc`:
- Trip discount input + Save → `tripDiscountUpdateRequested(percent)`
- Currency code input + Save → `currencyUpdateRequested(code)`
- Success/failure overlays on action completion

---

## 12. Live Fleet Screen

**Route:** `/dashboard_live_map`

- Full-screen Google Map (no SafeArea)
- `DashboardBloc.driverLocationsRequested()` fetches initial positions
- `RealtimeService` streams `DriverLocationUpdated` events → `DashboardBloc.driverLocationReceived(driverId, lat, lng)`
- Renders a marker per active driver, color-coded by status

---

## 13. Trips Screen

**Route:** `/dashboard_trips`

- `DashboardBloc.adminTripsRequested(status?)` with optional status filter
- Filterable list: All / Active / Completed / Cancelled
- `tripAssignmentRequested(tripId, driverId)` to manually assign unassigned trips to a driver

---

## 14. Logout

From drawer → confirmation dialog → `AuthFacade.logout()` → clears `JwtTokenStorage` + `AuthStateNotifier` sets unauthenticated → router redirects to `/admin_login`

---

## Full Flow Diagram

```
App Launch
  └─ SplashScreen
       └─ AdminLoginScreen  (/admin_login)
            └─ [credentials valid]
                 ├─ [requiresPasswordReset] → ForcePasswordResetScreen
                 └─ PermissionGateScreen (/permission_gate)
                      └─ [location granted]
                           └─ RootScreen (/root_screen)
                                ├─ TAB 0: Account
                                │    └─ DashboardBody (overview KPIs)
                                ├─ TAB 1: Home (default)
                                │    └─ Full-screen map  (no trip controls for admin)
                                ├─ TAB 2: Trips
                                │    └─ DashboardTripsBody (all trips list)
                                └─ DRAWER (admin section)
                                     ├─ Dashboard          → /dashboard_screen
                                     ├─ Trips              → /dashboard_trips
                                     ├─ Live Fleet         → /dashboard_live_map
                                     ├─ Admin Operations   → /dashboard_admin_operations
                                     │    ├─ Config (discount, currency)
                                     │    ├─ Drivers (KYC review, suspend, vehicle type)
                                     │    ├─ Vehicle Types (CRUD)
                                     │    ├─ Users
                                     │    └─ Audit Logs
                                     └─ System Settings    → /admin_settings
```

---

## Key Files Reference

| Concern | File |
|---------|------|
| Admin login UI | [lib/features/auth/presentation/ui/screens/admin_login_screen.dart](lib/features/auth/presentation/ui/screens/admin_login_screen.dart) |
| Admin login BLoC | [lib/features/auth/presentation/states/admin_auth_bloc.dart](lib/features/auth/presentation/states/admin_auth_bloc.dart) |
| Route guard | [lib/core/router/router_config.dart](lib/core/router/router_config.dart) |
| Root shell | [lib/features/root/presentation/ui/screens/root_screen.dart](lib/features/root/presentation/ui/screens/root_screen.dart) |
| Bottom nav + drawer | [lib/features/root/presentation/ui/widgets/root_body.dart](lib/features/root/presentation/ui/widgets/root_body.dart) |
| Drawer items | [lib/features/root/presentation/ui/widgets/root_drawer_content.dart](lib/features/root/presentation/ui/widgets/root_drawer_content.dart) |
| Dashboard overview | [lib/features/dashboard/presentation/ui/screens/dashboard_screen.dart](lib/features/dashboard/presentation/ui/screens/dashboard_screen.dart) |
| All admin operations | [lib/features/dashboard/presentation/states/dashboard_bloc.dart](lib/features/dashboard/presentation/states/dashboard_bloc.dart) |
| Admin settings | [lib/features/admin_settings/presentation/ui/screens/admin_settings_screen.dart](lib/features/admin_settings/presentation/ui/screens/admin_settings_screen.dart) |
| Live fleet map | [lib/features/dashboard/presentation/ui/screens/dashboard_live_map_screen.dart](lib/features/dashboard/presentation/ui/screens/dashboard_live_map_screen.dart) |
| Role extensions | [lib/core/domain/extensions/user_role_extensions.dart](lib/core/domain/extensions/user_role_extensions.dart) |
