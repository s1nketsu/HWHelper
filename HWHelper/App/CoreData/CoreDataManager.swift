import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    // MARK: - Properties
    
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HWHelper")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    // MARK: - Init
    
    private init() { }
    
    // MARK: - Actions
    
    
    func save() {
        guard context.hasChanges else { return }
        
        try? context.save()
    }
}

