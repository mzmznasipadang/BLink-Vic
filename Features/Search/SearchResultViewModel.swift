//
//  SearchResultViewModel.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 13/05/25.
//

import Foundation
import CoreLocation
import MapKit
import SwiftData
// If using modules, import the RouteModel module
// import Features_RouteCard_RouteModel

class SearchResultViewModel: NSObject, ObservableObject {
    // MARK: - Published Properties
    @Published var userLocation: CLLocation? = nil
    @Published var isEditingUserLocation: Bool = false
    @Published var userAddress: String = ""
    @Published var destination: MKMapItem? = nil
    @Published var allRoutes: [RouteModel] = []
    @Published var matchingRoutes: [RouteModel] = []
    @Published var searchText: String = ""
    @Published var searchResults: [MKLocalSearchCompletion] = []

    // For start location (user location, possibly overridden)
    @Published var startSearchText: String = "" {
        didSet { startCompleter.queryFragment = startSearchText }
    }
    @Published var startSearchResults: [MKLocalSearchCompletion] = []
    @Published var startLocation: MKMapItem? = nil // nil means "use device location"

    // For destination
    @Published var destinationSearchText: String = "" {
        didSet { destinationCompleter.queryFragment = destinationSearchText }
    }
    @Published var destinationSearchResults: [MKLocalSearchCompletion] = []

    private let locationManager = CLLocationManager()
    private let startCompleter = MKLocalSearchCompleter()
    private let destinationCompleter = MKLocalSearchCompleter()

    // MARK: - Init
    override init() {
        super.init()
        locationManager.delegate = self
        startCompleter.delegate = self
        destinationCompleter.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
    }

    // New initializer for selected completion
    init(selectedCompletion: MKLocalSearchCompletion) {
        super.init()
        locationManager.delegate = self
        startCompleter.delegate = self
        destinationCompleter.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        setDestinationFromCompletion(selectedCompletion)
    }

    // MARK: - Location Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DispatchQueue.main.async {
                self.userLocation = location
                self.reverseGeocode(location: location)
                self.filterMatchingRoutes()
            }
        }
    }

    func reverseGeocode(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                self.userAddress = [placemark.name, placemark.locality].compactMap { $0 }.joined(separator: ", ")
            }
        }
    }

    // MARK: - Fetch Routes
    func fetchRoutes(modelContext: ModelContext) {
        let descriptor = FetchDescriptor<RouteModel>()
        do {
            let routes: [RouteModel] = try modelContext.fetch(descriptor)
            DispatchQueue.main.async {
                self.allRoutes = routes
                self.filterMatchingRoutes()
            }
        } catch {
            print("Failed to fetch routes: \(error)")
        }
    }

    // MARK: - Set Destination
    func setDestination(_ mapItem: MKMapItem) {
        self.destination = mapItem
        filterMatchingRoutes()
    }

    // MARK: - Filtering Logic
    func filterMatchingRoutes() {
        let startCoord = startLocation?.placemark.coordinate ?? userLocation?.coordinate
        let endCoord = destination?.placemark.coordinate
        guard let startCoord = startCoord, let endCoord = endCoord else {
            matchingRoutes = []
            return
        }
        let startCL = CLLocation(latitude: startCoord.latitude, longitude: startCoord.longitude)
        let endCL = CLLocation(latitude: endCoord.latitude, longitude: endCoord.longitude)

        matchingRoutes = allRoutes.filter { route in
            let hasStart = route.stations.contains { station in
                guard let lat = station.latitude, let lon = station.longitude else { return false }
                return startCL.distance(from: CLLocation(latitude: lat, longitude: lon)) < 500
            }
            let hasEnd = route.stations.contains { station in
                guard let lat = station.latitude, let lon = station.longitude else { return false }
                return endCL.distance(from: CLLocation(latitude: lat, longitude: lon)) < 500
            }
            return hasStart && hasEnd
        }
        print("Start location: \(startCoord.latitude), \(startCoord.longitude)")
        print("Destination: \(endCoord.latitude), \(endCoord.longitude)")
        print("All routes count: \(allRoutes.count)")
        if let first = allRoutes.first {
            print("First route stations: \(first.stations.map { ($0.name, $0.latitude, $0.longitude) })")
        }
    }

    func setDestinationFromCompletion(_ completion: MKLocalSearchCompletion) {
        print("setDestinationFromCompletion called with:", completion.title, completion.subtitle)
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            print("Map items found:", response?.mapItems.count ?? 0, "error:", error?.localizedDescription ?? "none")
            if let item = response?.mapItems.first {
                DispatchQueue.main.async {
                    self.setDestination(item)
                }
            }
        }
    }

    /// Called by the view when the start/user location text changes
    func updateStartSearchResults() {
        startCompleter.queryFragment = startSearchText
        print("Start search query fragment:", startSearchText)
    }

    /// Called by the view when the destination text changes
    func updateDestinationSearchResults() {
        destinationCompleter.queryFragment = destinationSearchText
        print("Destination search query fragment:", destinationSearchText)
    }

    func setStartLocationFromCompletion(_ completion: MKLocalSearchCompletion) {
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let item = response?.mapItems.first {
                DispatchQueue.main.async {
                    self.startLocation = item
                    self.filterMatchingRoutes()
                }
            }
        }
    }
}

// MARK: - MKLocalSearchCompleterDelegate
extension SearchResultViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        if completer === startCompleter {
            DispatchQueue.main.async {
                self.startSearchResults = completer.results
            }
        } else if completer === destinationCompleter {
            DispatchQueue.main.async {
                self.destinationSearchResults = completer.results
            }
        }
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Search completer error: \(error)")
    }
}

// MARK: - CLLocationManagerDelegate
extension SearchResultViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error:", error.localizedDescription)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location authorized, requesting location")
            manager.requestLocation()
        default:
            print("Location authorization status changed to:", manager.authorizationStatus.rawValue)
        }
    }
}
