# Internship Task One – Flutter Chat & Social App

A Flutter application for learning purposes, featuring user authentication, profiles, connections, real-time chat, and push notifications. Built using Flutter, Firebase, GetX, and Pusher Beams.

---

## 📂 Project Structure

**lib/**  
**controller/** – GetX controllers for state management  
- `auth_controller.dart`  
- `chat_controller.dart`  
- `edit_profile_controller.dart`  
- `profile_controller.dart`  
- `request_controller.dart`  
- `user_search_controller.dart`  

**models/** – Data models  
- `chat_model.dart`  
- `message_model.dart`  
- `request_model.dart`  
- `user_model.dart`  

**notification/** – Push notification handling  
- `notifications.dart`  

**screens/** – UI screens  
- **authentication/** – Auth flow  
  - `forgot_password.dart`  
  - `login_screen.dart`  
  - `signup_screen.dart`  
- `chat_list_screen.dart`  
- `chat_screen.dart`  
- `connections_screen.dart`  
- `edit_profile_screen.dart`  
- `main_navigation_screen.dart`  
- `other_user_profile_screen.dart`  
- `pending_request_screen.dart`  
- `profile_screen.dart`  
- `request_main_screen.dart`  
- `search_users_screen.dart`  

**services/** – API and Firebase services  
- `auth_service.dart`  
- `notification_services.dart`  
- `request_service.dart`  
- `user_service.dart`  

**utils/** – Utility classes, constants, validators  
- `api_endpoints.dart`  
- `app_constants.dart`  
- `app_imports.dart`  
- `chat_binding.dart`  
- `chat_utils.dart`  
- `validators.dart`  

`firebase_options.dart` – Firebase configuration  
`main.dart` – Entry point

---

## 🚀 Features

- **User Authentication**  
  - Sign up, login, and forgot password  
  - Firebase Authentication integration  

- **Profile Management**  
  - View and edit your profile  
  - Other user profile viewing  

- **Connections / Requests**  
  - Send, accept, and view pending connection requests  
  - Display list of connections  

- **Real-time Chat**  
  - One-to-one chat using Firebase Firestore  
  - Messages are updated in real-time  
  - Push notifications for new messages  

- **Search Users**  
  - Search for users by name/email  
  - Send connection requests  

- **Notifications**  
  - Pusher Beams integration for push notifications  

---

## 🛠 Tech Stack

- Flutter – Frontend framework  
- Backend – Node.js  
- Database – MongoDB  
- Firebase – Firestore for chat  
- GetX – State management & routing  
- Pusher Beams – Push notifications  
- Dart – Programming language  

---

## ⚙ Installation & Setup

1. **Clone the repository**

```bash
git clone https://github.com/shamylkashif/internshiptaskone.git
cd internshiptaskone

```
2. **Install dependencies** 
```bash
flutter pub get
```
3.	**Firebase setup**
```bash
o	Add your google-services.json (Android) and GoogleService-Info.plist (iOS) in the respective folders.
o	Make sure firebase_options.dart is configured.
```
5.	**Run the app**
```bash
flutter run
```

--- 

## 🔗 Usage

- Launch the app.
- Sign up or login with an existing account.
- Browse users and send connection requests.
- Accept requests and start real-time chatting.
- Edit your profile or view other users’ profiles.
- Receive push notifications for new messages.

---

## ⚡ Notes & Tips

- Firestore queries may require composite indexes. If you get an error like “The query requires an index”, follow the Firebase console link.
- Push notifications require Pusher Beams instanceId configured in your app.
- If using an emulator, make sure Google Play Services is available for notifications.
- Avoid heavy work on the main thread to prevent frame skips (“Skipped frames” warnings).

---

## 📖 Future Improvements
- Group chats with multiple participants.
- Media messages (images, videos).
- Dark mode support.
- Advanced search filters.

---

## 📝 References
- [Flutter Documentation](https://docs.flutter.dev/)
- [GetX Documentation](https://chornthorn.github.io/getx-docs/)
- [Firebase Flutter Docs](https://docs.flutter.dev/data-and-backend/firebase)
- [Pusher Beams Docs](https://pusher.com/docs/beams/)

---

## 👨‍💻 Author
**Shamyl Kashif**
•	BSCS, Flutter Developer
•	[LinkedIn](https://www.linkedin.com/in/shamyl-kashif-923bb3259/) | [Email](mailto:shamylkashif@gmail.com) | [Website](https://shamylkashif.wixsite.com/shamyl-kashif-1)

---

## 📬 Contact
**If you'd like to learn more or collaborate on Flutter-based apps, feel free to reach out.**
