//
//  Item.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 07/05/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
