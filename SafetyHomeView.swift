//
//  SafetyHomeView.swift
//  FlyestApp


import SwiftUI
import CoreLocation

/// The safety dashboard: current-area risk, live alerts, a map entry point,
/// and quick access to emergency resources.
struct SafetyHomeView: View {
   @EnvironmentObject private var store: AppStore
   @EnvironmentObject private var location: LocationManager

   var body: some View {
       NavigationStack {
           ScrollView {
               VStack(spacing: 16) {
                   currentAreaCard
                   quickActions
                   alertsSection
               }
               .padding()
           }
           .navigationTitle("Safety")
           .background(Color(.systemGroupedBackground))
           .toolbar {
               ToolbarItem(placement: .topBarTrailing) {
                   NavigationLink {
                       ProfileView()
                   } label: {
                       Image(systemName: "person.crop.circle")
                   }
               }
           }
           .onAppear {
               if location.authorizationStatus == .notDetermined {
                   location.requestPermission()
               }
           }
       }
   }

   private var currentAreaCard: some View {
       Card {
           VStack(alignment: .leading, spacing: 12) {
               HStack {
                   VStack(alignment: .leading, spacing: 4) {
                       Text("Current area")
                           .font(.subheadline)
                           .foregroundStyle(.secondary)
                       Text("\(store.profile.currentCity), \(store.profile.currentCountry)")
                           .font(.title3.weight(.semibold))
                   }
                   Spacer()
                   RiskBadge(level: store.currentAreaRisk)
               }
               Text(store.currentAreaRisk.advice)
                   .font(.subheadline)
                   .foregroundStyle(.secondary)

               if location.authorizationStatus == .denied {
                   Label("Enable location for area-specific safety data", systemImage: "location.slash")
                       .font(.caption)
                       .foregroundStyle(.orange)
               }
           }
       }
   }

   private var quickActions: some View {
       HStack(spacing: 12) {
           NavigationLink {
               SafetyMapView()
           } label: {
               actionTile(title: "Risk Map", systemImage: "map.fill", color: .blue)
           }
           NavigationLink {
               EmergencyView()
           } label: {
               actionTile(title: "Emergency", systemImage: "sos", color: .red)
           }
       }
   }

   private func actionTile(title: String, systemImage: String, color: Color) -> some View {
       VStack(spacing: 8) {
           Image(systemName: systemImage)
               .font(.title2)
           Text(title)
               .font(.subheadline.weight(.semibold))
       }
       .frame(maxWidth: .infinity)
       .padding(.vertical, 20)
       .background(color.opacity(0.15), in: RoundedRectangle(cornerRadius: 16))
       .foregroundStyle(color)
   }

   private var alertsSection: some View {
       VStack(alignment: .leading, spacing: 12) {
           HStack {
               Text("Active Alerts")
                   .font(.headline)
               Spacer()
               Text("\(store.alerts.count)")
                   .font(.subheadline)
                   .foregroundStyle(.secondary)
           }

           ForEach(store.alerts) { alert in
               AlertRow(alert: alert)
           }
       }
   }
}

/// A single alert row used in the safety dashboard.
struct AlertRow: View {
   let alert: SafetyAlert

   var body: some View {
       Card {
           VStack(alignment: .leading, spacing: 8) {
               HStack {
                   Label(alert.category.rawValue, systemImage: alert.category.symbolName)
                       .font(.caption.weight(.semibold))
                       .foregroundStyle(.secondary)
                   Spacer()
                   RiskBadge(level: alert.riskLevel)
               }
               Text(alert.title)
                   .font(.subheadline.weight(.semibold))
               Text(alert.message)
                   .font(.caption)
                   .foregroundStyle(.secondary)
               HStack {
                   Label(alert.location, systemImage: "mappin.circle.fill")
                   Spacer()
                   Text(alert.date.relativeShort)
               }
               .font(.caption2)
               .foregroundStyle(.tertiary)
           }
       }
   }
}

#Preview {
   SafetyHomeView()
       .environmentObject(AppStore())
       .environmentObject(LocationManager())
}
