import Foundation

protocol taskManageable {
    var todoTasks: [Task] { get }
    var doingTasks: [Task] { get }
    var doneTasks: [Task] { get }
    
    // 메서드 추가
}

class TaskManager {
    private(set) var todoTasks: [Task] = []
    private(set) var doingTasks: [Task] = []
    private(set) var doneTasks: [Task] = []
    
    func create(task: Task) {
        todoTasks.append(task)
    }
    
    func updateTask(of task: Task, title: String, body: String, dueDate: Date) {
        task.title = title
        task.body = body
        task.dueDate = dueDate
    }
    
    func delete(task: Task) {
        let id = task.id
        todoTasks.removeAll { $0.id == id }
        doingTasks.removeAll { $0.id == id }
        doneTasks.removeAll { $0.id == id }
    }
    
    func changeProcessStatus(of task: Task, to newProcessStatus: ProcessStatus) {
        task.processStatus = newProcessStatus
    }
}
