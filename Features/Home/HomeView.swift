//
//  Home.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 07/05/25.
//

import SwiftUI
import SwiftData
import MapKit
import UIKit

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = HomeViewModel()
    @State private var showHelp = false
    @State private var showSearchResults = false
    @State private var selectedCompletion: MKLocalSearchCompletion?
    @State private var showSearchResult = false
    @State private var selectedRoute: HomeRouteViewData?
    @State private var showRouteResult = false
    var shortcutDestination: String? = nil
    
    init(shortcutDestination: String? = nil) {
        self.shortcutDestination = shortcutDestination
        let primary = UIColor(named: "Primary") ?? UIColor.systemBlue
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: primary]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: primary]
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Where you want to go?", text: $viewModel.searchText)
                        .onChange(of: viewModel.searchText) { newValue in
                            viewModel.updateSearchResults()
                            showSearchResults = !newValue.isEmpty && !viewModel.searchResults.isEmpty
                        }
                        .textFieldStyle(PlainTextFieldStyle())
                    if !viewModel.searchText.isEmpty {
                        Button(action: { viewModel.searchText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Show search results if needed
                if showSearchResults && !viewModel.searchResults.isEmpty {
                    List(viewModel.searchResults, id: \.self) { result in
                        Button {
                            selectedCompletion = result
                            showSearchResult = true
                        } label: {
                            VStack(alignment: .leading) {
                                Text(result.title)
                                if !result.subtitle.isEmpty {
                                    Text(result.subtitle).font(.caption).foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                
                // Show selected location if available
                if let selected = viewModel.selectedLocation {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Selected location:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(selected.name ?? "Unnamed location")
                            .font(.headline)
                        if let address = selected.placemark.title {
                            Text(address)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                
                // After the search bar and before Spacer()
                if !viewModel.recentRoutes.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent Routes")
                            .font(.headline)
                            .padding(.horizontal)
                        ForEach(viewModel.recentRoutes) { route in
                            Button {
                                selectedRoute = route
                                showRouteResult = true
                            } label: {
                                HomeRouteCard(route: route)
                                    .padding(.horizontal)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.top, 8)
                }
                
                Spacer()
                
            }
            .navigationTitle("BLink!")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Help") {
                        showHelp = true
                    }
                }
            }
            .navigationDestination(isPresented: $showSearchResult) {
                if let completion = selectedCompletion {
                    SearchResultView(selectedCompletion: completion)
                }
            }
            .navigationDestination(isPresented: $showRouteResult) {
                if let selectedRoute = selectedRoute {
                    // Fetch the full RouteModel from SwiftData using the id
                    if let routeModel = RouteResultModel.fetchRoute(by: selectedRoute.id, modelContext: modelContext) {
                        RouteResultView(routeResult: RouteResultModel.from(route: routeModel))
                    } else {
                        Text("Route not found.")
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchRecentRoutes(modelContext: modelContext)
        }
    }
}

#Preview {
    let viewModel = HomeViewModel()
    // Map exampleRoutes to HomeRouteViewData
    viewModel.recentRoutes = exampleRoutes.map { HomeRouteViewData(route: $0) }
    return HomeView()
        .environmentObject(viewModel)
}
