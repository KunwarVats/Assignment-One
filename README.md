# Assignment-One

#  Assignment One — Event Discovery App (SwiftUI + SwiftData)

A SwiftUI-based event discovery app that demonstrates modern iOS architecture using **SwiftData, MVVM, caching, location services, and Apple Maps integration**.

---

## 🚀 Features

-  Fetch events from local JSON (mock API)
-  Persist events using **SwiftData**
-  MVVM architecture with clean separation of concerns
-  Image loading with in-memory caching (`NSCache`)
-  Live distance calculation from user location
-  Real-time location tracking using CoreLocation
-  Open Apple Maps for directions to event
-  Async/await networking
-  Fallback support for "Online" events

---

##  Architecture

The project follows **MVVM + Service Layer pattern**:

---

##  Location Features

- Uses `CLLocationManager` for real-time user location
- Calculates the distance between the user and the event
- Displays:
  - Distance in KM
  - "Online" for remote events
- Auto-updates when user location changes

---

##  Maps Integration

Each event includes a **Get Directions** button that:
- Opens Apple Maps
- Sets the destination to the event location
- Uses driving directions by default

---

##  Image Caching

- Images are downloaded asynchronously
- Cached in-memory using `NSCache`
- Prevents repeated network calls

---

##  Data Flow

1. App loads mock JSON
2. Decoded into `EventDTO`
3. Converted to SwiftData `Event`
4. Stored locally
5. UI reads from ViewModel
6. Location updates dynamically adjust distance

---

##  Key Components

###  HomeViewModel
Handles:
- Event loading (network + SwiftData fallback)
- Image loading with cache
- Distance calculation
- Maps navigation

---

###  NetworkService
- Reads local JSON file
- Decodes into `EventDTO`

---

###  LocationManager
- Requests permission
- Streams live user location updates

---

###  MapsService
- Opens Apple Maps with route from user → event

---

##  Permissions Required

Add to `Info.plist`:

# Architecture Diagram 

SwiftUI View (HomeFeed)
        |
        v
HomeViewModel (@Observable)
        |
        +----------------------+
        |          |          |
        v          v          v
    Network     Location     Maps
    Service     Service     Service
    (JSON)     (CoreLoc)   (Apple Maps)
        |
        v
EventDTO (API Layer)
        |
        v
EventRepository (SwiftData)
        |
        v
SwiftData Store (Persistence)

ImageCache (NSCache) used by ViewModel
