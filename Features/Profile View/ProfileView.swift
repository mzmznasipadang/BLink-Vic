//
//  ProfileView.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 07/05/25.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 24) {
            // Avatar
            Image("Profile")
                .resizable()
                .foregroundColor(.blue)
                .padding(.top, 40)
                .clipShape(Circle())
                .frame(width: 150, height: 250)

            // Name
            Text("John Doe")
                .font(.title2)
                .fontWeight(.semibold)

            // Placeholder for profile actions/settings
            VStack(spacing: 16) {
                Button(action: {}) {
                    HStack {
                        Image(systemName: "gearshape")
                        Text("Settings")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.12))
                    .cornerRadius(12)
                }
                .buttonStyle(PlainButtonStyle())

                Button(action: {}) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Log Out")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.12))
                    .cornerRadius(12)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)

            Spacer()
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    ProfileView()
}
