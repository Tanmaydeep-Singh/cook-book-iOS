//
//  AddRecipeView.swift
//  cookbook
//
//  Created by tanmaydeep on 01/02/26.
//

import SwiftUI
import PhotosUI
import CoreData

struct AddRecipeView: View {
    @Environment(AddRecipeViewModel.self) private var viewModel
    @Environment(HomeViewModel.self) private var homeViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var newIngredient = ""
    @State private var newInstruction = ""
    
    @State private var showSuccessAlert = false

    var body: some View {
        @Bindable var vm = viewModel
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 8) {
                    Text("Recipe Title").font(.headline)
                    TextField("Enter recipe name", text: $vm.title)
                        .textFieldStyle(.roundedBorder)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Recipe Image").font(.headline)
                    PhotosPicker(selection: $vm.selectedImageItem, matching: .images) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.15))
                                .frame(height: 200)

                            if let recipeImage = vm.recipeImage {
                                recipeImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 200)
                                    .clipped()
                                    .cornerRadius(12)
                            } else {
                                VStack(spacing: 8) {
                                    Image(systemName: "photo").font(.largeTitle)
                                    Text("Add Image")
                                }
                                .foregroundColor(.gray)
                            }
                        }
                    }
                }

                Divider()

                VStack(alignment: .leading, spacing: 12) {
                    Text("Ingredients").font(.title2).fontWeight(.semibold)
                    HStack {
                        TextField("Add ingredient", text: $newIngredient)
                            .textFieldStyle(.roundedBorder)
                        Button("Add") {
                            guard !newIngredient.isEmpty else { return }
                            vm.ingredients.append(newIngredient)
                            newIngredient = ""
                        }
                    }
                    ForEach(vm.ingredients, id: \.self) { item in
                        Text("• \(item)")
                    }
                }

                Divider()

                VStack(alignment: .leading, spacing: 12) {
                    Text("Instructions").font(.title2).fontWeight(.semibold)
                    HStack {
                        TextField("Add instruction", text: $newInstruction)
                            .textFieldStyle(.roundedBorder)
                        Button("Add") {
                            guard !newInstruction.isEmpty else { return }
                            vm.instructions.append(newInstruction)
                            newInstruction = ""
                        }
                    }
                    ForEach(vm.instructions.indices, id: \.self) { index in
                        Text("\(index + 1). \(vm.instructions[index])")
                    }
                }

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Description").font(.title2).fontWeight(.semibold)
                    TextEditor(text: $vm.description)
                        .frame(height: 120)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                }

                Button(action: {
                    if viewModel.saveRecipe() {
                        homeViewModel.fetchRecipes()
                        showSuccessAlert = true
                    }
                }) {
                    Text("Save Recipe")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(vm.title.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(vm.title.isEmpty)
            }
            .padding()
        }
        .navigationTitle("Add Recipe")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Recipe Saved", isPresented: $showSuccessAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Your recipe has been successfully added to the cookbook.")
        }
        .task(id: vm.selectedImageItem) {
            await viewModel.handleImageChange()
        }
    }
}
