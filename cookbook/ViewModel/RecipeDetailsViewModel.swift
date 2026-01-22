//
//  RecipeDetailsViewModel.swift
//  cookbook
//
//  Created by tanmaydeep on 02/02/26.
//
import Foundation
import SwiftUI
import CoreData

@Observable
final class RecipeDetailsViewModel {
    var recipe: RecipeEntity?
    private let recipeService: RecipeService
    
    init(recipe: RecipeEntity, context: NSManagedObjectContext) {
        self.recipeService = RecipeService(context: context)
        self.recipe = recipe
    }

    var ingredientList: [String] {
        guard let set = recipe?.ingredients as? Set<IngredientEntity> else { return [] }
        return set.compactMap { $0.name }.sorted()
    }

    var instructionList: [String] {
        guard let set = recipe?.instructions as? Set<InstructionEntity> else { return [] }
        return set.sorted { $0.order < $1.order }
                  .compactMap { $0.stepText }
    }
    
    var recipeImage: Image? {
        guard let data = recipe?.image, let uiImage = UIImage(data: data) else { return nil }
        return Image(uiImage: uiImage)
    }

    func deleteRecipe() {
        guard let recipe else { return }
        recipeService.delete(recipe: recipe)
    }
}
