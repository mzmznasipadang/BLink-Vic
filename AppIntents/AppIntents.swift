//
//  OpenSearchResultIntent.swift
//  AppIntents
//
//  Created by Victor Chandra on 17/05/25.
//

import Foundation

import AppIntents

struct AppIntents: AppIntent {
    static var title: LocalizedStringResource = "Open Search Result"
    static var description = IntentDescription("Open the search result screen in BLink-Vic.")
    static var openAppWhenRun: Bool = true

    @Parameter(title: "Destination")
    var destination: String

    func perform() async throws -> some IntentResult {
        UserDefaults.standard.set(destination, forKey: "shortcutDestination")
        return .result()
    }
}
