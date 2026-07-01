# 🏗️ Features & State Architecture (`lib/features/`)

## 🛑 AI AGENT MANDATE (READ BEFORE PROCEEDING)

This document is a **Hard Requirement** for any AI agent interacting with feature logic, UI, or state management. You **MUST** ensure your internal state is synced with the following dependencies:

- **Global Rules**: [.ai/project-rules.md](.ai/project-rules.md)
- **Shared UI Blocks**: [lib/common/common_folder_guide.md](lib/common/common_folder_guide.md)
- **Data Standards**: [lib/core/core_architecture_overview.md](lib/core/core_architecture_overview.md)

Failure to follow the Hierarchical UI Decomposition (Screens -> Sections -> Widgets) or Clean Architecture Data Standards is a protocol violation.

---

This document defines the standardized architecture for all product features. Every new feature module must strictly adhere to this structure to ensure consistency, scalability, and predictable dependency flow across the Alsultan platform.

## 🔑 The Root Feature: Core Logic & Orchestration

The **Root** feature is the most critical module in the application, serving as the "App Shell" or primary orchestrator. Unlike standard domain features (like trading or inventory), the purpose of the Root is to provide a unified experience and bridge the gap between different product areas.

### Purpose & Responsibilities

- **Centralized Navigation**: It hosts the main navigation controllers and the `BottomNavBar`, managing the transitions and state persistence between the primary application tabs.
- **Global UI Shell**: It provides the persistent interface elements — such as the `AppScaffold`, `EndDrawer`, and specialized overlays — that must remain consistent regardless of which functional module is currently visible.
- **Dual-Role Mode Switching**: Users with both Admin and Driver roles land on the admin dashboard by default and can switch into the full driver workspace through the root mode switch overlay.
- **Forced Password Reset Lock**: Authenticated users with `requiresPasswordReset` are routed to the dedicated password reset screen until the backend clears the flag and the app refreshes the stored profile.
- **Self-Assignment Mode Handoff**: Admin users with linked driver profiles can self-assign compatible pending trips from the dashboard assignment sheet, then the shared root-mode service switches the shell into Driver Mode after assignment succeeds.
- **App-Level Side Effects**: It handles global state changes like theme switching (Light/Dark mode) and localization updates that affect the entire application context simultaneously.
- **Unified Entry Point**: After authentication, the Root feature is the landing zone that initializes the core application environment and establishes the navigation scope for all subsequent user interactions.

---

## 🚕 The Trip Feature: Driver Execution Lifecycle

The **Trip** feature owns the dashboard driver's active ride execution loop. It maps backend trip DTOs into clean domain entities, listens to SignalR trip lifecycle events, and exposes one isolated `BlocStatus<void>` per driver action.

### Current Responsibilities

- Fetch active trip details from `/api/v1/trips/{id}` and admin trip lists from `/api/v1/trips/admin`.
- Execute driver lifecycle commands: en route, arrived, start trip, and complete trip.
- React to `DriverAssigned`, `DriverEnRoute`, `DriverArrived`, `TripStarted`, `TripCompleted`, and `TripCancelled` realtime events.
- Render assignment, execution, navigation, loading, and completion summary widgets as separate presentation files.
- Integrate into `DriverHomeBody` so the map remains persistent while the lower panel switches between idle controls and active-trip execution.

---

## 📊 The Dashboard Feature: Admin Operations Overview

The **Dashboard** feature is the admin-facing operational surface for the taxi platform. It replaces the original placeholder body with a real overview backed by the production API.

### Current Responsibilities

- Fetch admin drivers from `/api/v1/drivers`, admin trips from `/api/v1/trips/admin`, audit logs from `/api/v1/audit-logs`, and the vehicle-type catalog from `/api/v1/vehicle-types`.
- Map API payloads into clean dashboard entities before presentation.
- Provide a dedicated trip management route that lists admin trips from `/api/v1/trips/admin` and loads full details from `/api/v1/trips/{id}/details`, including passenger, driver, vehicle type, fare, route labels, and lifecycle timestamps.
- Show trip totals, active/completed trip counts, online driver count, pending KYC count, and total driver count.
- Surface pending dispatch trips and assign an online approved driver through `/api/v1/trips/{id}/assign`.
- Surface fleet capability with vehicle-type capacity/pricing rows. The product model does not manage physical vehicles or cars; each driver carries one `vehicleTypeId`.
- Provide a full-screen live fleet map route backed by `/api/v1/drivers/status` for initial driver coordinates and `DriverLocationUpdated` realtime events for ongoing marker movement; the map also renders pending trip pickup pins from admin trip stop coordinates and opens the dispatch sheet from a selected pickup with nearest drivers ranked by haversine distance.
- Provide an Admin Operations route (Operations Center) and a Platform Settings route that combine driver management, vehicle-type management, user visibility, audit-log review, system configuration, and admin profile management.
- Built on a **Per-Section Architecture** where each segment (profile, config, drivers, vehicle types, users, audit) utilizes its own typed `StatusBuilder` and shape-matched shimmer. Loading, refresh, or mutation in one section does not block or reload the other sections.
- Use scoped loading states (`configActionState`, `driverActionState`, `vehicleTypeActionState`) for precise action feedback.

