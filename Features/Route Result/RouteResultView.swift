//
//  RouteResultView.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 16/05/25.
//

import Foundation
import MapKit
import SwiftUI
import SwiftData

struct RouteResultView: View {
    let routeResult: RouteResultModel

    var body: some View {
        Group {
            ScrollView {
                VStack(spacing: 20) {
                    userLocationField
                    destinationField
                    routeSnippetCard
                    openInMapsButton
                }
                .padding()
            }
        }
        .navigationTitle("Result")
    }

    private var userLocationField: some View {
        HStack {
            Image(systemName: "location.fill").foregroundColor(.blue)
            Text("My Location")
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.12))
        .cornerRadius(12)
    }

    private var destinationField: some View {
        HStack {
            Image(systemName: "mappin").foregroundColor(.red)
            Text(routeResult.endPoint)
                .fontWeight(.bold)
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.12))
        .cornerRadius(12)
    }

    private var routeSnippetCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Text(routeResult.badgeText)
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(routeResult.badgeColor)
                    .clipShape(Capsule())
                Text(routeResult.routeName)
                    .font(.headline)
                Spacer()
            }
            Text(routeResult.departureInfo)
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Timeline of stops (snippet)
            VStack(alignment: .leading, spacing: 8) {
                ForEach(routeResult.stops.prefix(4)) { stop in
                    HStack {
                        VStack {
                            Circle()
                                .fill(stop.isCurrent ? Color.purple : Color.gray.opacity(0.3))
                                .frame(width: 12, height: 12)
                            if stop != routeResult.stops.prefix(4).last {
                                Rectangle()
                                    .fill(Color.purple)
                                    .frame(width: 2, height: 24)
                            }
                        }
                        .frame(width: 16)
                        VStack(alignment: .leading) {
                            Text(stop.name)
                                .fontWeight(stop.isCurrent ? .bold : .regular)
                            if stop.isCurrent {
                                Text("(Current Stop)")
                                    .font(.caption)
                                    .foregroundColor(.purple)
                            } else if stop.isNext {
                                Text("(Next Stop)")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                        Spacer()
                        if let time = stop.time {
                            Text(time)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            Button("Show full routes >") {
                // TODO: Show full route modal/sheet
            }
            .font(.caption)
            .foregroundColor(.blue)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 2)
    }

    private var openInMapsButton: some View {
        Button(action: openInMaps) {
            Text("Open in Maps")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("Utama"))
                .foregroundColor(.white)
                .cornerRadius(12)
        }
        .padding(.top, 8)
    }

    private func openInMaps() {
        guard let nearest = routeResult.stops.first(where: { $0.coordinate != nil }) else { return }
        if let coordinate = nearest.coordinate {
            let placemark = MKPlacemark(coordinate: coordinate)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = nearest.name
            mapItem.openInMaps(launchOptions: [:])
        }
    }
}

#Preview {
    let mock = RouteResultModel(
        id: UUID(),
        badgeText: "GS",
        badgeColorName: "BadgeGS",
        routeName: "Greenwich Park → Sektor 1.3",
        departureInfo: "Departs in 30 Minutes",
        stops: [
            RouteResultStop(id: UUID(), name: "CBD Selatan", time: "08:00", isCurrent: false, isNext: false, coordinate: nil),
            RouteResultStop(id: UUID(), name: "CBD Utara", time: "08:10", isCurrent: true, isNext: false, coordinate: nil),
            RouteResultStop(id: UUID(), name: "CBD Barat", time: "08:24", isCurrent: false, isNext: true, coordinate: nil),
            RouteResultStop(id: UUID(), name: "CBD Selatan", time: "08:30", isCurrent: false, isNext: false, coordinate: nil)
        ],
        startPoint: "My Location",
        endPoint: "Sinarmas Land Plaza",
        estimatedTime: 30,
        distance: 5.2,
        routeDescription: "Greenwich Park to Sinar Mas Land Plaza"
    )
    RouteResultView(routeResult: mock)
}
