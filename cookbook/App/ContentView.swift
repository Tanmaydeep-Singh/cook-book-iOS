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
    
    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
                .navigationDestination(for: Routes.self) { route in
                    switch route {
                    case .recipeDetails:
                        RecipeDetailsView(path: $path)
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
    let viewModel = HomeViewModel(recipeService: service)
    
    ContentView()
        .environment(viewModel) 
}
