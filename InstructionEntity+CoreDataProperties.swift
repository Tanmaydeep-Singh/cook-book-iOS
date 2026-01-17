//
//  InstructionEntity+CoreDataProperties.swift
//  cookbook
//
//  Created by tanmaydeep on 02/02/26.
//
//

public import Foundation
public import CoreData


public typealias InstructionEntityCoreDataPropertiesSet = NSSet

extension InstructionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InstructionEntity> {
        return NSFetchRequest<InstructionEntity>(entityName: "InstructionEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var stepText: String?
    @NSManaged public var order: Int64
    @NSManaged public var recipe: RecipeEntity?

}

extension InstructionEntity : Identifiable {

}
