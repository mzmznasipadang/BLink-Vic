//
//  RouteResultModel.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 16/05/25.
//

import Foundation
import SwiftUI
import MapKit
import SwiftData

struct RouteResultStop: Identifiable, Equatable {
    let id: UUID
    let name: String
    let time: String?
    let isCurrent: Bool
    let isNext: Bool
    let coordinate: CLLocationCoordinate2D?

    static func == (lhs: RouteResultStop, rhs: RouteResultStop) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.time == rhs.time &&
               lhs.isCurrent == rhs.isCurrent &&
               lhs.isNext == rhs.isNext &&
               lhs.coordinate?.latitude == rhs.coordinate?.latitude &&
               lhs.coordinate?.longitude == rhs.coordinate?.longitude
    }
}

struct RouteStop: Identifiable {
    let id = UUID()
    let name: String
    let time: String
    let isCurrent: Bool
    let isNext: Bool
    let coordinate: CLLocationCoordinate2D
}

struct RouteResultModel: Identifiable {
    let id: UUID
    let badgeText: String
    let badgeColorName: String
    let routeName: String
    let departureInfo: String
    let stops: [RouteResultStop]
    let startPoint: String
    let endPoint: String
    let estimatedTime: Int
    let distance: Double
    let routeDescription: String?

    // Convenience for SwiftUI Color
    var badgeColor: Color { Color(badgeColorName) }

    // Factory method to create from RouteModel
    static func from(route: RouteModel) -> RouteResultModel {
        let stops = route.stations.map { station in
            RouteResultStop(
                id: station.id,
                name: station.name,
                time: station.arrivalTime.map { Self.timeFormatter.string(from: $0) },
                isCurrent: station.isCurrentStation,
                isNext: station.isNextStation,
                coordinate: {
                    if let lat = station.latitude, let lon = station.longitude {
                        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    } else {
                        return nil
                    }
                }()
            )
        }
        let departureInfo = "Departs in \(route.estimatedTime) Minutes" // You can customize this
        return RouteResultModel(
            id: route.id,
            badgeText: route.routeCode,
            badgeColorName: route.colorName,
            routeName: route.routeName,
            departureInfo: departureInfo,
            stops: stops,
            startPoint: route.startPoint,
            endPoint: route.endPoint,
            estimatedTime: route.estimatedTime,
            distance: route.distance,
            routeDescription: route.routeDescription
        )
    }

    // Fetch a RouteModel from SwiftData by id
    static func fetchRoute(by id: UUID, modelContext: ModelContext) -> RouteModel? {
        let descriptor = FetchDescriptor<RouteModel>(predicate: #Predicate { $0.id == id })
        do {
            let routes = try modelContext.fetch(descriptor)
            return routes.first
        } catch {
            print("Failed to fetch route by id: \(error)")
            return nil
        }
    }

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}
