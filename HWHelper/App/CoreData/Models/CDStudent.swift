//
//  CDStudent+CoreDataClass.swift
//  HWHelper
//
//  Created by Полищук Александр on 09.11.2025.
//
//

import Foundation
import CoreData

@objc(CDStudent)
final class CDStudent: CDObject {
    
    @NSManaged var id: String
    @NSManaged var category: String
    @NSManaged var pinned: Bool
    @NSManaged var title: String
    @NSManaged var templateText: String
    @NSManaged var lastChangedDate: Date
}

extension CDStudent {
    
    @discardableResult
    static func createEntity(model: MainController.StudentModel) -> CDStudent? {
        let object = Self(context: CoreDataManager.shared.context)
        
        object.id = model.id
        object.category = model.category.rawValue
        object.pinned = model.pinned
        object.title = model.title
        object.templateText = model.templateText
        object.lastChangedDate = model.lastChangedDate
        
        guard CoreDataManager.shared.save() else { return nil }
        
        return object
    }
    
    @discardableResult
    static func updateEntity(model: MainController.StudentModel) -> Bool {
        guard let object = model.object else { return false }
        
        object.id = model.id
        object.category = model.category.rawValue
        object.pinned = model.pinned
        object.title = model.title
        object.templateText = model.templateText
        object.lastChangedDate = model.lastChangedDate
        
        return CoreDataManager.shared.save()
    }
}
