//
//  RecipeGridView.swift
//  cookbook
//
//  Created by tanmaydeep on 02/02/26.
//

import SwiftUI

struct RecipeGridView: View {
    let recipes: [RecipeEntity]
    @Binding var columns: Int
    @Binding var zoomScale: CGFloat
    let onSelect: (RecipeEntity) -> Void

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(
                    repeating: GridItem(.flexible(), spacing: 6),
                    count: columns
                ),
                spacing: 6
            ) {
                ForEach(recipes, id: \.id) { recipe in
                    RecipeCardView(recipe: recipe)
                        .onTapGesture {
                            onSelect(recipe)
                        }
                }
            }
            .padding(6)
            .scaleEffect(zoomScale)
        }
        .gesture(magnificationGesture)
    }

    private var magnificationGesture: some Gesture {
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
    }
}

