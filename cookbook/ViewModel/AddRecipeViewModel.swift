//
//  AddRecipeViewModel.swift
//  cookbook
//
//  Created by tanmaydeep on 02/02/26.
//
import Foundation
import SwiftUI
import PhotosUI
import CoreData

@Observable
final class AddRecipeViewModel {
    // Form Properties
    var title: String = ""
    var description: String = ""
    var ingredients: [String] = []
    var instructions: [String] = []
    
    // Media Properties
    var selectedImageItem: PhotosPickerItem?
    var recipeImage: Image?
    private var imageData: Data?

    private let recipeService: RecipeService
    
    init(context: NSManagedObjectContext) {
        self.recipeService = RecipeService(context: context)
    }

    func handleImageChange() async {
        guard let selectedImageItem else { return }
        if let data = try? await selectedImageItem.loadTransferable(type: Data.self),
           let uiImage = UIImage(data: data) {
            self.imageData = data
            self.recipeImage = Image(uiImage: uiImage)
        }
    }

    func saveRecipe() -> Bool {
        guard !title.isEmpty else { return false }
        
        recipeService.createRecipe(
            title: title,
            description: description,
            ingredients: ingredients,
            instructions: instructions,
            imageData: imageData
        )
        
        clearForm()
        return true
    }

    private func clearForm() {
        title = ""
        description = ""
        ingredients = []
        instructions = []
        selectedImageItem = nil
        recipeImage = nil
        imageData = nil
    }
}
