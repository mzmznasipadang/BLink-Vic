//
//  TabView.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 07/05/25.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
//            ScanView()
//                .tabItem {
//                    Image(systemName: "camera")
//                    Text("Scan")
//                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }.accentColor(Color("Utama"))
    }
}

#Preview {
    MainTabView()
}
