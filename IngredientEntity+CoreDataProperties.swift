//
//  IngredientEntity+CoreDataProperties.swift
//  cookbook
//
//  Created by tanmaydeep on 02/02/26.
//
//

public import Foundation
public import CoreData


public typealias IngredientEntityCoreDataPropertiesSet = NSSet

extension IngredientEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IngredientEntity> {
        return NSFetchRequest<IngredientEntity>(entityName: "IngredientEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var recipe: RecipeEntity?

}

extension IngredientEntity : Identifiable {

}
