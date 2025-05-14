//
//  HomeRouteViewData.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 11/05/25.
//

import Foundation

struct HomeRouteViewData: Identifiable {
    let id: UUID
    let routeCode: String
    let startPoint: String
    let endPoint: String
    let colorName: String

    init(route: RouteModel) {
        self.id = route.id
        self.routeCode = route.routeCode
        self.startPoint = route.startPoint
        self.endPoint = route.endPoint
        self.colorName = route.colorName
    }

    init(id: UUID, routeCode: String, startPoint: String, endPoint: String, colorName: String) {
        self.id = id
        self.routeCode = routeCode
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.colorName = colorName
    }
}
