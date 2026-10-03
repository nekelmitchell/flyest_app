//
//  NewViews.swift
//  FlyestApp
//

import SwiftUI

/// Country-specific news feed with topic filtering and breaking-news highlights.
struct NewsView: View {
    @EnvironmentObject private var store: AppStore
    @State private var selectedTopic: NewsArticle.Topic?

    private var filteredNews: [NewsArticle] {
        guard let topic = selectedTopic else { return store.news }
        return store.news.filter { $0.topic == topic }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    topicFilter
                    ForEach(filteredNews) { article in
                        NewsCard(article: article)
                    }
                }
                .padding()
            }
            .navigationTitle("News")
            .background(Color(.systemGroupedBackground))
        }
    }

    private var topicFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                filterChip(title: "All", isSelected: selectedTopic == nil) {
                    selectedTopic = nil
                }
                ForEach(NewsArticle.Topic.allCases, id: \.self) { topic in
                    filterChip(title: topic.rawValue, isSelected: selectedTopic == topic) {
                        selectedTopic = topic
                    }
                }
            }
        }
    }

    private func filterChip(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.medium))
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(isSelected ? Color.accentColor : Color(.secondarySystemBackground),
                            in: Capsule())
                .foregroundStyle(isSelected ? .white : .primary)
        }
    }
}

struct NewsCard: View {
    let article: NewsArticle

    var body: some View {
        Card {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    if article.isBreaking {
                        Text("BREAKING")
                            .font(.caption2.weight(.bold))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(Color.red, in: Capsule())
                            .foregroundStyle(.white)
                    }
                    Text(article.topic.rawValue)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.accent)
                    Spacer()
                    Text(article.publishedAt.relativeShort)
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
                Text(article.headline)
                    .font(.headline)
                Text(article.summary)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(article.source)
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
    }
}

#Preview {
    NewsView()
        .environmentObject(AppStore())
}
