# API Response Caching

This project demonstrates a Flutter-based implementation of API response caching using `Dio` and `Isar` for efficient data retrieval and storage. The main focus is on caching API responses to improve performance and reduce redundant network calls.

### For better understand about the project, please refer to the following [Blog](https://medium.com/@jsmistry2000/boost-flutter-app-performance-with-api-response-caching-3368e0365df1)

## Overview

The project includes the following key components:

1. **API Caching**: Implemented using `DioCacheInterceptor` and `IsarCacheStore` for storing and retrieving cached API responses.
2. **API Integration**: The `InstaAPIRepository` and `InstaApiService` handle API requests and caching logic.
3. **UI Components**: A simple Flutter UI to display data fetched from the API, including a feed list and profile details.

## Key Files and Their Purpose

### 1. `lib/api_base/insta_api_repository.dart`
This file contains the main logic for API integration and caching. It uses `Dio` for making HTTP requests and `DioCacheInterceptor` with `IsarCacheStore` for caching.

- **Initialization**: The `initialise` method sets up the cache store and interceptors.
- **API Methods**:
    - `getAllPost`: Fetches all posts from the API with optional cache refresh.
    - `getProfile`: Fetches profile details for a specific user.

### 2. `lib/api_base/insta_api_service.dart`
This file defines the API endpoints and their implementation using `Retrofit`. It includes methods for:
- Fetching all posts (`/feed` endpoint).
- Fetching user profile details.

### 3. `lib/modules/feed_list.dart`
This file contains the UI for displaying a list of posts fetched from the API. It uses a `RefreshIndicator` to allow users to refresh the feed manually.

### 4. `lib/main.dart`
The entry point of the application. It initializes the repositories and sets up the basic app structure.

## How to Use

### Step 1: Setup
1. Clone the repository.
2. Run `flutter pub get` to install dependencies.

### Step 2: Initialize Repositories
In the `initState` method of your main widget, initialize the repositories:
```dart
APIRepository.instance.initialise();
InstaAPIRepository.instance.initialise();
```

### Step 3: Fetch Data
Use the methods in `InstaAPIRepository` to fetch data:
- `getAllPost`: Fetches all posts.
- `getProfile`: Fetches profile details for a specific username.

Example:
```dart
final posts = await InstaAPIRepository.instance.getAllPost();
final profile = await InstaAPIRepository.instance.getProfile(username: 'example_user');
```

### Step 4: Display Data
Use the fetched data to update your UI. For example, in `FeedList`, the posts are displayed in a `ListView`.

### Step 5: Caching
The caching is handled automatically by `DioCacheInterceptor` and `IsarCacheStore`. You can force a cache refresh by passing `refresh: true` to the API methods.

## Project Structure

- **`lib/api_base`**: Contains API-related logic, including repositories, services, and interceptors.
- **`lib/modules`**: Contains UI components like the feed list and post view.
- **`lib/models`**: Defines data models for posts and profiles.
- **`lib/values`**: Contains constants used across the project.

## Dependencies

- `dio`: For making HTTP requests.
- `dio_cache_interceptor`: For caching API responses.
- `http_cache_isar_store`: For storing cached responses in Isar.
- `retrofit`: For defining API endpoints.
- `path_provider`: For accessing the device's file system.

## Running the Project

1. Run the app using `flutter run`.
2. Navigate to the feed list or profile screen to see the API data and caching in action.

## Notes

- The API base URL is defined in `AppConstants`.
- Logs for API requests and responses are handled by `APILogger`.
- The project uses `Isar` for efficient local storage of cached data.

For further details, refer to the code in `lib/api_base/insta_api_repository.dart` and `lib/api_base/insta_api_service.dart`.

