# Popcorn - Flutter Movie App

Popcorc is a Flutter application that allows users to browse movies, save favorites to a wishlist, and manage their own movie collection. The app demonstrates **Provider state management**, **REST API integration**, **authentication**, and **CRUD operations** while following a clean project structure.

---

# Features

## Authentication

* User Login
* Authentication using REST API
* Login Required widget for protected pages

---

## Home

* Fetch movies from REST API
* Display movie cards with posters
* View movie details
* Bottom Sheet preview
* Hero animation for smooth image transitions

---

## Wishlist

* Add movies to wishlist
* Remove movies from wishlist
* Real-time updates using Provider
* Empty state when no movies are saved

---

## My Movies

Users can manage their own movies through complete CRUD functionality.

Features include:

* Add Movie
* View Movie
* Update Movie
* Delete Movie

---

## Profile

* User Profile
* Personal Details
* Logout

---

# Technologies Used

* Flutter
* Dart
* Provider
* HTTP Package
* REST API

---

# Project Structure

```text
lib/
│
├── app/
│   └── movie_app.dart
│
├── model/
│   └── movie_model.dart
│
├── providers/
│   ├── auth_provider.dart
│   └── movie_provider.dart
│
├── screens/
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── wishlist_screen.dart
│   ├── my_movies_screen.dart
│   ├── add_movies_screen.dart
│   ├── profile_screen.dart
│   └── main_shell.dart
│
├── services/
│   ├── auth_service.dart
│   └── movie_service.dart
│
├── widgets/
│   ├── login_required.dart
│   ├── movie_card.dart
│   ├── movie_list_card.dart
│   └── movie_bottom_sheet.dart
│
└── main.dart
```

---

# API Integration

The application communicates with a REST API to perform CRUD operations.

Supported operations:

* GET Movies
* POST Movie
* PUT Movie
* DELETE Movie
* User Authentication

Each movie contains information such as:

* ID
* Title
* Year
* Genre
* Director
* Actors
* Description
* Poster Image
* IMDb Rating

---

# State Management

The application uses **Provider** for state management.

### AuthProvider

Responsible for:

* User Login
* Authentication State
* Logout

### MovieProvider

Responsible for:

* Fetching Movies
* Searching Movies
* Wishlist Management
* Loading State
* Add Movie
* Update Movie
* Delete Movie
* UI Refresh using `notifyListeners()`

---

# UI Components

Reusable widgets include:

* Movie Card
* Movie List Card
* Movie Bottom Sheet
* Login Required Widget

---

# Screens

* Login Screen
* Home Screen
* Wishlist Screen
* My Movies Screen
* Add Movie Screen
* Profile Screen

---

# License

This project is for educational and learning purposes.
