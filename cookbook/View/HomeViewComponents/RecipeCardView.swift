//
//  RecipeCardView.swift
//  cookbook
//
//  Created by tanmaydeep on 02/02/26.
//

import SwiftUI

struct RecipeCardView: View {
    let recipe: RecipeEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            recipeImage

            Text(recipe.wrappedTitle)
                .font(.headline)
                .lineLimit(1)
        }
    }

    @ViewBuilder
    private var recipeImage: some View {
        if let data = recipe.image,
           let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(height: 140)
                .clipped()
                .cornerRadius(10)
        } else {
            Color.gray.opacity(0.2)
                .frame(height: 140)
                .cornerRadius(10)
        }
    }
}
