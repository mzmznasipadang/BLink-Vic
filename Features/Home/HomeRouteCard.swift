import SwiftUI

struct HomeRouteCard: View {
    let route: HomeRouteViewData

    var body: some View {
        HStack(spacing: 12) {
            // Badge
            Text(route.routeCode)
                .font(.subheadline).fontWeight(.semibold)
                .foregroundColor(Color("BG"))
                .frame(minWidth: 40, minHeight: 32)
                .background(
                    Capsule()
                        .fill(Color(route.colorName, bundle: .main))
                )
                .padding(.leading, 4)

            // Route name
            Text("\(route.startPoint) → \(route.endPoint)")
                .font(.headline.weight(.medium))
                .foregroundColor(Color("Utama", bundle: .main))

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 2, x: 0, y: 1)
    }
}

