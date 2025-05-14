//
//  OnboardingView.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 07/05/25.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            // Header
            Text("Welcome to ")
                .font(.system(size: 32, weight: .bold))
            + Text("BLink!")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(Color("Utama"))

            // Features list
            VStack(alignment: .leading, spacing: 24) {
                HStack(alignment: .top, spacing: 16) {
                    Image(systemName: "point.topright.filled.arrow.triangle.backward.to.point.bottomleft.scurvepath")
                        .font(.system(size: 24))
                        .foregroundColor(Color("Utama"))

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Navigate Easier")
                            .font(.headline)
                        Text("Using our route finder, plane your trip better!")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }

                HStack(alignment: .top, spacing: 16) {
                    Image(systemName: "bus")
                        .font(.system(size: 24))
                        .foregroundColor(Color("Utama"))

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Worry Less")
                            .font(.headline)
                        Text("Now you can ride BSD Link with confidence with our app")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }

                HStack(alignment: .top, spacing: 16) {
                    Image(systemName: "checkmark.seal")
                        .font(.system(size: 24))
                        .foregroundColor(Color("Utama"))

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Guarantee")
                            .font(.headline)
                        Text("Guarantee pusing kepala ini mah")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }

            Spacer()

            // Continue button
            Button(action: {
                // handle continue
            }) {
                Text("Continue")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("Utama"))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 16)
        .padding(.top, 32)
    }
}

#Preview {
    OnboardingView()
}