## 💳 The Refunds Feature: Admin Refund Operations

The **Refunds** feature is the admin-facing operational surface for the backend refund lifecycle introduced for cancellation, compensation, manual incident refund, and retry workflows.

### Current Responsibilities

- Fetch refund list data from `/api/v1/refunds` and refund detail data from `/api/v1/refunds/{refundId}`.
- Map backend admin refund DTOs into clean `RefundEntity` objects before presentation.
- Show failed and requires-action refunds prominently with status, amount, source type, trip/passenger references, payment method, and requested date.
- Provide local status/source/search filters for failed, pending, succeeded, requires-action, cancellation, manual incident, and compensation refund views.
- Show admin-only detail fields including Stripe refund ID, Stripe PaymentIntent ID, Stripe charge ID, failure code, failure reason, attempt count, related records, and lifecycle timestamps.
- Submit retry requests only through `POST /api/v1/refunds/{refundId}/retry`; the UI never decides eligibility and only enables retry when the backend DTO says `canRetry = true`.
- Keep all labels in `assets/l10n/*.json` and generated `AppStrings`.

## 🚘 The Driver Feature: Driver Profile & Earnings

The **Driver** feature owns driver-specific REST contracts that are shared by the driver home and dashboard driver mode.

### Current Responsibilities

- Update online/offline status through `/api/v1/drivers/me/status`.
- Update live fallback GPS coordinates through `/api/v1/drivers/me/location`.
- Fetch earnings from `/api/v1/drivers/me/earnings` and map totals plus per-trip earning rows into domain entities.
- Feed Driver Home idle metrics with real trip and earning totals while active trip execution remains owned by the Trip feature.

---

## 🏗️ State Management Standards (BLoC & Freezed)

We utilize **BLoC** with **Freezed** to ensure immutability and exhaustive pattern matching. Every feature must follow this exact state implementation pattern.

### Standard BLoC Structure (The Blueprint)

Every asynchronous operation in the BLoC must have its own dedicated `BlocStatus<T>` field in the state. This prevents UI cross-talk and allows multiple independent operations to occur simultaneously.

#### 1. The State (`feature_state.dart`)

```dart
@freezed
class FeatureState with _$FeatureState {
  const factory FeatureState({
    // One status per major async operation
    @Default(BlocStatus<List<Entity>>.initial())
    BlocStatus<List<Entity>> fetchState,

    @Default(BlocStatus<DetailEntity>.initial())
    BlocStatus<DetailEntity> detailsState,

    @Default(BlocStatus<void>.initial())
    BlocStatus<void> submissionState,
  }) = _FeatureState;
}
```

#### 2. The Event (`feature_event.dart`)

```dart
@freezed
class FeatureEvent with _$FeatureEvent {
  const factory FeatureEvent.started() = _Started;
  const factory FeatureEvent.fetchRequested() = _FetchRequested;
  const factory FeatureEvent.submitRequested(RequestModel request) = _SubmitRequested;
}
```

#### 3. The BLoC Logic (`feature_bloc.dart`)

```dart
@injectable
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  FeatureBloc(this._facade) : super(const FeatureState()) {
    on<_FetchRequested>(_onFetchRequested);
  }

  final FeatureFacade _facade;

  Future<void> _onFetchRequested(...) async {
    emit(state.copyWith(fetchState: const BlocStatus.loading()));
    final result = await _facade.fetchData();
    result.when(
      success: (data) => emit(state.copyWith(fetchState: BlocStatus.success(data))),
      failure: (message) => emit(state.copyWith(fetchState: BlocStatus.failure(message))),
    );
  }
}
```

---

## 🎨 UI Integration: `StatusBuilder<T>`

The UI must **NEVER** manually check status enums. Instead, use the **`StatusBuilder<T>`** widget to handle state transitions. This ensures a consistent "Loading" and "Error" experience across the entire app.

### Implementation Pattern

```dart
StatusBuilder<List<Entity>>(
  state: state.fetchState,
  onRefresh: () async => context.read<FeatureBloc>().add(const FeatureEvent.fetchRequested()),
  success: (data) => ListView.builder(
    itemCount: data.length,
    itemBuilder: (context, index) => EntityWidget(data[index]),
  ),
  // Optional overrides:
  // loading: () => CustomLoadingWidget(),
  // empty: () => CustomEmptyWidget(),
)
```

### Key Responsibilities of `StatusBuilder`

- **`initial`**: Displays nothing or a placeholder (configurable via `showInitWidget`).
- **`loading`**: Displays the standard `MainLoadingProgress` overlay.
- **`success`**: Provides the type-safe `data` to the success builder. Automatically handles "Empty State" if the data is a collection.
- **`failure`**: Displays a `FailedStateWidget` with localized error messages and a "Retry" button.

---

## 📂 Feature Directory Structure

Each feature is organized into three primary layers following Clean Architecture principles:

### 1. `constants/` (Static Domain)

- Contains `forms/`: Form definitions MUST use an `abstract class` with `static` constants for field names and a `static` method/variable for the `FormGroup`.

