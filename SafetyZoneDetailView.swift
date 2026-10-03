//
//  SafetyZoneDetailView.swift
//  FlyestApp
//


import SwiftUI

/// Detail sheet shown when a safety zone is tapped on the map.
struct SafetyZoneDetailView: View {
    let zone: SafetyZone

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(zone.name)
                            .font(.title2.weight(.bold))
                        Spacer()
                        RiskBadge(level: zone.riskLevel)
                    }

                    Text(zone.summary)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Card {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Safety Ratings")
                                .font(.headline)
                            ratingRow(label: "Locals", value: zone.localRating)
                            ratingRow(label: "Travelers", value: zone.travelerRating)
                        }
                    }

                    if !zone.tips.isEmpty {
                        Card {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Local Safety Tips")
                                    .font(.headline)
                                ForEach(zone.tips, id: \.self) { tip in
                                    Label(tip, systemImage: "lightbulb.fill")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }

                    Card {
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Guidance", systemImage: zone.riskLevel.symbolName)
                                .font(.headline)
                                .foregroundStyle(zone.riskLevel.color)
                            Text(zone.riskLevel.advice)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Area Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func ratingRow(label: String, value: Double) -> some View {
        HStack {
            Text(label)
                .font(.subheadline)
            Spacer()
            StarRating(rating: value)
        }
    }
}

#Preview {
    SafetyZoneDetailView(zone: SampleData.safetyZones[1])
}
