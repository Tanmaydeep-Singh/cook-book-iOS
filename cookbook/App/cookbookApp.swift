//
//  cookbookApp.swift
//  cookbook
//
//  Created by tanmaydeep on 31/01/26.
//
//
//  cookbookApp.swift
//  cookbook
//
//  Created by tanmaydeep on 31/01/26.
//

import SwiftUI
import CoreData

@main
struct CookbookApp: App {

    // Core Data
    private let coreDataManager = CoreDataManager.shared

    // View Models
    private let homeViewModel: HomeViewModel
    private let addRecipeViewModel: AddRecipeViewModel

    
    // Initialzing models
    init() {
        let context = coreDataManager.container.viewContext

        self.homeViewModel = HomeViewModel(
            recipeService: RecipeService(context: context)
        )

        self.addRecipeViewModel = AddRecipeViewModel(
            context: context
        )
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            // Core Data
            .environment(\.managedObjectContext,
                          coreDataManager.container.viewContext)

            // Modern Observable injection
            .environment(homeViewModel)
            .environment(addRecipeViewModel)
        }
    }
}
