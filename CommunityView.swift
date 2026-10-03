//
//  CommunityView.swift
//  FlyestApp
//

import SwiftUI

/// Community feed to connect with fellow travelers and expats, plus a
/// composer to start new discussions.
struct CommunityView: View {
    @EnvironmentObject private var store: AppStore
    @State private var showComposer = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    nearbyMembers
                    discussionFeed
                }
                .padding()
            }
            .navigationTitle("Community")
            .background(Color(.systemGroupedBackground))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showComposer = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            .sheet(isPresented: $showComposer) {
                PostComposerView()
                    .presentationDetents([.medium])
            }
        }
    }

    private var nearbyMembers: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Travelers near you")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(store.members) { member in
                        MemberCard(member: member)
                    }
                }
            }
        }
    }

    private var discussionFeed: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Discussions")
                .font(.headline)
            ForEach(store.posts) { post in
                PostRow(post: post)
            }
        }
    }
}

struct MemberCard: View {
    let member: CommunityMember

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: member.travelerType.symbolName)
                    .font(.title3)
                    .foregroundStyle(.accent)
                Spacer()
            }
            Text(member.name)
                .font(.subheadline.weight(.semibold))
            Text("\(member.homeCountry) → \(member.currentCity)")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(member.bio)
                .font(.caption2)
                .foregroundStyle(.tertiary)
                .lineLimit(3)
        }
        .padding(14)
        .frame(width: 200, height: 150, alignment: .topLeading)
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16))
    }
}

struct PostRow: View {
    let post: CommunityPost

    var body: some View {
        Card {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .foregroundStyle(.secondary)
                    VStack(alignment: .leading, spacing: 1) {
                        Text(post.authorName)
                            .font(.subheadline.weight(.semibold))
                        Text(post.city)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Text(post.postedAt.relativeShort)
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
                Text(post.content)
                    .font(.subheadline)
                HStack(spacing: 20) {
                    Label("\(post.likes)", systemImage: "heart")
                    Label("\(post.replies)", systemImage: "bubble.right")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
    }
}

/// Simple composer used to add a new discussion post to the feed.
struct PostComposerView: View {
    @EnvironmentObject private var store: AppStore
    @Environment(\.dismiss) private var dismiss
    @State private var text = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $text)
                    .frame(maxHeight: .infinity)
                    .overlay(alignment: .topLeading) {
                        if text.isEmpty {
                            Text("Share a question or tip with the community…")
                                .foregroundStyle(.tertiary)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                                .allowsHitTesting(false)
                        }
                    }
            }
            .padding()
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Post") {
                        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmed.isEmpty else { return }
                        store.addPost(content: trimmed)
                        dismiss()
                    }
                    .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    CommunityView()
        .environmentObject(AppStore())
}
