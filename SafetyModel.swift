//
//  SafetyModel.swift
//  FlyestApp

import Foundation
import CoreLocation

/// Overall risk level used across safety features.
enum RiskLevel: String, Codable, CaseIterable, Identifiable {
    case low = "Low"
    case moderate = "Moderate"
    case high = "High"
    case severe = "Severe"

    var id: String { rawValue }

    /// SF Symbol representing the level.
    var symbolName: String {
        switch self {
        case .low: return "checkmark.shield.fill"
        case .moderate: return "exclamationmark.shield.fill"
        case .high: return "exclamationmark.triangle.fill"
        case .severe: return "xmark.octagon.fill"
        }
    }

    var advice: String {
        switch self {
        case .low: return "Generally safe. Stay aware of your surroundings."
        case .moderate: return "Exercise increased caution, especially at night."
        case .high: return "Avoid non-essential travel. Stay in well-populated areas."
        case .severe: return "Do not travel here. Follow local authority guidance."
        }
    }
}

/// A geographic area annotated with a safety rating.
struct SafetyZone: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var summary: String
    var riskLevel: RiskLevel
    var latitude: Double
    var longitude: Double
    /// Radius in meters that the zone covers.
    var radius: Double
    var localRating: Double      // 0...5 from residents
    var travelerRating: Double   // 0...5 from foreigners
    var tips: [String]

    init(
        id: UUID = UUID(),
        name: String,
        summary: String,
        riskLevel: RiskLevel,
        latitude: Double,
        longitude: Double,
        radius: Double = 800,
        localRating: Double,
        travelerRating: Double,
        tips: [String] = []
    ) {
        self.id = id
        self.name = name
        self.summary = summary
        self.riskLevel = riskLevel
        self.latitude = latitude
        self.longitude = longitude
        self.radius = radius
        self.localRating = localRating
        self.travelerRating = travelerRating
        self.tips = tips
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

/// A time-sensitive alert affecting a region.
struct SafetyAlert: Identifiable, Codable {
    enum Category: String, Codable, CaseIterable {
        case weather = "Weather"
        case crime = "Crime"
        case political = "Political"
        case health = "Health"
        case transport = "Transport"

        var symbolName: String {
            switch self {
            case .weather: return "cloud.bolt.rain.fill"
            case .crime: return "person.fill.xmark"
            case .political: return "megaphone.fill"
            case .health: return "cross.case.fill"
            case .transport: return "bus.fill"
            }
        }
    }

    let id: UUID
    var title: String
    var message: String
    var category: Category
    var riskLevel: RiskLevel
    var location: String
    var date: Date

    init(
        id: UUID = UUID(),
        title: String,
        message: String,
        category: Category,
        riskLevel: RiskLevel,
        location: String,
        date: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.message = message
        self.category = category
        self.riskLevel = riskLevel
        self.location = location
        self.date = date
    }
}

/// Emergency service contact for a country/region.
struct EmergencyContact: Identifiable, Codable {
    let id: UUID
    var service: String
    var number: String
    var symbolName: String

    init(id: UUID = UUID(), service: String, number: String, symbolName: String) {
        self.id = id
        self.service = service
        self.number = number
        self.symbolName = symbolName
    }
}

