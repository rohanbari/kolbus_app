# KolBus App

A lightweight Flutter application for discovering bus routes between two locations using a local dataset. The app supports alias resolution, optional via points, and real-time stop suggestions.

---

## Features

* **Route Search**

  * Find routes between a source and destination
  * Optional **via** stop filtering
  * Direction-aware (correct stop order enforced)

* **Autocomplete**

  * Real-time suggestions while typing
  * Includes both stops and known aliases

* **Alias Handling**

  * Handles alternate names (e.g. *Bidhannagar Road → Ultadanga*)

* **Route Details**

  * Tap a route to view all stops in order

* **Offline First**

  * Uses a local JSON dataset (no API dependency)

---

## Project Structure (Simplified)

```
lib/
├── main.dart              # Entire app (UI + logic)
├── models/route_model.dart (optional split)
├── widgets/route_card.dart (optional split)
```

> Current implementation may be consolidated into a single file for simplicity.

---

## Data Source

* File: `assets/routes.json`
* Contains:

  * `routes`: List of bus routes with stops
  * `aliases`: Alternate names mapped to canonical stops

---

## How It Works

### 1. Data Loading

* JSON is loaded from assets at startup
* Converted into `RouteModel` objects

### 2. Stop Indexing

* All stops are extracted and deduplicated
* Aliases are merged for autocomplete

### 3. Normalization

User input is normalized by:

* Matching aliases
* Handling case differences
* Ignoring spacing inconsistencies (basic support)

### 4. Route Matching Logic

A route is valid if:

```
source index < destination index
AND
(if via exists → source < via < destination)
```

---

## Getting Started

### Prerequisites

* Flutter SDK (latest stable recommended)
* Dart enabled

---

### Installation

```bash
git clone <your-repo-url>
cd kolbus_app
flutter pub get
```

---

### Add Assets

Ensure `pubspec.yaml` includes:

```yaml
flutter:
  assets:
    - assets/routes_cleaned.json
```

---

### Run the App

```bash
flutter run -d chrome
```

---

## Example Usage

**Input:**

```
Source: Ultadanga
Destination: Sovabazar
```

**Output:**

* Matching routes displayed (based on dataset)
* Tap a route → view all stops

---

## Limitations

* No live GPS or real-time tracking
* No route ranking (all valid routes shown equally)
* No fuzzy matching beyond basic normalization
* Dataset-dependent accuracy

---

## Possible Improvements

* Fuzzy search (Levenshtein / phonetic matching)
* Route ranking (shortest / least stops)
* Multi-hop journey support
* UI enhancements (maps, highlighting segments)
* API integration for live data

---

## License

Not licensed yet.

---

## Author

<a href="mailto:therohanbari@gmail.com">Rohan Bari</a>, <a href="mailto:dipakbari4@gmail.com">Dipak Bari</a>
