//
//  HomeViewModel.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 09/05/25.
//

import Foundation
import SwiftData
import MapKit

class HomeViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    // Search bar and location search
    @Published var searchText: String = ""
    @Published var searchResults: [MKLocalSearchCompletion] = []
    @Published var selectedLocation: MKMapItem? = nil

    private var completer: MKLocalSearchCompleter

    override init() {
        self.completer = MKLocalSearchCompleter()
        super.init()
        completer.resultTypes = .address
        completer.delegate = self
    }

    func updateSearchResults() {
        completer.queryFragment = searchText
    }

    func selectCompletion(_ completion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            if let item = response?.mapItems.first {
                DispatchQueue.main.async {
                    self.selectedLocation = item
                }
            }
        }
    }

    // Recent routes from SwiftData
    @Published var recentRoutes: [HomeRouteViewData] = []
    func fetchRecentRoutes(modelContext: ModelContext) {
        let descriptor = FetchDescriptor<RouteModel>()
        do {
            let routes: [RouteModel] = try modelContext.fetch(descriptor)
            self.recentRoutes = routes.map { HomeRouteViewData(route: $0) }
        } catch {
            print("Failed to fetch routes: \(error)")
        }
    }

    // MKLocalSearchCompleterDelegate
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.searchResults = completer.results
        }
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Search completer error: \(error)")
    }

    @Published var matchingRoutes: [RouteModel] = []

    func findMatchingRoutes(allRoutes: [RouteModel]) {
        guard let selectedLocation = selectedLocation else { return }
        let selectedCoordinate = selectedLocation.placemark.coordinate

        // For each route, check if any station is close to the selected location
        matchingRoutes = allRoutes.filter { route in
            route.stations.contains { station in
                // You need to store lat/lon in StationModel for this to work!
                guard let lat = station.latitude, let lon = station.longitude else { return false }
                let stationLocation = CLLocation(latitude: lat, longitude: lon)
                let selectedCLLocation = CLLocation(latitude: selectedCoordinate.latitude, longitude: selectedCoordinate.longitude)
                return stationLocation.distance(from: selectedCLLocation) < 500 // meters
            }
        }
    }
}
