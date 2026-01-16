//
//  RecipeDetailsView.swift
//  cookbook
//
//  Created by tanmaydeep on 31/01/26.
//
import SwiftUI

struct RecipeDetailsView: View {
    @Binding var path: NavigationPath

    let ingredients = [
        "Butter – 1 tbsp",
        "Garlic – 2 cloves",
        "Cream – 1 cup",
        "Pasta – 200g",
        "Salt to taste"
    ]

    let instructions = [
        "Boil pasta in salted water until al dente.",
        "Heat butter in a pan and add garlic.",
        "Pour cream and simmer for 2–3 minutes.",
        "Add cooked pasta and mix well.",
        "Season and serve hot."
    ]

    let description =
    """
    This creamy pasta recipe is quick, comforting, and perfect for busy evenings.
    It pairs well with garlic bread and a fresh salad.
    """

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {

                // MARK: - Title
                Text("Creamy Pasta")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // MARK: - Image
                Image("Stock")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 220)
                    .clipped()
                    .cornerRadius(12)

                // MARK: - Ingredients
                VStack(alignment: .leading, spacing: 12) {
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.semibold)

                    ForEach(ingredients, id: \.self) { item in
                        Text("• \(item)")
                            .font(.body)
                    }
                }

                Divider()

                // MARK: - Instructions
                VStack(alignment: .leading, spacing: 12) {
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.semibold)

                    ForEach(instructions.indices, id: \.self) { index in
                        Text("\(index + 1). \(instructions[index])")
                            .font(.body)
                            .lineSpacing(4)
                    }
                }

                Divider()

                // MARK: - Description / Details
                VStack(alignment: .leading, spacing: 12) {
                    Text("Details")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(6)
                }
            }
            .padding()
        }
        .navigationTitle("Recipe")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RecipeDetailsView(path: .constant(NavigationPath()))
}
