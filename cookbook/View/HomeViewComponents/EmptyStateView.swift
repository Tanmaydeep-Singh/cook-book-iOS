//
//  EmptyStateView.swift
//  cookbook
//
//  Created by tanmaydeep on 02/02/26.
//

import SwiftUI

struct EmptyStateView: View {
        var body: some View {
            VStack(spacing: 12) {
                Image(systemName: "book.closed")
                    .font(.system(size: 48))
                    .foregroundColor(.secondary)

                Text("No recipes yet")
                    .font(.title3)
                    .fontWeight(.semibold)

                Text("Tap + to add your first recipe")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
}

#Preview {
    EmptyStateView()
}
