//
//  RouteModelCardView.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 09/05/25.
//

import Foundation
import SwiftUI
import SwiftData

// MARK: - RouteModel Card View
struct RouteModelCardView: View {
    @Bindable var route: RouteModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Main title: start → end
            Text("\(route.startPoint) → \(route.endPoint)")
                .font(.title2.weight(.semibold))
                .foregroundColor(Color(route.colorName))

            // Badge and route name
            HStack(spacing: 8) {
                Text(route.routeCode)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(route.colorName))
                    .cornerRadius(12)

                Text(route.routeName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            // Stats row: duration and distance
            HStack(spacing: 32) {
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.subheadline)
                        .foregroundColor(Color(route.colorName))
                    Text("\(route.estimatedTime) Minutes")
                        .font(.subheadline)
                }
                HStack(spacing: 4) {
                    Image(systemName: "map")
                        .font(.subheadline)
                        .foregroundColor(.accentColor)
                    Text(String(format: "%.1f Km", route.distance))
                        .font(.subheadline)
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(24, corners: [.topLeft, .bottomRight])
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    let sample = RouteModel(
        routeCode: "BC",
        routeName: "Greenwich Park → The Breeze",
        startPoint: "Greenwich Park",
        endPoint: "The Breeze",
        colorName: "BadgePurple",
        estimatedTime: 65,
        distance: 6.9
    )
    RouteModelCardView(route: sample)
        .modelContainer(for: [RouteModel.self, StationModel.self])
}
