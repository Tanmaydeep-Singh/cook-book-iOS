//
//  RecipeDetailsView.swift
//  cookbook
//
//  Created by tanmaydeep on 31/01/26.
//
import SwiftUI
import CoreData

struct RecipeDetailsView: View {
@Environment(\.managedObjectContext) private var viewContext
@Environment(\.dismiss) private var dismiss

let recipe: RecipeEntity
private var viewModel: RecipeDetailsViewModel

init(recipe: RecipeEntity, context: NSManagedObjectContext) {
    self.recipe = recipe
    self.viewModel = RecipeDetailsViewModel(recipe: recipe, context: context)
}

var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 20) {
            
            // MARK: - Title
            Text(recipe.title ?? "Unknown Recipe")
                .font(.largeTitle)
                .fontWeight(.bold)

            // MARK: - Image
            if let image = viewModel.recipeImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(12)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 200)
                    .overlay(Image(systemName: "fork.knife").font(.largeTitle).foregroundColor(.gray))
            }

            // MARK: - Ingredients
            if let ingredients = recipe.ingredients as? [String], !ingredients.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.semibold)

                    ForEach(ingredients, id: \.self) { item in
                        Text("• \(item)").font(.body)
                    }
                }
                Divider()
            }

            // MARK: - Instructions
            if let instructions = recipe.instructions as? [String], !instructions.isEmpty {
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
            }

            // MARK: - Description
            if let description = recipe.recipeDescription, !description.isEmpty {
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
        }
        .padding()
    }
    .navigationTitle("Recipe")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
            Button(role: .destructive) {
                viewModel.deleteRecipe()
                dismiss()
            } label: {
                Image(systemName: "trash")
            }
        }
    }
}
}
