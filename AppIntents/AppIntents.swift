//
//  OpenSearchResultIntent.swift
//  AppIntents
//
//  Created by Victor Chandra on 16/05/25.
//

import AppIntents

struct OpenSearchResultIntent: AppIntent {
    static var title: LocalizedStringResource = "Open Search Result"

    func perform() async throws -> IntentResult {
        // You can perform logic here (e.g., update UserDefaults to trigger view)
        UserDefaults.standard.set(true, forKey: "launchSearchFromShortcut")
        return .result()
    }
}
