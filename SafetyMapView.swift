//
//  SafetyMapView.swift
//  FlyestApp


import SwiftUI
import MapKit

/// An interactive map that plots safety zones colored by risk level.
struct SafetyMapView: View {
    @EnvironmentObject private var store: AppStore
    @State private var selectedZone: SafetyZone?
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.6812, longitude: 139.7671),
            span: MKCoordinateSpan(latitudeDelta: 0.12, longitudeDelta: 0.12)
        )
    )

    var body: some View {
        Map(position: $cameraPosition, selection: $selectedZone) {
            UserAnnotation()

            ForEach(store.safetyZones) { zone in
                Marker(zone.name, systemImage: zone.riskLevel.symbolName, coordinate: zone.coordinate)
                    .tint(zone.riskLevel.color)
                    .tag(zone)

                MapCircle(center: zone.coordinate, radius: zone.radius)
                    .foregroundStyle(zone.riskLevel.color.opacity(0.15))
                    .stroke(zone.riskLevel.color.opacity(0.6), lineWidth: 1)
            }
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
        }
        .navigationTitle("Risk Map")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            legend
        }
        .sheet(item: $selectedZone) { zone in
            SafetyZoneDetailView(zone: zone)
                .presentationDetents([.medium, .large])
        }
    }

    private var legend: some View {
        HStack(spacing: 14) {
            ForEach(RiskLevel.allCases) { level in
                HStack(spacing: 4) {
                    Circle()
                        .fill(level.color)
                        .frame(width: 10, height: 10)
                    Text(level.rawValue)
                        .font(.caption2)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial, in: Capsule())
        .padding(.bottom, 8)
    }
}

#Preview {
    NavigationStack {
        SafetyMapView()
            .environmentObject(AppStore())
    }
}
