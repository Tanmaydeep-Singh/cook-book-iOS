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
        var recipeImage: Image? {
        guard let data = recipe?.image, let uiImage = UIImage(data: data) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
    
    func deleteRecipe() {
        guard let recipe else { return }
        recipeService.delete(recipe: recipe)
    }
}
