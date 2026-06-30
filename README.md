# dashboardtaxi/Admin App

Flutter app for driver execution and admin operations in the Fat7i taxi platform.

## Admin Operations

- Trip operations and dispatch management.
- Customer records, customer incidents, and in-trip recordings.
- Compensation claim review.
- Refund lifecycle management through `/refunds`, backed by the backend refund APIs.

## Refund Management

The Refunds screen lists backend-tracked refunds, prioritizes failed/requires-action records, and shows admin-only Stripe identifiers and failure details on the detail screen. Retry actions are submitted only to the backend retry endpoint, where eligibility is revalidated before any Stripe call.

Refund operations are live-updated from SignalR. The admin app listens for `RefundLifecycleChanged` to refresh refund list/detail state and `RefundIssueCreated` to surface newly submitted customer review requests.

## Code Generation

- App strings: `dart run tool/generate_app_strings.dart`
- Injectable/freezed/assets: `dart run build_runner build --delete-conflicting-outputs`
