//
//  RouteModel.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 09/05/25.
//

import Foundation
import SwiftData

// MARK: - Station Model
@Model
final class StationModel {
    var id: UUID
    var name: String
    var arrivalTime: Date?
    var isCurrentStation: Bool
    var isPreviousStation: Bool
    var isNextStation: Bool
    var latitude: Double?
    var longitude: Double?
    
    init(
        id: UUID = UUID(),
        name: String,
        arrivalTime: Date? = nil,
        isCurrentStation: Bool = false,
        isPreviousStation: Bool = false,
        isNextStation: Bool = false,
        latitude: Double? = nil,
        longitude: Double? = nil
    ) {
        self.id = id
        self.name = name
        self.arrivalTime = arrivalTime
        self.isCurrentStation = isCurrentStation
        self.isPreviousStation = isPreviousStation
        self.isNextStation = isNextStation
        self.latitude = latitude
        self.longitude = longitude
    }
}

// MARK: - Route Model
@Model
final class RouteModel {
    var id: UUID
    var routeCode: String
    var routeName: String
    var startPoint: String
    var endPoint: String
    var colorName: String
    var estimatedTime: Int
    var distance: Double
    var routeDescription: String?
    var stations: [StationModel]
    
    init(
        id: UUID = UUID(),
        routeCode: String,
        routeName: String,
        startPoint: String,
        endPoint: String,
        colorName: String,
        estimatedTime: Int,
        distance: Double,
        routeDescription: String? = nil,
        stations: [StationModel] = []
    ) {
        self.id = id
        self.routeCode = routeCode
        self.routeName = routeName
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.colorName = colorName
        self.estimatedTime = estimatedTime
        self.distance = distance
        self.routeDescription = routeDescription
        self.stations = stations
    }
}

let exampleRoutes: [RouteModel] = [
    RouteModel(
        routeCode: "GS",
        routeName: "Eka Hospital → Sinar Mas Land",
        startPoint: "Eka Hospital",
        endPoint: "Sinar Mas Land",
        colorName: "BadgeGS",
        estimatedTime: 30,
        distance: 5.2,
        routeDescription: "Eka Hospital to Sinar Mas Land",
        stations: []
    ),
    RouteModel(
        routeCode: "BC",
        routeName: "Greenwich Park → The Breeze",
        startPoint: "Greenwich Park",
        endPoint: "The Breeze",
        colorName: "BadgeBC",
        estimatedTime: 25,
        distance: 4.8,
        routeDescription: "Greenwich Park to The Breeze",
        stations: []
    ),
    RouteModel(
        routeCode: "ID1",
        routeName: "Intermoda → Green Office Park",
        startPoint: "Intermoda",
        endPoint: "Green Office Park",
        colorName: "BadgeID1",
        estimatedTime: 40,
        distance: 7.1,
        routeDescription: "Intermoda to Green Office Park",
        stations: []
    )
]
