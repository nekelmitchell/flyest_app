//
//  ProfileView.swift
//  FlyestApp
//


import SwiftUI

/// User profile and travel context. Editing is intentionally minimal for the starter.
struct ProfileView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        List {
            Section {
                HStack(spacing: 16) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(.accent)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(store.profile.name)
                            .font(.title3.weight(.semibold))
                        Label(store.profile.travelerType.rawValue,
                              systemImage: store.profile.travelerType.symbolName)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }

            Section("Travel") {
                infoRow(label: "Home country", value: store.profile.homeCountry, icon: "house.fill")
                infoRow(label: "Currently in", value: "\(store.profile.currentCity), \(store.profile.currentCountry)", icon: "airplane")
                infoRow(label: "Learning", value: store.profile.learningLanguage, icon: "character.bubble.fill")
            }

            Section("Safety") {
                infoRow(label: "Current area risk", value: store.currentAreaRisk.rawValue, icon: store.currentAreaRisk.symbolName)
                infoRow(label: "Active alerts", value: "\(store.alerts.count)", icon: "bell.fill")
            }

            Section {
                Label("Flyest v0.1.0 — Starter build", systemImage: "airplane.circle.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func infoRow(label: String, value: String, icon: String) -> some View {
        HStack {
            Label(label, systemImage: icon)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
        .font(.subheadline)
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .environmentObject(AppStore())
    }
}
