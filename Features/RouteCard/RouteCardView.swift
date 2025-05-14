//
//  RouteCardView.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 09/05/25.
//

import Foundation
import SwiftUI
import SwiftData

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = []
    
    func path(in rect: CGRect) -> Path {
        let safeRadius = radius.isNaN || radius.isInfinite ? min(rect.width, rect.height) / 2 : radius
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: safeRadius, height: safeRadius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    /// Clip to only the specified corners
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}


// 2. The Card View
struct RouteCardView: View {
    @Bindable var route: RouteModel
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 12) {
                Text(route.routeCode)
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(route.colorName))
                    .clipShape(Capsule())

                Text(route.routeName)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.primary)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }

//            HStack(spacing: 6) {
//                Image(systemName: "clock")
//                    .foregroundColor(Color.blue)
//                Text("Departs at 14:30") // Replace with dynamic data if available
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}


// 3. Preview
struct RouteCardView_Previews: PreviewProvider {
    static var previews: some View {
        RouteCardView(
            route: RouteModel(
                routeCode: "GS",
                routeName: "Greenwich Park → Sektor 1.3",
                startPoint: "Greenwich Park",
                endPoint: "Sektor 1.3",
                colorName: "BadgeGS",
                estimatedTime: 65,
                distance: 6.9
            )
        )
        .previewLayout(.sizeThatFits)
    }
}
