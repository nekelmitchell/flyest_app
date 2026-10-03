//
//  AppStore.swift
//  FlyestApp

import Foundation
import Combine

/// App-wide observable state. Currently backed by `SampleData`; swap the
/// initializers for live service calls (Firebase, REST, etc.) later.
@MainActor
final class AppStore: ObservableObject {
    @Published var profile: UserProfile
    @Published var safetyZones: [SafetyZone]
    @Published var alerts: [SafetyAlert]
    @Published var emergencyContacts: [EmergencyContact]
    @Published var news: [NewsArticle]
    @Published var members: [CommunityMember]
    @Published var posts: [CommunityPost]
    @Published var reviews: [ForeignerReview]
    @Published var phraseCategories: [PhraseCategory]

    init() {
        self.profile = .sample
        self.safetyZones = SampleData.safetyZones
        self.alerts = SampleData.alerts
        self.emergencyContacts = SampleData.emergencyContacts
        self.news = SampleData.news
        self.members = SampleData.members
        self.posts = SampleData.posts
        self.reviews = SampleData.reviews
        self.phraseCategories = SampleData.phraseCategories
    }

    /// Overall risk for the user's current area, derived from active alerts.
    var currentAreaRisk: RiskLevel {
        let ranked: [RiskLevel] = [.low, .moderate, .high, .severe]
        return alerts
            .map(\.riskLevel)
            .max(by: { ranked.firstIndex(of: $0)! < ranked.firstIndex(of: $1)! }) ?? .low
    }

    func toggleLearned(categoryID: UUID, phraseID: UUID) {
        guard let cIndex = phraseCategories.firstIndex(where: { $0.id == categoryID }),
              let pIndex = phraseCategories[cIndex].phrases.firstIndex(where: { $0.id == phraseID })
        else { return }
        phraseCategories[cIndex].phrases[pIndex].learned.toggle()
    }

    func addPost(content: String) {
        let post = CommunityPost(
            authorName: profile.name,
            city: profile.currentCity,
            content: content
        )
        posts.insert(post, at: 0)
    }
}
