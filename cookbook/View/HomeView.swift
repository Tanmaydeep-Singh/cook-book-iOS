//
//  HomeView.swift
//  cookbook
//
//  Created by tanmaydeep on 31/01/26.
//

import SwiftUI
import Combine
internal import CoreData
struct HomeView: View {
    @Binding var path: NavigationPath
    @Environment(HomeViewModel.self) private var viewModel
    
    @State private var columns: Int = 2
    @State private var zoomScale: CGFloat = 1.0

    var body: some View {
        content
            .navigationTitle("Cookbook")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        path.append(Routes.addRecipe)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.recipes.isEmpty {
            EmptyStateView()
        } else {
            RecipeGridView(
                recipes: viewModel.recipes,
                columns: $columns,
                zoomScale: $zoomScale,
                onSelect: { recipe in
                    path.append(Routes.recipeDetails)
                }
            )
        }
    }
}

