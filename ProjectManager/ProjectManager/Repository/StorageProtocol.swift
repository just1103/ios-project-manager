import Foundation

protocol StorageProtocol {
    func create(task: Task)
    func fetch() -> [Task]
    func update(task: Task)
    func delete(task: Task)
}

class TaskRepository: StorageProtocol {
    private var tasks: [UUID: Task] = [:]
    
    func create(task: Task) {
        tasks[task.id] = task
    }
    
    func fetch() -> [Task] {
        return tasks.map { $0.value }
    }
    
    func update(task: Task) {
        tasks.updateValue(task, forKey: task.id)
    }
    
    func delete(task: Task) {
        tasks.removeValue(forKey: task.id)
    }
}

//class RemoteStorage: StorageProtocol {  // Firestore (Object)
//}
//
//class LocalStorage: StorageProtocol {  // Realm (JSON) - Mapper 타입 추가가 필요할까?
//}
