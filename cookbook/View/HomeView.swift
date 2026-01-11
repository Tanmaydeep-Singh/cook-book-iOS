//
//  HomeView.swift
//  cookbook
//
//  Created by tanmaydeep on 31/01/26.
//

import SwiftUI

struct HomeView: View {
    @Binding var path: NavigationPath

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("Go to Recipes") {
            path.append(Routes.recipeDetails)
        }
    }
}

#Preview {
    HomeView(path: .constant(NavigationPath()))
}
