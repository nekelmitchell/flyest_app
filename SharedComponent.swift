//
//  SharedComponent.swift
//  FlyestApp
//

import SwiftUI

/// Reusable color + label helpers keyed off the shared model enums.
extension RiskLevel {
    var color: Color {
        switch self {
        case .low: return .green
        case .moderate: return .yellow
        case .high: return .orange
        case .severe: return .red
        }
    }
}

/// A small pill badge showing a risk level with matching color and icon.
struct RiskBadge: View {
    let level: RiskLevel

    var body: some View {
        Label(level.rawValue, systemImage: level.symbolName)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(level.color.opacity(0.18), in: Capsule())
            .foregroundStyle(level.color)
    }
}

/// A star rating display supporting half stars.
struct StarRating: View {
    let rating: Double
    var maximum: Int = 5

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<maximum, id: \.self) { index in
                Image(systemName: symbol(for: index))
                    .foregroundStyle(.yellow)
                    .font(.caption)
            }
            Text(String(format: "%.1f", rating))
                .font(.caption.weight(.medium))
                .foregroundStyle(.secondary)
        }
    }

    private func symbol(for index: Int) -> String {
        let value = Double(index) + 1
        if rating >= value { return "star.fill" }
        if rating >= value - 0.5 { return "star.leadinghalf.filled" }
        return "star"
    }
}

/// A rounded card container used throughout the app.
struct Card<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16))
    }
}

extension Date {
    /// Short relative description, e.g. "3h ago".
    var relativeShort: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
