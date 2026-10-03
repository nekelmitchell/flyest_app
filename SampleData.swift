//
//  SampleData.swift
//  FlyestApp
//

import Foundation

/// Central mock data source. Replace these with live API / Firebase calls as the
/// backend comes online — the views only depend on the model types, not on this file.
enum SampleData {

    // MARK: - Safety

    static let safetyZones: [SafetyZone] = [
        SafetyZone(
            name: "Shibuya",
            summary: "Busy shopping and nightlife district. Very safe but crowded.",
            riskLevel: .low,
            latitude: 35.6595, longitude: 139.7005,
            radius: 900,
            localRating: 4.6, travelerRating: 4.8,
            tips: ["Watch for pickpockets in crowds", "Trains stop around midnight"]
        ),
        SafetyZone(
            name: "Shinjuku – Kabukicho",
            summary: "Entertainment area. Generally fine but avoid touts late at night.",
            riskLevel: .moderate,
            latitude: 35.6947, longitude: 139.7027,
            radius: 700,
            localRating: 3.4, travelerRating: 3.1,
            tips: ["Avoid unsolicited bar invitations", "Stay on main streets after 1am"]
        ),
        SafetyZone(
            name: "Chiyoda – Imperial Palace",
            summary: "Government and historic area. Quiet and very safe.",
            riskLevel: .low,
            latitude: 35.6852, longitude: 139.7528,
            radius: 1000,
            localRating: 4.9, travelerRating: 4.9,
            tips: ["Great for morning runs", "Some areas restricted to the public"]
        ),
        SafetyZone(
            name: "Roppongi",
            summary: "Nightlife hub popular with foreigners. Watch for scams late night.",
            riskLevel: .high,
            latitude: 35.6628, longitude: 139.7315,
            radius: 600,
            localRating: 2.8, travelerRating: 2.5,
            tips: ["Never leave drinks unattended", "Use official taxis only"]
        )
    ]

    static let alerts: [SafetyAlert] = [
        SafetyAlert(
            title: "Typhoon approaching Kanto region",
            message: "Heavy rain and strong winds expected Friday evening. Avoid coastal areas and secure loose items.",
            category: .weather,
            riskLevel: .high,
            location: "Tokyo, Japan",
            date: Date().addingTimeInterval(-3600 * 4)
        ),
        SafetyAlert(
            title: "Pickpocket reports in Kabukicho",
            message: "Increased pickpocketing reported near Shinjuku station east exit. Keep valuables secure.",
            category: .crime,
            riskLevel: .moderate,
            location: "Shinjuku, Tokyo",
            date: Date().addingTimeInterval(-3600 * 20)
        ),
        SafetyAlert(
            title: "Planned rail maintenance",
            message: "Yamanote line partial suspension this weekend. Plan alternate routes.",
            category: .transport,
            riskLevel: .low,
            location: "Central Tokyo",
            date: Date().addingTimeInterval(-3600 * 30)
        )
    ]

    static let emergencyContacts: [EmergencyContact] = [
        EmergencyContact(service: "Police", number: "110", symbolName: "shield.fill"),
        EmergencyContact(service: "Ambulance & Fire", number: "119", symbolName: "cross.case.fill"),
        EmergencyContact(service: "Coast Guard", number: "118", symbolName: "sailboat.fill"),
        EmergencyContact(service: "U.S. Embassy Tokyo", number: "+81-3-3224-5000", symbolName: "building.columns.fill"),
        EmergencyContact(service: "Tourist Hotline (JNTO)", number: "050-3816-2787", symbolName: "phone.fill")
    ]

    // MARK: - News

    static let news: [NewsArticle] = [
        NewsArticle(
            headline: "Government issues weekend storm advisory",
            summary: "Authorities urge residents and visitors to stay indoors during the peak of the incoming typhoon.",
            source: "NHK World",
            topic: .safety,
            country: "Japan",
            publishedAt: Date().addingTimeInterval(-3600 * 2),
            isBreaking: true
        ),
        NewsArticle(
            headline: "New visa rules for digital nomads announced",
            summary: "A six-month remote-work visa will open for applications next quarter.",
            source: "Japan Times",
            topic: .politics,
            country: "Japan",
            publishedAt: Date().addingTimeInterval(-3600 * 8)
        ),
        NewsArticle(
            headline: "Cherry blossom season forecast released",
            summary: "Peak bloom in Tokyo expected late March, drawing record tourism.",
            source: "Kyodo News",
            topic: .social,
            country: "Japan",
            publishedAt: Date().addingTimeInterval(-3600 * 26)
        ),
        NewsArticle(
            headline: "Yen strengthens against the dollar",
            summary: "Currency shift may affect travel budgets for foreign visitors.",
            source: "Nikkei",
            topic: .economy,
            country: "Japan",
            publishedAt: Date().addingTimeInterval(-3600 * 40)
        )
    ]

