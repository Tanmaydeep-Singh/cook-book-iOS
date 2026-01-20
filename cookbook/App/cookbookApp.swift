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

    private let coreDataManager = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            //Inject Core Data context
            .environment(
                \.managedObjectContext,
                coreDataManager.container.viewContext
            )
            //Inject HomeViewModel
            .environmentObject(
                HomeViewModel(
                    recipeService: RecipeService(
                        context: coreDataManager.container.viewContext
                    )
                )
            )
        }
    }
}
