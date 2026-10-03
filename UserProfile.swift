//
//  UserProfile.swift
//  FlyestApp
//

import Foundation

/// The signed-in user's profile and travel context.
struct UserProfile: Codable {
    var name: String
    var homeCountry: String
    var currentCountry: String
    var currentCity: String
    var travelerType: TravelerType
    var learningLanguage: String

    static let sample = UserProfile(
        name: "Alex Rivera",
        homeCountry: "United States",
        currentCountry: "Japan",
        currentCity: "Tokyo",
        travelerType: .digitalNomad,
        learningLanguage: "Japanese"
    )
}
