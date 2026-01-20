//
//  HomeViewModel.swift
//  cookbook
//
//  Created by tanmaydeep on 02/02/26.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var recipes: [RecipeEntity] = []

    private let recipeService: RecipeService

    init(recipeService: RecipeService) {
        self.recipeService = recipeService
        fetchRecipes()
    }

    func fetchRecipes() {
        recipes = recipeService.getAllRecipies()
    }

    func deleteRecipe(_ recipe: RecipeEntity) {
        recipeService.delete(recipe: recipe)
        fetchRecipes()
    }
}
