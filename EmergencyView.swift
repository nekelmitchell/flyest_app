//
//  EmergencyView.swift
//  FlyestApp
//

import SwiftUI

/// Quick-access emergency resources with one-tap dialing.
struct EmergencyView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        List {
            Section {
                ForEach(store.emergencyContacts) { contact in
                    Button {
                        call(contact.number)
                    } label: {
                        HStack(spacing: 14) {
                            Image(systemName: contact.symbolName)
                                .font(.title3)
                                .frame(width: 34)
                                .foregroundStyle(.red)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(contact.service)
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(.primary)
                                Text(contact.number)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: "phone.fill")
                                .foregroundStyle(.green)
                        }
                    }
                }
            } header: {
                Text("Tap to call")
            } footer: {
                Text("Numbers shown are for \(store.profile.currentCountry). Always confirm local emergency numbers on arrival.")
            }
        }
        .navigationTitle("Emergency")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func call(_ number: String) {
        let sanitized = number.filter { $0.isNumber || $0 == "+" }
        guard let url = URL(string: "tel://\(sanitized)"),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}

#Preview {
    NavigationStack {
        EmergencyView()
            .environmentObject(AppStore())
    }
}
