import Foundation

extension MainController {
    
    final class ViewModel {
        
        // MARK: - Delegates
        
        var reloadData: () -> Void = { }
        
        // MARK: - Properties
        
        var pinnedRows: [Row] {
            students
                .filter { $0.pinned }
                .sorted { $0.title > $1.title }
                .map { .item($0) }
        }
        
        var groupRows: [Row] {
            students
                .filter { !$0.pinned && $0.category == .group }
                .sorted { $0.title > $1.title }
                .map { .item($0) }
        }
        
        var individualRows: [Row] {
            students
                .filter { !$0.pinned && $0.category == .individual }
                .sorted { $0.title > $1.title }
                .map { .item($0) }
        }
        
        private var students = [StudentModel]()
        
        // MARK: - Actions
        
        func fetchData() {
            let savedStudents: [CDStudent] = CDStudent.findAll(sortDescriptors: [.init(key: "title", ascending: true)])
            
            students = savedStudents.map { .init(object: $0) }
            reloadData()
        }
        
        func updatePin(_ pinned: Bool, model: StudentModel) {
            guard let index = students.firstIndex(where: { $0.id == model.id }) else { return }
            
            var model = students.remove(at: index)
            model.update(pinned: pinned)
            students.insert(model, at: index)
            
            reloadData()
        }
        
        func deleteStudent(model: StudentModel) {
            guard let object = model.object else { return }
            
            CoreDataManager.shared.delete(object: object)
            students.removeAll { $0.id == model.id }
            reloadData()
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
            reloadData()
        }
    }
}
