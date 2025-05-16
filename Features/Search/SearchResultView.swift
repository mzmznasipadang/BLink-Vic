//
//  SearchResultView.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 13/05/25.
//

import SwiftUI
import MapKit
import SwiftData

struct DummyRoute: Identifiable, Hashable {
    let id = UUID()
    let badgeText: String
    let badgeColor: Color
    let routeName: String
    let routeDescription: String
    let timeHighlight: String
    let timeHighlightColor: Color
}

struct DummySearchResult: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
}

struct SearchResultView: View {
    let selectedCompletion: MKLocalSearchCompletion
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: SearchResultViewModel
    @State private var showSearchResults = false
    @State private var isEditingUserLocation = false
    @State private var isEditingDestination = false

    init(selectedCompletion: MKLocalSearchCompletion) {
        self.selectedCompletion = selectedCompletion
        _viewModel = StateObject(wrappedValue:  SearchResultViewModel(selectedCompletion: selectedCompletion))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                userLocationField
                destinationField
                searchResultsDropdown
                matchingRoutesSection
                Spacer(minLength: 0)
            }
            .padding()
            .onAppear {
                viewModel.fetchRoutes(modelContext: modelContext)
            }
        }

    }

    private var userLocationField: some View {
        HStack {
            Image(systemName: "location.fill")
                .foregroundColor(.blue)
            if isEditingUserLocation {
                TextField("Enter your location", text: $viewModel.startSearchText)
                    .onSubmit {
                        isEditingUserLocation = false
                        viewModel.isEditingUserLocation = false
                    }
                    .onChange(of: viewModel.startSearchText) {
                        viewModel.updateStartSearchResults()
                        showSearchResults = !viewModel.startSearchText.isEmpty && !viewModel.startSearchResults.isEmpty
                    }
            } else {
                Text(viewModel.startSearchText.isEmpty ? viewModel.userAddress : viewModel.startSearchText)
                    .foregroundColor(.primary)
                    .onTapGesture {
                        isEditingUserLocation = true
                        viewModel.isEditingUserLocation = true
                    }
            }
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.12))
        .cornerRadius(12)
    }

    private var destinationField: some View {
        HStack {
            Image(systemName: "mappin")
                .foregroundColor(.red)
            if isEditingDestination {
                TextField("Destination", text: $viewModel.destinationSearchText)
                    .onSubmit {
                        isEditingDestination = false
                    }
                    .onChange(of: viewModel.destinationSearchText) {
                        viewModel.updateDestinationSearchResults()
                        showSearchResults = !viewModel.destinationSearchText.isEmpty && !viewModel.destinationSearchResults.isEmpty
                    }
            } else if let destinationName = viewModel.destination?.name {
                Text(destinationName)
                    .foregroundColor(.primary)
                    .onTapGesture {
                        isEditingDestination = true
                    }
            } else {
                TextField("Destination", text: $viewModel.destinationSearchText)
                    .onChange(of: viewModel.destinationSearchText) {
                        viewModel.updateDestinationSearchResults()
                        showSearchResults = !viewModel.destinationSearchText.isEmpty && !viewModel.destinationSearchResults.isEmpty
                    }
            }
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.12))
        .cornerRadius(12)
    }

    private var searchResultsDropdown: some View {
        Group {
            if showSearchResults {
                VStack(alignment: .leading, spacing: 0) {
                    if isEditingUserLocation {
                        ForEach(viewModel.startSearchResults, id: \.self) { result in
                            Button {
                                viewModel.setStartLocationFromCompletion(result)
                                viewModel.startSearchText = result.title
                                isEditingUserLocation = false
                                showSearchResults = false
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(result.title).foregroundColor(.primary)
                                    if !result.subtitle.isEmpty {
                                        Text(result.subtitle).font(.caption).foregroundColor(.secondary)
                                    }
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal)
                            }
                            if result != viewModel.startSearchResults.last { Divider() }
                        }
                    } else if isEditingDestination {
                        ForEach(viewModel.destinationSearchResults, id: \.self) { result in
                            Button {
                                viewModel.setDestinationFromCompletion(result)
                                viewModel.destinationSearchText = result.title
                                isEditingDestination = false
                                showSearchResults = false
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(result.title).foregroundColor(.primary)
                                    if !result.subtitle.isEmpty {
                                        Text(result.subtitle).font(.caption).foregroundColor(.secondary)
                                    }
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal)
                            }
                            if result != viewModel.destinationSearchResults.last { Divider() }
                        }
                    }
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
                .padding(.horizontal, 2)
            }
        }
    }

    private var matchingRoutesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Matching Routes")
                .font(.headline)
                .padding(.bottom, 4)
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(viewModel.matchingRoutes, id: \ .self) { route in
                        NavigationLink(destination: RouteResultView(routeResult: RouteResultModel.from(route: route))) {
                            RouteCardView(route: route)
                        }
                    }
                }
                .padding(.vertical, 4)
            }
            .frame(maxHeight: 400)
        }
        .padding(.top, 8)
    }
}

#Preview {
    SearchResultView(selectedCompletion: MKLocalSearchCompletion())
}
