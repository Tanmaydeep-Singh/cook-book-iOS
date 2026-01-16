//
//  HomeView.swift
//  cookbook
//
//  Created by tanmaydeep on 31/01/26.
//
//
//  HomeView.swift
//  cookbook
//
//  Created by tanmaydeep on 31/01/26.
//

import SwiftUI

struct HomeView: View {
    @Binding var path: NavigationPath
    
    @State private var columns = 2;
    @State private var zoomScale: CGFloat = 1;
    
    let photos = Array(1...20)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: columns), spacing: 2) {
                ForEach(photos, id: \.self) { item in
                    Image("Stock")
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(Text("Photo \(item)"))
                        .cornerRadius(8)
                        .onTapGesture {
                            path.append(Routes.recipeDetails)
                        }
                }
            }
            .padding(2)
            .scaleEffect(zoomScale)
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
            .simultaneousGesture(
                MagnificationGesture()
                    .onChanged { value in
                        
                        zoomScale = value
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            if value > 1.3 {
                                
                                columns = 1
                            } else if value < 0.7 {
                                
                                columns = 2
                            }
                            
                            zoomScale = 1.0
                        }
                    }
            )
           
        }
    }
}

#Preview {
    HomeView(path: .constant(NavigationPath()))
}

