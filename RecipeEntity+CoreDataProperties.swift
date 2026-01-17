//
//  RecipeEntity+CoreDataProperties.swift
//  cookbook
//
//  Created by tanmaydeep on 02/02/26.
//
//

public import Foundation
public import CoreData


public typealias RecipeEntityCoreDataPropertiesSet = NSSet

extension RecipeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeEntity> {
        return NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var recipeDescription: String?
    @NSManaged public var date: Date?
    @NSManaged public var ingredients: NSSet?
    @NSManaged public var instructions: NSSet?

}

// MARK: Generated accessors for ingredients
extension RecipeEntity {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: IngredientEntity)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: IngredientEntity)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

// MARK: Generated accessors for instructions
extension RecipeEntity {

    @objc(addInstructionsObject:)
    @NSManaged public func addToInstructions(_ value: InstructionEntity)

    @objc(removeInstructionsObject:)
    @NSManaged public func removeFromInstructions(_ value: InstructionEntity)

    @objc(addInstructions:)
    @NSManaged public func addToInstructions(_ values: NSSet)

    @objc(removeInstructions:)
    @NSManaged public func removeFromInstructions(_ values: NSSet)

}

extension RecipeEntity : Identifiable {

}
