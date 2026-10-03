//
//  ReviewsView.swift
//  FlyestApp
//

import SwiftUI

/// Foreigner-focused reviews for restaurants, housing, workplaces, and activities.
struct ReviewsView: View {
    @EnvironmentObject private var store: AppStore
    @State private var selectedCategory: ForeignerReview.Category?

    private var filteredReviews: [ForeignerReview] {
        guard let category = selectedCategory else { return store.reviews }
        return store.reviews.filter { $0.category == category }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    categoryFilter
                    ForEach(filteredReviews) { review in
                        ReviewCard(review: review)
                    }
                }
                .padding()
            }
            .navigationTitle("Reviews")
            .background(Color(.systemGroupedBackground))
        }
    }

    private var categoryFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                chip(title: "All", icon: "square.grid.2x2", isSelected: selectedCategory == nil) {
                    selectedCategory = nil
                }
                ForEach(ForeignerReview.Category.allCases) { category in
                    chip(title: category.rawValue, icon: category.symbolName,
                         isSelected: selectedCategory == category) {
                        selectedCategory = category
                    }
                }
            }
        }
    }

    private func chip(title: String, icon: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Label(title, systemImage: icon)
                .font(.subheadline.weight(.medium))
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(isSelected ? Color.accentColor : Color(.secondarySystemBackground),
                            in: Capsule())
                .foregroundStyle(isSelected ? .white : .primary)
        }
    }
}

struct ReviewCard: View {
    let review: ForeignerReview

    var body: some View {
        Card {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Label(review.category.rawValue, systemImage: review.category.symbolName)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.accent)
                    Spacer()
                    StarRating(rating: review.rating)
                }
                Text(review.name)
                    .font(.headline)
                Text(review.summary)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                HStack(spacing: 8) {
                    if review.foreignerFriendly {
                        tag("Foreigner-friendly", icon: "globe", color: .green)
                    }
                    if review.englishSpoken {
                        tag("English OK", icon: "character.bubble", color: .blue)
                    }
                }

                Label(review.culturalTip, systemImage: "lightbulb.fill")
                    .font(.caption)
                    .foregroundStyle(.orange)
                    .padding(.top, 2)
            }
        }
    }

    private func tag(_ text: String, icon: String, color: Color) -> some View {
        Label(text, systemImage: icon)
            .font(.caption2.weight(.semibold))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.15), in: Capsule())
            .foregroundStyle(color)
    }
}

#Preview {
    ReviewsView()
        .environmentObject(AppStore())
}
