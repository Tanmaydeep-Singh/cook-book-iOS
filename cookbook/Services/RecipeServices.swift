//
//  RecipeServices.swift
//  cookbook
//
//  Created by tanmaydeep on 02/02/26.
//

import Foundation
import CoreData

final class RecipeService {
    
    private let context: NSManagedObjectContext
    
    // Initializing NSManagerObjectContext for CRUD operations
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // Get all Recipies
    func getAllRecipies() -> [RecipeEntity] {
        
        let request : NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        
        do {
                    return try context.fetch(request)
                } catch {
                    print("Failed to fetch recipes:", error.localizedDescription)
                    return []
                }
        
    }
    
    // Get Recipe by ID
    func getRecpeById(_ id: UUID) -> RecipeEntity? {
        
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
                request.fetchLimit = 1
        
        request.predicate = NSPredicate(
                    format: "id == %@",
                    id as CVarArg
                )

                do {
                    return try context.fetch(request).first
                } catch {
                    print("Failed to fetch recipe by id:", error.localizedDescription)
                    return nil
                }
    }
    
    // Create Recipe
        func createRecipe(
            title: String,
            description: String,
            ingredients: [String],
            instructions: [String],
            imageData: Data?
        ) {
            let recipe = RecipeEntity(context: context)
            recipe.id = UUID()
            recipe.title = title
            recipe.recipeDescription = description
            recipe.date = Date()
            recipe.image = imageData

            // Add ingredients
            ingredients.forEach { name in
                let ingredient = IngredientEntity(context: context)
                ingredient.id = UUID()
                ingredient.name = name
                ingredient.recipe = recipe
            }

            // Add instructions (ordered)
            instructions.enumerated().forEach { index, step in
                let instruction = InstructionEntity(context: context)
                instruction.id = UUID()
                instruction.stepText = step
                instruction.order = Int64(index)
                instruction.recipe = recipe
            }

            save()
        }
    

    
    
    // Delete
    func delete(recipe: RecipeEntity) {
            context.delete(recipe)
            save()
        }
    
    
    // Save
        private func save() {
            do {
                try context.save()
            } catch {
                print("Core Data save error:", error.localizedDescription)
            }
        }
}
