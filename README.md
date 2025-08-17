Favorite Places App-
A Flutter application designed to allow users to save and manage a list of their favorite places. Each place is saved with a user-provided title, a custom image, and a precise geographical location. The app features on-device data storage, ensuring all places are saved even after the app is closed.


Features-
Add New Places: Users can add new favorite places by providing a title, an image, and a location.

Image Picking: Choose an image for a place by either taking a new photo with the device's camera or selecting an existing one from the gallery.

Location Selection:

Current Location: Instantly fetch the user's current GPS location.

Select on Map: Manually pick a precise location by dropping a pin on an interactive Google Map.
Address Lookup: Automatically converts geographical coordinates (latitude & longitude) into a human-readable street address using the Google Geocoding API.

Location Preview: Displays a static Google Map image as a preview for the selected location.

Persistent Storage: All favorite places are saved to a local SQLite database on the device, ensuring data is never lost.

View Place Details: Tap on a place in the list to see a detailed view, including the image and the location on an interactive map.
Technologies & Packages Used

State Management: flutter_riverpod for robust and scalable state management, making it easy to manage the list of places across different screens and widgets.

Database: sqflite for powerful and efficient on-device SQL database storage.

Path Handling: path_provider and path to reliably find the correct local path to store the database file on both Android and iOS.

Mapping & Location:
google_maps_flutter for displaying interactive maps.
location for fetching the device's current GPS coordinates.


Image Handling: image_picker to provide a seamless interface for accessing the camera and image gallery.

HTTP Requests: http package to communicate with the Google Geocoding API.

Theming: google_fonts for beautiful and consistent typography.

Unique IDs: uuid to generate unique identifiers for each saved place.

Development Process Walkthrough -

1. Project Foundation & Theming
The first step was to establish the visual identity by setting up a custom theme using the google_fonts package to ensure a consistent and modern UI.
2. Core Structure: Models and Screens
The application's architecture was designed with a clear separation of data and UI:
Model: A Place model was created in models/place.dart to define the structure for a place (id, title, image, location).
Screens: Three main screens were created:
PlacesListScreen: The main screen, displaying the list of saved places.
AddPlaceScreen: A screen with a form to add a new place.
PlaceDetailScreen: A screen to display the details of a selected place.
3. State Management with Riverpod
To manage the application's state, particularly the list of favorite places, flutter_riverpod was integrated. A UserPlacesNotifier was created to handle the logic for loading, adding, and managing the list of places, making the state available to any widget that needs it.
4. Implementing the "Add Place" Feature
This was the most complex feature and was broken down into two main parts:
Image Input: Using the image_picker package, functionality was added to allow the user to set an image for their place. The implementation provides two options: "Take Picture" to open the camera and "Choose from Gallery" to open the device's photo library.
Location Input:
The location package was used to implement the "Get Current Location" feature, which fetches the device's GPS coordinates.
The google_maps_flutter package was used to create an interactive map screen. This allows the user to either view a location or manually select one by tapping on the map.
Once coordinates were obtained (either from the GPS or the map), the http package was used to make a call to the Google Geocoding API. This API call converts the latitude and longitude into a formatted street address, which is then saved with the place.
5. Data Persistence with SQFLite
To ensure that the user's list of places is saved permanently, sqflite was integrated.
A database helper was created to handle all database operations (initializing the DB, creating tables, inserting new places, and fetching all places).
The path_provider and path packages were used to construct a reliable path to the database file on the user's device.
The Riverpod notifier was updated to load places from the database when the app starts and to insert new places into the database when they are added by the user.


Setup & Installation
To run this project locally, follow these steps:
1. Prerequisites
You must have the Flutter SDK installed on your machine.
You must have a configured Android or iOS emulator, or a physical device connected.
2. Clone the Repository
code
Bash
git clone <your-repository-url>
cd <project-directory>
3. Get Dependencies
code
Bash
flutter pub get
4. Configure Google Maps API Key
This project requires a Google Maps API key to function.
Get an API Key: Follow the instructions on the Google Cloud Console to create a project and get an API key.
Enable APIs: In the Google Cloud Console for your project, make sure you have enabled the following APIs:
Maps SDK for Android (or iOS)
Geocoding API
Create .env file: In the root directory of the project, create a file named .env.
Add Your Key: Add your API key to the .env file like this:
code
Code
MAPS_API_KEY=YOUR_ACTUAL_API_KEY_HERE
Configure Android:
Open android/app/build.gradle.kts and ensure the script to read the .env file is present.
Open android/app/src/main/AndroidManifest.xml and ensure the <meta-data> tag for the API key is using the placeholder "${MAPS_API_KEY}".
5. Run the App
You can run the app using the configured launch.json in VS Code (by pressing F5) or by running the following command in your terminal:
code
Bash
flutter run --dart-define-from-file=.env```
