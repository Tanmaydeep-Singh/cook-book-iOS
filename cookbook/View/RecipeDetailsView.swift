//
//  RecipeDetailsView.swift
//  cookbook
//
//  Created by tanmaydeep on 31/01/26.
//

import SwiftUI

struct RecipeDetailsView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        Text("Details!")
    }
}

#Preview {
    RecipeDetailsView(path: .constant(NavigationPath()))
}
