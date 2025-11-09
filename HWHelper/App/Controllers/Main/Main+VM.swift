import Foundation

extension MainController {
    
    final class ViewModel {
        
        // MARK: - Delegates
        
        var reloadData: () -> Void = { }
        
        // MARK: - Properties
        
        var pinnedRows: [Row] {
            students
                .filter { $0.pinned }
                .sorted { $0.lastChangedDate > $1.lastChangedDate }
                .map { .item($0) }
        }
        
        var groupRows: [Row] {
            students
                .filter { !$0.pinned && $0.category == .group }
                .sorted { $0.lastChangedDate > $1.lastChangedDate }
                .map { .item($0) }
        }
        
        var individualRows: [Row] {
            students
                .filter { !$0.pinned && $0.category == .individual }
                .sorted { $0.lastChangedDate > $1.lastChangedDate }
                .map { .item($0) }
        }
        
        private var students = [StudentModel]() {
            didSet {
                reloadData()
            }
        }
        
        // MARK: - Actions
        
        func fetchData() {
            let sortDescriptors: [NSSortDescriptor] = [.init(key: "lastChangedDate", ascending: true)]
            let savedStudents: [CDStudent] = CDStudent.findAll(sortDescriptors: sortDescriptors)
            
            students = savedStudents.map { .init(object: $0) }
        }
        
        func updatePin(_ pinned: Bool, model: StudentModel) {
            guard let index = students.firstIndex(where: { $0.id == model.id }) else { return }
            
            var model = students.remove(at: index)
            model.update(pinned: pinned)
            students.insert(model, at: index)
        }
        
        func deleteStudent(model: StudentModel) {
            guard let object = model.object else { return }
            
            CoreDataManager.shared.delete(object: object)
            students.removeAll { $0.id == model.id }
        }
        
        func createMock() {
            let category: StudentCategory = Int.random(in: 0...1) == 1 ? .group : .individual
            
            var model = StudentModel(
                category: category,
                title: "Случайная Злата Саранова \(Int.random(in: 0...50))",
                templateText: "Пусто"
            )
            
            model.save()
            
            students.append(model)
        }
    }
}
