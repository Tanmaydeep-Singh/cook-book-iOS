//
//  RecipeDetailsView.swift
//  cookbook
//
//  Created by tanmaydeep on 31/01/26.
//
import SwiftUI
import CoreData
struct RecipeDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(HomeViewModel.self) private var homeViewModel

    
    let recipe: RecipeEntity
    private var viewModel: RecipeDetailsViewModel

    init(recipe: RecipeEntity, context: NSManagedObjectContext) {
        self.recipe = recipe
        self.viewModel = RecipeDetailsViewModel(recipe: recipe, context: context)
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                
                Text(recipe.title ?? "Unknown Recipe")
                    .font(.largeTitle).fontWeight(.bold)

                if let image = viewModel.recipeImage {
                    image.resizable().scaledToFill()
                        .frame(height: 250).clipped().cornerRadius(12)
                }

                if !viewModel.ingredientList.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ingredients").font(.title2).fontWeight(.semibold)
                        ForEach(viewModel.ingredientList, id: \.self) { item in
                            Text("• \(item)").font(.body)
                        }
                    }
                    Divider()
                }

                if !viewModel.instructionList.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Instructions").font(.title2).fontWeight(.semibold)
                        ForEach(Array(viewModel.instructionList.enumerated()), id: \.offset) { index, step in
                            Text("\(index + 1). \(step)")
                                .font(.body).lineSpacing(4)
                        }
                    }
                    Divider()
                }

                if let description = recipe.recipeDescription, !description.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Details").font(.title2).fontWeight(.semibold)
                        Text(description).font(.body).foregroundColor(.secondary).lineSpacing(6)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Recipe")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(role: .destructive) {
                
                viewModel.deleteRecipe()
                homeViewModel.fetchRecipes()
                dismiss()
            } label: { Image(systemName: "trash") }
        }
    }
}
