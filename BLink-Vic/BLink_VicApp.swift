//
//  BLink_VicApp.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 07/05/25.
//

import SwiftUI
import SwiftData
import AppIntents

@main
struct BLink_VicApp: App {
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "BG") ?? .white

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

    // Set up your model container for SwiftData
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([RouteModel.self, StationModel.self])
        let container = try! ModelContainer(for: schema)
        return container
    }()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .modelContainer(sharedModelContainer)
                .onAppear {
                    let context = sharedModelContainer.mainContext
                    Task {
                        let descriptor = FetchDescriptor<RouteModel>()
                        let count = (try? context.fetchCount(descriptor)) ?? 0
                        if count == 0 {
                            DataSeeder.seedInitialData(modelContext: context)
                        }
                    }
                }
        }
    }
}
