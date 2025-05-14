//
//  Home.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 07/05/25.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var showHelp = false
    
    init() {
            let primary = UIColor(named: "Primary") ?? UIColor.systemBlue
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: primary]
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: primary]
        }

    var body: some View {
        NavigationStack {
            List {
                // Example list content
                Section(header: Text("Recent Routes")) {
                    Text("Eka Hospital → Sinar Mas Land")
                    Text("Greenwich Park → The Breeze")
                }
            }
            .navigationTitle("BLink!")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Where you want to go?")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Help") {
                        showHelp = true
                    }
                }
            }
            .sheet(isPresented: $showHelp) {
                OnboardingView()
            }
        }
    }
}

#Preview {
    HomeView()
}
