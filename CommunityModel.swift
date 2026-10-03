//
//  CommunityModel.swift
//  FlyestApp
//

import Foundation

/// A traveler / expat profile shown in the community feed.
struct CommunityMember: Identifiable, Codable {
    let id: UUID
    var name: String
    var homeCountry: String
    var currentCity: String
    var bio: String
    var travelerType: TravelerType

    init(
        id: UUID = UUID(),
        name: String,
        homeCountry: String,
        currentCity: String,
        bio: String,
        travelerType: TravelerType
    ) {
        self.id = id
        self.name = name
        self.homeCountry = homeCountry
        self.currentCity = currentCity
        self.bio = bio
        self.travelerType = travelerType
    }
}

enum TravelerType: String, Codable, CaseIterable, Identifiable {
    case military = "Military"
    case backpacker = "Backpacker"
    case digitalNomad = "Digital Nomad"
    case student = "International Student"
    case immigrant = "Immigrant"
    case worker = "Foreign Worker"
    case tourist = "Tourist"

    var id: String { rawValue }

    var symbolName: String {
        switch self {
        case .military: return "shield.lefthalf.filled"
        case .backpacker: return "backpack.fill"
        case .digitalNomad: return "laptopcomputer"
        case .student: return "graduationcap.fill"
        case .immigrant: return "house.fill"
        case .worker: return "briefcase.fill"
        case .tourist: return "camera.fill"
        }
    }
}

/// A discussion thread in the community.
struct CommunityPost: Identifiable, Codable {
    let id: UUID
    var authorName: String
    var city: String
    var content: String
    var likes: Int
    var replies: Int
    var postedAt: Date

    init(
        id: UUID = UUID(),
        authorName: String,
        city: String,
        content: String,
        likes: Int = 0,
        replies: Int = 0,
        postedAt: Date = Date()
    ) {
        self.id = id
        self.authorName = authorName
        self.city = city
        self.content = content
        self.likes = likes
        self.replies = replies
        self.postedAt = postedAt
    }
}
