//
//  LanguageView.swift
//  FlyestApp
//

import SwiftUI

/// Context-based language learning: browse phrase categories and track progress.
struct LanguageView: View {
    @EnvironmentObject private var store: AppStore

    private var overallProgress: Double {
        let all = store.phraseCategories.flatMap(\.phrases)
        guard !all.isEmpty else { return 0 }
        return Double(all.filter(\.learned).count) / Double(all.count)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    progressCard
                    ForEach(store.phraseCategories) { category in
                        NavigationLink {
                            PhraseListView(categoryID: category.id)
                        } label: {
                            CategoryRow(category: category)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Language")
            .background(Color(.systemGroupedBackground))
        }
    }

    private var progressCard: some View {
        Card {
            VStack(alignment: .leading, spacing: 10) {
                Text("Learning \(store.profile.learningLanguage)")
                    .font(.headline)
                ProgressView(value: overallProgress)
                    .tint(.accentColor)
                Text("\(Int(overallProgress * 100))% of phrases mastered")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct CategoryRow: View {
    let category: PhraseCategory

    var body: some View {
        Card {
            HStack(spacing: 14) {
                Image(systemName: category.context.symbolName)
                    .font(.title2)
                    .frame(width: 40)
                    .foregroundStyle(.accent)
                VStack(alignment: .leading, spacing: 4) {
                    Text(category.context.rawValue)
                        .font(.subheadline.weight(.semibold))
                    Text("\(category.phrases.count) phrases")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    ProgressView(value: category.progress)
                        .tint(.accentColor)
                }
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
    }
}

/// Lists phrases within a category, allowing the user to mark each as learned.
struct PhraseListView: View {
    @EnvironmentObject private var store: AppStore
    let categoryID: UUID

    private var category: PhraseCategory? {
        store.phraseCategories.first { $0.id == categoryID }
    }

    var body: some View {
        List {
            if let category {
                ForEach(category.phrases) { phrase in
                    Button {
                        store.toggleLearned(categoryID: categoryID, phraseID: phrase.id)
                    } label: {
                        PhraseRow(phrase: phrase)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationTitle(category?.context.rawValue ?? "Phrases")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PhraseRow: View {
    let phrase: Phrase

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 3) {
                Text(phrase.original)
                    .font(.headline)
                Text(phrase.pronunciation)
                    .font(.subheadline)
                    .foregroundStyle(.accent)
                Text(phrase.translation)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: phrase.learned ? "checkmark.circle.fill" : "circle")
                .font(.title3)
                .foregroundStyle(phrase.learned ? .green : .secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    LanguageView()
        .environmentObject(AppStore())
}
