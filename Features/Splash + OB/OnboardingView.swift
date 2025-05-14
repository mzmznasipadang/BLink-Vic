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
        VStack(spacing: 24) {
            // Drag indicator
            RoundedRectangle(cornerRadius: 2)
                .frame(width: 40, height: 4)
                .foregroundColor(.gray.opacity(0.3))
                .padding(.top, 16)

            // Welcome Text
            (
                Text("Welcome to ")
                    .font(.system(size: 28, weight: .bold)) +
                Text("BLink!")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color("Utama"))
            )

            // Feature Cards
            VStack(spacing: 16) {
                FeatureCard(icon: "point.topright.arrow.triangle.backward.to.point.bottomleft.filled.scurvepath", title: "Navigate Easier", description: "Using our route finder, plan your trip better!")
                FeatureCard(icon: "bus", title: "Worry Less", description: "Now you can ride BSD Link with confidence with our app")
                FeatureCard(icon: "checkmark.seal", title: "Guarantee", description: "Guarantee pusing kepala ngoding ini dah")
            }
            .padding(.horizontal)
            
            Spacer()
        }.padding()
            
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
//        .background(Color(.systemGray6))
    }
}

struct FeatureCard: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .foregroundColor(Color("Utama"))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    OnboardingView()
}
