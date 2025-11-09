import Foundation

extension MainController {
    
    struct StudentModel {
        
        private(set) var id: String
        private(set) var category: StudentCategory
        private(set) var pinned: Bool
        private(set) var title: String
        private(set) var templateText: String
        
        private(set) var object: CDStudent?
        
        init(
            id: String = UUID().uuidString,
            category: StudentCategory,
            pinned: Bool = false,
            title: String,
            templateText: String
        ) {
            self.id = id
            self.category = category
            self.pinned = pinned
            self.title = title
            self.templateText = templateText
            self.object = nil
        }
        
        init(object: CDStudent) {
            self.id = object.id
            self.category = .init(rawValue: object.category) ?? .individual
            self.pinned = object.pinned
            self.title = object.title
            self.templateText = object.templateText
            self.object = object
        }
        
        mutating func save() {
            object = CDStudent.createEntity(model: self)
        }
        
        mutating func update(
            id: String? = nil,
            category: StudentCategory? = nil,
            pinned: Bool? = nil,
            title: String? = nil,
            templateText: String? = nil
        ) {
            if let id {
                self.id = id
            }
            
            if let category {
                self.category = category
            }
            
            if let pinned {
                self.pinned = pinned
            }
            
            if let title {
                self.title = title
            }
            
            if let templateText {
                self.templateText = templateText
            }
            
            CDStudent.updateEntity(model: self)
        }
    }
}

extension MainController.StudentModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (rhs: Self, lhs: Self) -> Bool {
        rhs.id == lhs.id
    }
}
