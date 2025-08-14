
A Flutter application for storing and managing your favorite places with custom details and images.

## Features
- **Custom Theming** – Consistent colors, typography, and styles applied across the app.
- **Multiple Screens & Navigation** – Smooth switching between different pages using a navigation setup.
- **Add New Places** – Users can add places with:
  - A title
  - An image (picked from gallery or taken with the camera)
- **Data Model** – `Place` model includes:
  - `id`
  - `title`
  - `image` (file)

## Tech Stack
- **Flutter**
- **Dart**
- **permission_handler** – For requesting camera and storage permissions.
- **image_picker** – For selecting images from the gallery or taking new pictures.