    // MARK: - Community

    static let members: [CommunityMember] = [
        CommunityMember(name: "Maria S.", homeCountry: "Brazil", currentCity: "Tokyo",
                        bio: "Digital nomad, 2 years in Japan. Happy to help newcomers!",
                        travelerType: .digitalNomad),
        CommunityMember(name: "James O.", homeCountry: "USA", currentCity: "Yokosuka",
                        bio: "Stationed here with family. Love hiking on weekends.",
                        travelerType: .military),
        CommunityMember(name: "Aisha K.", homeCountry: "UK", currentCity: "Tokyo",
                        bio: "Grad student at Todai. Language exchange welcome.",
                        travelerType: .student)
    ]

    static let posts: [CommunityPost] = [
        CommunityPost(authorName: "Maria S.", city: "Tokyo",
                      content: "Best neighborhood for first-time expats with kids? Looking for English-friendly clinics nearby.",
                      likes: 24, replies: 8, postedAt: Date().addingTimeInterval(-3600 * 3)),
        CommunityPost(authorName: "James O.", city: "Yokosuka",
                      content: "Group hike this Saturday at Mt. Takao. All experience levels welcome! DM me.",
                      likes: 41, replies: 15, postedAt: Date().addingTimeInterval(-3600 * 12)),
        CommunityPost(authorName: "Aisha K.", city: "Tokyo",
                      content: "PSA: many banks need proof of residence before opening an account. Bring your residence card!",
                      likes: 67, replies: 22, postedAt: Date().addingTimeInterval(-3600 * 30))
    ]

    // MARK: - Reviews

    static let reviews: [ForeignerReview] = [
        ForeignerReview(name: "Ichiran Ramen", category: .restaurant, city: "Tokyo",
                        rating: 4.7, foreignerFriendly: true, englishSpoken: true,
                        summary: "Order via ticket machine with English menu. Solo booths make it easy.",
                        culturalTip: "Slurping noodles is polite and expected."),
        ForeignerReview(name: "Sakura Terrace Apartments", category: .housing, city: "Tokyo",
                        rating: 4.1, foreignerFriendly: true, englishSpoken: false,
                        summary: "Foreigner-friendly landlord, no guarantor required. Bring translation help for the lease.",
                        culturalTip: "Remove shoes at the entrance genkan."),
        ForeignerReview(name: "GlobalTech K.K.", category: .workplace, city: "Tokyo",
                        rating: 3.8, foreignerFriendly: true, englishSpoken: true,
                        summary: "International team, English-first meetings. Long hours during releases.",
                        culturalTip: "Exchange business cards with both hands."),
        ForeignerReview(name: "TeamLab Planets", category: .activity, city: "Tokyo",
                        rating: 4.9, foreignerFriendly: true, englishSpoken: true,
                        summary: "Immersive digital art museum. Book tickets online in advance.",
                        culturalTip: "You'll walk through water — wear shorts or roll up pants.")
    ]

    // MARK: - Language

    static let phraseCategories: [PhraseCategory] = [
        PhraseCategory(context: .greetings, language: "Japanese", phrases: [
            Phrase(original: "こんにちは", pronunciation: "kon-nichi-wa", translation: "Hello"),
            Phrase(original: "ありがとうございます", pronunciation: "arigatou gozaimasu", translation: "Thank you"),
            Phrase(original: "すみません", pronunciation: "sumimasen", translation: "Excuse me / Sorry")
        ]),
        PhraseCategory(context: .emergencies, language: "Japanese", phrases: [
            Phrase(original: "助けて！", pronunciation: "tasukete!", translation: "Help!"),
            Phrase(original: "警察を呼んでください", pronunciation: "keisatsu o yonde kudasai", translation: "Please call the police"),
            Phrase(original: "病院はどこですか", pronunciation: "byouin wa doko desu ka", translation: "Where is the hospital?")
        ]),
        PhraseCategory(context: .transportation, language: "Japanese", phrases: [
            Phrase(original: "駅はどこですか", pronunciation: "eki wa doko desu ka", translation: "Where is the station?"),
            Phrase(original: "切符をください", pronunciation: "kippu o kudasai", translation: "One ticket, please")
        ]),
        PhraseCategory(context: .dining, language: "Japanese", phrases: [
            Phrase(original: "おすすめは何ですか", pronunciation: "osusume wa nan desu ka", translation: "What do you recommend?"),
            Phrase(original: "お会計お願いします", pronunciation: "okaikei onegaishimasu", translation: "The bill, please")
        ])
    ]
}
