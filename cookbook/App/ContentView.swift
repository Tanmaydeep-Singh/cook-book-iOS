//
//  ContentView.swift
//  cookbook
//
//  Created by tanmaydeep on 31/01/26.
//
import SwiftUI
import CoreData

struct ContentView: View {
    @State private var path = NavigationPath()
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
                .navigationDestination(for: Routes.self) { route in
                    switch route {
                    case .recipeDetails(let recipe):
                        RecipeDetailsView(recipe: recipe, context: viewContext)
                    case .addRecipe:
                        AddRecipeView()
                    }
                }
        }
    }
}

#Preview {
    let context = CoreDataManager.shared.container.viewContext
    
    let service = RecipeService(context: context)
    let homeVM = HomeViewModel(recipeService: service)
    let addVM = AddRecipeViewModel(context: context)
    
    ContentView()
        .environment(\.managedObjectContext, context)
        .environment(homeVM)
        .environment(addVM)
}
