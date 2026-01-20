//
//  RecipeEntity+Extensions.swift
//  cookbook
//
//  Created by tanmaydeep on 02/02/26.
//
import Foundation

extension RecipeEntity {
    var wrappedTitle: String {
        title ?? "Untitled Recipe"
    }
}
