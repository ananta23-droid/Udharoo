# 📒 Udhaaro — Offline-First Digital Ledger for Small Businesses

> **Udhaaro** is a Flutter mobile application designed to help small shop owners in Nepal digitise their traditional paper *khata* (credit ledger). Built with an offline-first architecture, it allows merchants to record credits and payments, manage customers, and optionally sync records to the cloud — even without a reliable internet connection.

---

## 📑 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
- [Project Structure](#-project-structure)
- [Prerequisites](#-prerequisites)
- [Installation & Setup](#-installation--setup)
- [Running the Application](#-running-the-application)
- [Building the Application](#-building-the-application)
- [Testing](#-testing)
- [Cloud Sync & Firebase](#-cloud-sync--firebase)
- [Database Schema](#-database-schema)
- [Dependencies](#-dependencies)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🔍 Overview

Udhaaro replaces paper credit books (locally called *khata*) used by thousands of small shops in Nepal. It is designed to work completely offline, keeping financial data locally in an SQLite database, while queuing any changes for optional later synchronisation to Firebase Firestore.

**Core problem it solves:** Small merchants lose track of credit given to customers, forget due dates, and struggle with manual reconciliation. Udhaaro provides a structured, auditable digital ledger that works without internet.

---

## ✨ Features

### 🏪 Shop & Onboarding
- First-run shop setup wizard (name, phone, address)
- Persistent session restoration via local SQLite

### 👥 Customer Management
- Add, edit, and view customers (name, phone, email)
- Search and filter customers by name or outstanding balance
- Customer detail view with full transaction history

### 💳 Credit & Payment Ledger
- Record credits (amounts given out) with optional notes, due dates, and payment methods
- Record payments (cash, FonePay, eSewa, bank transfer, etc.)
- Real-time running balance per customer and shop-wide totals
- Amounts stored as integer paisa (1/100 NPR) to eliminate floating-point rounding

### 👤 Staff Management
- Multi-staff support with role-based access (owner, manager, accountant, cashier, read-only)
- Staff attribution on every transaction
- Active/inactive staff toggling

### 🔔 Notifications
- Persistent in-app notification centre per shop
- Real-time unread badge count
- Granular per-staff notification preferences (notify on credit, payment, full clearance, own transactions)
- Push notification support via Firebase Cloud Messaging (FCM)

### 📋 Audit Logs
- Immutable, append-only audit trail for all shop operations
- Viewable from settings

### ☁️ Offline-First Cloud Sync
- All writes go to SQLite first (works fully offline)
- Pending operations queued and retried when connectivity returns
- Sync status indicator (synced / pending / syncing / offline / error)
- Cloud sync powered by Firebase Firestore (requires Firebase project configuration)

### ⚙️ Settings
- Configurable repayment reminder intervals
- Email and SMS reminder toggle (infrastructure present; provider configuration required)
- Notification preference management per staff member

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | Flutter (Dart SDK `^3.13.5`) |
| **State Management** | [Riverpod](https://riverpod.dev/) v3 (`flutter_riverpod ^3.4.3`) |
| **Navigation** | [GoRouter](https://pub.dev/packages/go_router) `^18.0.2` |
| **Local Database** | [Drift](https://drift.simonbinder.eu/) (SQLite ORM) `^2.35.2` |
| **SQLite Driver** | `sqlite3_flutter_libs ^0.6.0` |
| **Cloud Backend** | Firebase Firestore (Firestore Rules defined) |
| **Push Notifications** | Firebase Cloud Messaging (FCM) |
| **Cloud Functions** | Firebase Functions (Node.js) — `functions/index.js` |
| **Code Generation** | `build_runner`, `drift_dev` |
| **Utilities** | `uuid`, `intl`, `path_provider`, `path` |
| **Linting** | `flutter_lints ^6.0.0` |
| **Design System** | Material 3, custom `AppTheme`, `AppColors`, `AppTypography` |

---

## 🏗 Architecture

Udhaaro follows a **feature-first, layered architecture** within each feature module:

```
lib/
├── features/<feature>/
│   ├── data/          ← Repositories (Drift queries, sync logic)
│   ├── models/        ← Plain Dart model classes
│   └── presentation/  ← Screens & widgets (ConsumerWidget / ConsumerStatefulWidget)
├── core/
│   ├── constants/     ← AppColors, AppDimens, AppTypography
│   ├── providers/     ← Riverpod providers (app_providers.dart)
│   ├── theme/         ← AppTheme (Material 3)
│   ├── utils/         ← Input validators, helpers
│   └── widgets/       ← Shared widgets (UdhaaroButton, UdhaaroTextField, etc.)
├── data/local/        ← Drift database definition & generated code
├── routing/           ← GoRouter configuration (app_router.dart)
└── main.dart          ← App entry point (ProviderScope → MaterialApp.router)
```

**Data flow:**
1. UI widget reads from a Riverpod `StreamProvider` (live Drift stream)
2. User action → repository method → Drift write → SQLite
3. Write also queues a `PendingSyncOp` for cloud upload
4. `SyncService` drains the queue when connectivity allows, uploading to Firestore via `CloudSyncClient`

---

## 📁 Project Structure

```
Udhaaro/
├── android/                    # Android platform project
├── linux/                      # Linux platform project
├── lib/
│   ├── core/
│   │   ├── constants/          # AppColors, AppDimens, AppTypography
│   │   ├── providers/          # app_providers.dart (all Riverpod providers)
│   │   ├── theme/              # app_theme.dart (Material 3 theme)
│   │   ├── utils/              # Input validators
│   │   └── widgets/            # Shared UI components
│   ├── data/
│   │   └── local/              # app_database.dart + generated app_database.g.dart
│   ├── features/
│   │   ├── audit/              # Audit log feature (data, models, presentation)
│   │   ├── auth/               # Shop setup, onboarding, session (data, models, presentation)
│   │   ├── customers/          # Customer CRUD & search (data, models, presentation)
│   │   ├── dashboard/          # Dashboard screen with balance summary
│   │   ├── ledger/             # Add credit & record payment screens (data, models, presentation)
│   │   ├── navigation/         # MainScaffold (bottom nav shell)
│   │   ├── notifications/      # In-app notifications + FCM token manager (data, models, presentation)
│   │   ├── settings/           # Shop settings & reminder config (data, models, presentation)
│   │   ├── staff/              # Staff management (data, models, presentation)
│   │   └── sync/               # Offline sync queue & service (data, models)
│   ├── routing/
│   │   └── app_router.dart     # GoRouter with StatefulShellRoute (bottom nav)
│   └── main.dart               # ProviderScope + MaterialApp.router
├── functions/
│   └── index.js                # Firebase Cloud Function: onTransactionCreated
├── test/
│   ├── unit/
│   │   ├── database_persistence_test.dart
│   │   └── financial_logic_test.dart
│   ├── staff_and_settings_test.dart
│   └── widget_test.dart
├── firestore.rules             # Firestore security rules
├── pubspec.yaml
└── analysis_options.yaml
```

---

## 📋 Prerequisites

Before getting started, ensure you have the following installed:

| Tool | Version / Notes |
|---|---|
| [Flutter SDK](https://docs.flutter.dev/get-started/install) | Compatible with Dart SDK `^3.13.5` |
| [Dart SDK](https://dart.dev/get-dart) | Bundled with Flutter |
| [Android Studio](https://developer.android.com/studio) / [VS Code](https://code.visualstudio.com/) | With Flutter & Dart plugins |
| Android SDK | For Android builds (API 21+) |
| [Node.js](https://nodejs.org/) | Required only for Firebase Cloud Functions deployment |
| [Firebase CLI](https://firebase.google.com/docs/cli) | Required only for Firestore rules & Functions deployment |

---

## 🚀 Installation & Setup

### 1. Clone the repository

```bash
git clone <your-repository-url>
cd Udhaaro
```

### 2. Install Flutter dependencies

```bash
flutter pub get
```

### 3. Generate Drift database code

The local SQLite database uses Drift with code generation. Run the following after cloning or whenever `app_database.dart` is modified:

```bash
dart run build_runner build --delete-conflicting-outputs
```

> The generated file `lib/data/local/app_database.g.dart` is already committed to the repository, so this step is only required after schema changes.

### 4. Firebase Setup (Optional — required for cloud sync and push notifications)

The app runs fully offline without Firebase. To enable cloud sync and FCM push notifications:

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Add an Android app and download `google-services.json` → place it in `android/app/`
3. Enable **Firestore** and **Cloud Messaging** in the Firebase console
4. Deploy Firestore security rules:
   ```bash
   firebase deploy --only firestore:rules
   ```
5. Deploy the Cloud Function:
   ```bash
   cd functions
   npm install
   cd ..
   firebase deploy --only functions
   ```

> **Note:** The app uses an `OfflineFirstCloudClient` by default. Without Firebase credentials, all data is stored locally only, and sync remains in `pending` state without errors.

> ⚠️ Never commit `google-services.json` or any Firebase credentials to a public repository.

---

## ▶️ Running the Application

```bash
# Verify connected devices
flutter devices

# Run in debug mode (Android or Linux)
flutter run

# Run on a specific device
flutter run -d <device-id>

# Run with verbose output
flutter run -v
```

The app launches with a **splash screen** that checks for an existing shop profile in the local database. First-time users are directed to the **Shop Setup (Onboarding)** screen.

---

## 📦 Building the Application

### Android

```bash
# Debug APK
flutter build apk --debug

# Release APK (requires signing configuration)
flutter build apk --release

# Release App Bundle (recommended for Play Store)
flutter build appbundle --release
```

> Release builds require a signing keystore. See the [Flutter Android deployment guide](https://docs.flutter.dev/deployment/android) for keystore setup. Never commit keystore files or passwords to the repository.

### Linux

```bash
flutter build linux --release
```

> iOS and macOS builds are not verified in this repository (no `ios/` directory present).

---

## 🧪 Testing

The project includes unit, integration, and widget tests.

### Run all tests

```bash
flutter test
```

### Run specific test files

```bash
# Financial logic tests
flutter test test/unit/financial_logic_test.dart

# Database persistence tests
flutter test test/unit/database_persistence_test.dart

# Staff & settings tests
flutter test test/staff_and_settings_test.dart

# Widget tests
flutter test test/widget_test.dart
```

> Unit and database tests use an in-memory Drift database (`AppDatabase.memory()`) for fast, isolated testing without any file system or Firebase dependency.

### Linting & Static Analysis

```bash
flutter analyze
```

---

## ☁️ Cloud Sync & Firebase

The sync architecture is designed so the app functions completely without internet:

| State | Description |
|---|---|
| `synced` | All local writes successfully uploaded to Firestore |
| `pending` | Writes are queued locally, awaiting connectivity |
| `syncing` | Active upload in progress |
| `offline` | Cloud client not configured or unreachable |
| `error` | Upload failed; error message stored with retry count |

**Firebase Cloud Function (`functions/index.js`):**

Triggered on every new Firestore transaction document (`shops/{shopId}/transactions/{transactionId}`). It:
- Fetches customer details and calculates new debt balance
- Creates a persistent notification record in Firestore
- Dispatches FCM multicast push to all eligible device tokens
- Respects per-staff notification preferences
- Cleans up expired/stale FCM tokens automatically
- Implements idempotency to prevent duplicate notification dispatch on Function retries

**Firestore Security Rules (`firestore.rules`):**

- Shop data is readable/writable only by the `ownerUid`
- Customers and transactions are scoped strictly to shop staff
- The transaction ledger is **append-only** (update and delete are denied) to ensure financial auditability
- Notifications allow updating only `isRead` and `readAt` fields

---

## 🗄 Database Schema

The local SQLite database (Drift, schema version 3) contains the following tables:

| Table | Purpose |
|---|---|
| `shops` | Shop profile (name, phone, address, ownerUid) |
| `customers` | Customer records scoped to a shop |
| `transactions` | Financial ledger entries (credit / payment, amount in paisa) |
| `staff` | Staff members with roles and active status |
| `shop_settings` | Reminder intervals, email/SMS toggle configuration |
| `audit_logs` | Immutable audit trail for all shop operations |
| `reminder_logs` | Log of email/SMS reminders sent to customers |
| `pending_sync_operations` | Outbound sync queue with retry tracking |
| `notifications` | Persistent in-app notification records |
| `device_tokens` | FCM device tokens per staff per platform |
| `notification_preferences` | Per-staff push notification preference flags |

> Amounts are stored as **integer paisa** (1 NPR = 100 paisa) throughout the schema to avoid floating-point precision issues.

---

## 📚 Dependencies

### Runtime

| Package | Purpose |
|---|---|
| `flutter_riverpod ^3.4.3` | Reactive state management (StreamProvider, NotifierProvider) |
| `go_router ^18.0.2` | Declarative routing with StatefulShellRoute (bottom nav) |
| `drift ^2.35.2` | Type-safe SQLite ORM with reactive streams |
| `sqlite3_flutter_libs ^0.6.0` | Native SQLite binaries for Android/Linux |
| `path_provider ^2.1.6` | Locating the app documents directory for the database file |
| `path ^1.9.1` | Path joining utilities |
| `intl ^0.20.3` | Date/number formatting and localisation |
| `uuid ^4.6.0` | UUID v4 generation for entity IDs |
| `cupertino_icons ^1.0.8` | iOS-style icon set |

### Development

| Package | Purpose |
|---|---|
| `drift_dev ^2.35.1` | Code generation for Drift database classes |
| `build_runner ^2.16.2` | Dart build system for code generation |
| `flutter_lints ^6.0.0` | Recommended Flutter lint rules |

---

## 🖼 Screenshots

No screenshots are currently included in this repository. To add them:

1. Place screenshot images in an `assets/screenshots/` directory
2. Reference them in this README using relative paths:

```markdown
<p align="center">
  <img src="assets/screenshots/dashboard.png" width="270" alt="Dashboard" />
  <img src="assets/screenshots/customer_detail.png" width="270" alt="Customer Detail" />
  <img src="assets/screenshots/add_credit.png" width="270" alt="Add Credit" />
</p>
```

---

## 🤝 Contributing

Contributions are welcome. To contribute:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Make your changes and add tests where appropriate
4. Run `flutter analyze` and `flutter test` to verify no regressions
5. Commit with a clear message: `git commit -m "feat: describe your change"`
6. Push and open a Pull Request against `main`

**Before submitting:**
- Run `dart run build_runner build --delete-conflicting-outputs` if you modified any Drift table definitions
- Do not commit generated files (`*.g.dart`) if they are already tracked by git and unchanged
- Never commit Firebase credentials, keystore files, or API keys

---

## 📄 License

No license file is currently present in this repository. All rights reserved by the project author until a license is added.

---

## 🔗 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Documentation](https://riverpod.dev/docs/introduction/getting_started)
- [Drift (SQLite ORM) Documentation](https://drift.simonbinder.eu/)
- [GoRouter Documentation](https://pub.dev/documentation/go_router/latest/)
- [Firebase Flutter Setup](https://firebase.google.com/docs/flutter/setup)
- [Firebase Cloud Functions](https://firebase.google.com/docs/functions)