### 2. `data/` (Implementation)

- `datasources/`, `models/` (DTOs), `mappers/`, and `repositories/` (Concrete implementations).

### 3. `domain/` (Pure Logic)

- `entities/` (Business objects), `repositories/` (Interfaces), and `facade/` (Service layer).

### 4. `presentation/` (Visuals)

- `states/` (BLoCs using Freezed).
- `ui/`:
  - `screens/`: Top-level page entry points.
  - `widgets/`: Feature-specific UI components (atomic Widgets).

#### Screen Implementation Standards

Every newly created Screen MUST adhere to these scaffolding rules to ensure routing consistency and global UI integration:

- **Static Routing Identifiers**: Each screen MUST define `static const String pagePath` and `static const String pageName` to be used by the global `GoRouter` configuration.
- **Mandatory Scaffold**: All screens MUST be wrapped in the custom **`AppScaffold`** widget. This ensures the screen correctly inherits the app's global drawer, search behavior, and premium styling.

**Example Screen Boilerplate:**

```dart
class NewFeatureScreen extends StatelessWidget {
  const NewFeatureScreen({super.key});

  static const String pagePath = '/new_feature_screen';
  static const String pageName = 'NewFeatureScreen';

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: NewFeatureBody(),
    );
  }
}
```

#### Presentation Layer Construction Standards

To ensure maximum scalability and code clarity, all UI implementation must follow these structural rules:

- **Decomposed Sections**: Large screens must be divided into logical **Sections** (e.g., `HeaderSection`, `FormSection`, `ActionSection`).
- **Atomic Widgets**: Each section should be composed of multiple smaller, focused **Widgets**.
- **File Isolation**: Every single widget and section MUST be placed in its own **separate file**. In-line widget declarations within larger files are not permitted.
- **Component Reusability**: All standard UI building blocks (spacers, buttons, typography) must be sourced from the global `DesignSystem` and never duplicated locally.

### 🏛️ Hierarchical UI Decomposition (STRICT)

To ensure maximum scalability and avoid massive build methods, all UI MUST follow this 3-tier hierarchy:

1. **Screens**: Top-level entry points (in `ui/screens/`). Responsibilities:
   - Handle routing arguments.
   - Provide `BlocProvider` if needed.
   - Wrap the body in `AppScaffold`.
2. **Sections**: Logical blocks of the screen (in `ui/widgets/`). Responsibilities:
   - Orchestrate multiple atomic widgets.
   - Handle section-specific layout (e.g., a `Column` with specific spacing).
   - Example: `SellGoldTotalsSection`.
3. **Atomic Widgets**: The smallest reusable units (in `ui/widgets/`). Responsibilities:
   - Render a single specific piece of data or an interactive element.
   - Should be specialized for the feature but follow `DesignSystem` tokens.

**RULE**: Every section and non-trivial widget **MUST** reside in its own separate file. Inlining is a protocol violation.

### 🗺️ Typed Navigation Protocol

Typed data passing is mandatory to prevent runtime errors and "string-ly typed" navigation.

1. **Arguments Classes**: Every screen that receives data **MUST** have a corresponding `ScreenArguments` or `ScreenParam` class defined in the same file as the screen.
2. **GoRouter `extra`**: Use the `extra` parameter in `GoRouter` to pass the typed argument object.
3. **Explicit Casting**: The destination screen **MUST** cast the `extra` object back to the expected type.

### 🧪 Clean Architecture Data Standards

The separation between Domain and Data layers must be absolute.

1. **Entities (Domain)**: Pure business objects. No JSON annotations, no API-specific fields.
2. **Models/DTOs (Data)**: API-specific objects. Must include `fromJson` and `toJson`.
3. **Request Modeling**: Every API call **MUST** have a dedicated `RequestModel` (e.g., `UpdateProfileRequest`) instead of passing raw Maps or multiple primitives.
4. **Mappers**: You **MUST** implement mapper logic (often as `toEntity()` on the Model or a dedicated `Mapper` class) to convert between Data and Domain layers. Models must **NEVER** leak into the Domain or Presentation layers.

**Gold Standard Feature Pattern**

- `constants/forms/`: `abstract class` with static `FormGroup`.
- `data/models/`: `xxx_model.dart` with `toJson`.
- `domain/entities/`: `xxx_entity.dart` (clean).
- `domain/facade/`: Orchestrates repository calls into business results.
- `presentation/ui/screens/`: Scaffolding and routing.
- `presentation/ui/widgets/`: Separated sections and widgets.

### Admin Refund Requests Feature Note

`lib/features/refund_requests/` owns the admin-facing queue for customer refund review/support requests:

- It calls `GET /api/v1/refund-issues` with pagination and review-status filters.
- It calls `POST /api/v1/refund-issues/{id}/review` for admin review outcomes.
- It displays nullable payment/refund links safely because Stripe-disabled trips can still create customer refund requests without a `Payment` row.
- It does not execute refunds and does not call Stripe; actual refund execution remains in the backend refund lifecycle.

---

_For detailed technical deep-dives into specific infrastructure layers, visit the internal documentation in `lib/core/`._
