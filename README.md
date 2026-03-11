# Internship Task One – Flutter Chat & Social App
A Flutter application for learning purposes, featuring user authentication, profiles, connections, real-time chat, and push notifications. Built using Flutter, Firebase, GetX, and Pusher Beams.

**📂 Project Structure**
lib/
├─ controller/                # GetX controllers for state management
│  ├ auth_controller.dart
│  ├ chat_controller.dart
│  ├ edit_profile_controller.dart
│  ├ profile_controller.dart
│  ├ request_controller.dart
│  └ user_search_controller.dart
├─ models/                    # Data models
│  ├ chat_model.dart
│  ├ message_model.dart
│  ├ request_model.dart
│  └ user_model.dart
├─ notification/              # Push notification handling
│  └ notifications.dart
├─ screens/                   # UI screens
│  ├ authentication/          # Auth flow
│  │  ├ forgot_password.dart
│  │  ├ login_screen.dart
│  │  └ signup_screen.dart
│  ├ chat_list_screen.dart
│  ├ chat_screen.dart
│  ├ connections_screen.dart
│  ├ edit_profile_screen.dart
│  ├ main_navigation_screen.dart
│  ├ other_user_profile_screen.dart
│  ├ pending_request_screen.dart
│  ├ profile_screen.dart
│  ├ request_main_screen.dart
│  └ search_users_screen.dart
├─ services/                  # API and Firebase services
│  ├ auth_service.dart
│  ├ notification_services.dart
│  ├ request_service.dart
│  └ user_service.dart
├─ utils/                     # Utility classes, constants, validators
│  ├ api_endpoints.dart
│  ├ app_constants.dart
│  ├ app_imports.dart
│  ├ chat_binding.dart
│  ├ chat_utils.dart
│  └ validators.dart
├─ firebase_options.dart       # Firebase configuration
└─ main.dart                   # Entry point


**🚀 Features**
**User Authentication:** Sign up, login, and reset password using Firebase Auth.
**Profile Management:** Edit your profile; view other users’ profiles.
**Connections / Requests:** Send, accept, and view pending requests.
**Real-time Chat:** Chat one-to-one with Firestore real-time updates.
**Push Notifications:** Pusher Beams integration for new messages.
**Search Users:** Find users by name or email and send connection requests.
