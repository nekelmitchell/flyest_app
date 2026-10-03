//
//  ReviewModel.swift
//  FlyestApp
//

import Foundation

/// A foreigner-focused review of a place, home, or workplace.
struct ForeignerReview: Identifiable, Codable {
    enum Category: String, Codable, CaseIterable, Identifiable {
        case restaurant = "Restaurant"
        case housing = "Housing"
        case workplace = "Workplace"
        case activity = "Activity"

        var id: String { rawValue }

        var symbolName: String {
            switch self {
            case .restaurant: return "fork.knife"
            case .housing: return "house.fill"
            case .workplace: return "building.2.fill"
            case .activity: return "figure.hiking"
            }
        }
    }

    let id: UUID
    var name: String
    var category: Category
    var city: String
    var rating: Double            // 0...5
    var foreignerFriendly: Bool
    var englishSpoken: Bool
    var summary: String
    var culturalTip: String

    init(
        id: UUID = UUID(),
        name: String,
        category: Category,
        city: String,
        rating: Double,
        foreignerFriendly: Bool,
        englishSpoken: Bool,
        summary: String,
        culturalTip: String
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.city = city
        self.rating = rating
        self.foreignerFriendly = foreignerFriendly
        self.englishSpoken = englishSpoken
        self.summary = summary
        self.culturalTip = culturalTip
    }
}
