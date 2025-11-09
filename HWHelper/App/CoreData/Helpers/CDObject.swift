import CoreData
import Foundation

public class CDObject: NSManagedObject {
    
    convenience init() {
        self.init(context: CoreDataManager.shared.context)
    }
    
    static func findAll<T: CDObject>(
        sortDescriptors: [NSSortDescriptor]? = nil,
        predicate: NSPredicate? = nil
    ) -> [T] {
        let request = fetchRequest
        
        request.sortDescriptors = sortDescriptors
        request.predicate = predicate
        
        let objects = try? CoreDataManager.shared.context.fetch(request)
        
        return objects as? [T] ?? []
    }
}
