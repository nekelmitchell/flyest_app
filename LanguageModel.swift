//
//  LanguageModel.swift
//  FlyestApp
//

import Foundation

/// A practical, context-based phrase for a traveler to learn.
struct Phrase: Identifiable, Codable {
    let id: UUID
    var original: String       // phrase in the target language
    var pronunciation: String  // phonetic guide
    var translation: String    // English meaning
    var learned: Bool

    init(
        id: UUID = UUID(),
        original: String,
        pronunciation: String,
        translation: String,
        learned: Bool = false
    ) {
        self.id = id
        self.original = original
        self.pronunciation = pronunciation
        self.translation = translation
        self.learned = learned
    }
}

/// A grouping of phrases by real-world context.
struct PhraseCategory: Identifiable, Codable {
    enum Context: String, Codable, CaseIterable {
        case greetings = "Greetings"
        case emergencies = "Emergencies"
        case transportation = "Transportation"
        case dining = "Dining"
        case shopping = "Shopping"
        case directions = "Directions"

        var symbolName: String {
            switch self {
            case .greetings: return "hand.wave.fill"
            case .emergencies: return "cross.case.fill"
            case .transportation: return "tram.fill"
            case .dining: return "fork.knife"
            case .shopping: return "bag.fill"
            case .directions: return "map.fill"
            }
        }
    }

    let id: UUID
    var context: Context
    var language: String
    var phrases: [Phrase]

    init(id: UUID = UUID(), context: Context, language: String, phrases: [Phrase]) {
        self.id = id
        self.context = context
        self.language = language
        self.phrases = phrases
    }

    var progress: Double {
        guard !phrases.isEmpty else { return 0 }
        let learned = phrases.filter { $0.learned }.count
        return Double(learned) / Double(phrases.count)
    }
}
