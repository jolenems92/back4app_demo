# back4app_demo

# 📚 Flutter Book Manager App with Back4App

This Flutter application demonstrates how to integrate **Parse Server** via **Back4App** to handle **user authentication** and **CRUD operations** for storing student records (name and age).  

---

## 🚀 Features

- ✅ User Signup & Login (using Back4App Parse SDK)
- ✅ Add, Edit, Delete, and Fetch Student Records
- ✅ Form Validation for Age (only numeric input allowed)
- ✅ Logout and Session Management
- ✅ Fully functional UI with Material Design

---

## 🛠 Tech Stack

| Layer       | Technology             |
|-------------|------------------------|
| Frontend    | Flutter                |
| Backend     | Back4App (Parse Server)|
| SDK         | Parse SDK for Flutter  |

---

## 🔐 User Authentication

- Users can **Sign Up** and **Log In** using username and password.
- Sessions are automatically managed via `ParseUser`.
- Logout ends the current user session.

---

## 🗃 CRUD Functionality (Student Records)

Each record consists of:
- `Name`: String
- `Age`: Number

The user can:
- ➕ Add a new student
- ✏️ Edit an existing student
- ❌ Delete a student
- 📄 View all student

---

## 📦 Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/flutter-book-manager.git
cd flutter-book-manager
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configure Back4App Credentials
Replace the credentials in main.dart:
```
const keyApplicationId = 'YOUR_APP_ID_HERE';
const keyClientKey = 'YOUR_CLIENT_KEY_HERE';
```
You can find these in your Back4App dashboard under App Settings > Security & Keys

### 4. Run the App
```
flutter run
```
