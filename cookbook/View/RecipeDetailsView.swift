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
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading, spacing: 16){
                
//
                Text("Title")
                    .font(.title)
                Divider()

                
//                Image
                Image("Stock")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 220)
                    .clipped()
                    .cornerRadius(10)

                       
                
                
                
//                Ingredents
                VStack(spacing: 10){
                    Text("Ingrediants:")
                        .font(.title2)
                    
                    Text("Butter 1x")
                    
                }
                
//                Instructions
                VStack(spacing: 10){
                    Text("Instructions:")
                        .font(.title2)
                    Text("Butter 1x")

                }
                
            }.padding(10)
        }
        .navigationTitle(Text("Title"))
    }
}

#Preview {
    RecipeDetailsView(path: .constant(NavigationPath()))
}
