//
//  NewModel.swift
//  FlyestApp
//

import Foundation

/// A country-specific news item that may impact traveler safety.
struct NewsArticle: Identifiable, Codable {
    enum Topic: String, Codable, CaseIterable {
        case politics = "Politics"
        case environment = "Environment"
        case social = "Social"
        case safety = "Safety"
        case economy = "Economy"
    }

    let id: UUID
    var headline: String
    var summary: String
    var source: String
    var topic: Topic
    var country: String
    var publishedAt: Date
    var isBreaking: Bool

    init(
        id: UUID = UUID(),
        headline: String,
        summary: String,
        source: String,
        topic: Topic,
        country: String,
        publishedAt: Date = Date(),
        isBreaking: Bool = false
    ) {
        self.id = id
        self.headline = headline
        self.summary = summary
        self.source = source
        self.topic = topic
        self.country = country
        self.publishedAt = publishedAt
        self.isBreaking = isBreaking
    }
}
