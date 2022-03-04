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
    
    func createTask(title: String, body: String, dueDate: TimeInterval) { // 매개변수로 Task를 받는게 좋을까?
        let newTask = Task(title: title, body: body, dueDate: dueDate)
        todoTasks.append(newTask)
    }
    
    func updateTask(of task: Task, title: String, body: String, dueDate: TimeInterval) {
        task.title = title
        task.body = body
        task.dueDate = dueDate
    }
    
    func deleteTask(_ task: Task) {
        let id = task.id
        todoTasks.removeAll { $0.id == id }
        doingTasks.removeAll { $0.id == id }
        doneTasks.removeAll { $0.id == id }
    }
    
    func changeProcessStatus(of task: Task, to newProcessStatus: ProcessStatus) {
        task.processStatus = newProcessStatus
    }
}
