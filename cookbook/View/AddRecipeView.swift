//
//  AddRecipeView.swift
//  cookbook
//
//  Created by tanmaydeep on 01/02/26.
//
import SwiftUI
import PhotosUI

struct AddRecipeView: View {

    // MARK: - Form State
    @State private var title = ""
    @State private var description = ""

    @State private var ingredients: [String] = []
    @State private var instructions: [String] = []

    @State private var newIngredient = ""
    @State private var newInstruction = ""

    @State private var selectedImage: PhotosPickerItem?
    @State private var recipeImage: Image?

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {

                // MARK: - Title Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Recipe Title")
                        .font(.headline)

                    TextField("Enter recipe name", text: $title)
                        .textFieldStyle(.roundedBorder)
                }

                // MARK: - Image Picker
                VStack(alignment: .leading, spacing: 8) {
                    Text("Recipe Image")
                        .font(.headline)

                    PhotosPicker(selection: $selectedImage, matching: .images) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.15))
                                .frame(height: 200)

                            if let recipeImage {
                                recipeImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 200)
                                    .clipped()
                                    .cornerRadius(12)
                            } else {
                                VStack(spacing: 8) {
                                    Image(systemName: "photo")
                                        .font(.largeTitle)
                                    Text("Add Image")
                                }
                                .foregroundColor(.gray)
                            }
                        }
                    }
                }

                Divider()

                // MARK: - Ingredients Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.semibold)

                    HStack {
                        TextField("Add ingredient", text: $newIngredient)
                            .textFieldStyle(.roundedBorder)

                        Button("Add") {
                            guard !newIngredient.isEmpty else { return }
                            ingredients.append(newIngredient)
                            newIngredient = ""
                        }
                    }

                    ForEach(ingredients, id: \.self) { item in
                        Text("• \(item)")
                    }
                }

                Divider()

                // MARK: - Instructions Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.semibold)

                    HStack {
                        TextField("Add instruction", text: $newInstruction)
                            .textFieldStyle(.roundedBorder)

                        Button("Add") {
                            guard !newInstruction.isEmpty else { return }
                            instructions.append(newInstruction)
                            newInstruction = ""
                        }
                    }

                    ForEach(instructions.indices, id: \.self) { index in
                        Text("\(index + 1). \(instructions[index])")
                    }
                }

                Divider()

                // MARK: - Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.title2)
                        .fontWeight(.semibold)

                    TextEditor(text: $description)
                        .frame(height: 120)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3))
                        )
                }

                // MARK: - Save Button
                Button(action: saveRecipe) {
                    Text("Save Recipe")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle("Add Recipe")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedImage) { newValue in
            loadImage(from: newValue)
        }
    }

    // MARK: - Helpers
    private func loadImage(from item: PhotosPickerItem?) {
        guard let item else { return }

        Task {
            if let data = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                recipeImage = Image(uiImage: uiImage)
            }
        }
    }

    private func saveRecipe() {
        print("Saved Recipe:")
        print(title, ingredients, instructions, description)
    }
}

#Preview {
    NavigationStack {
        AddRecipeView()
    }
}
