import Foundation

protocol taskManageable {
    var todoTasks: [Task] { get }
    var doingTasks: [Task] { get }
    var doneTasks: [Task] { get }
    
    // 메서드 추가
}

struct TaskManager { // 이게 ViewModel? - ViewModel이 비즈니스 로직을 처리하는게 맞겠지? (신나/그린은 왜 아니라고하지?)
    private(set) var todoTasks: [Task] = []
    private(set) var doingTasks: [Task] = []
    private(set) var doneTasks: [Task] = []
    
    mutating func createTask(title: String, body: String, dueDate: TimeInterval) { // 매개변수로 Task를 받는게 좋을까?
        let newTask = Task(title: title, body: body, dueDate: dueDate)
        todoTasks.append(newTask)
    }
    
    mutating func updateTask(of task: Task, title: String, body: String, dueDate: TimeInterval) {
        task.title = title
        task.body = body
        task.dueDate = dueDate
    }
    
    mutating func deleteTask(_ task: Task) {
        let id = task.id
        todoTasks.removeAll { $0.id == id }
        doingTasks.removeAll { $0.id == id }
        doneTasks.removeAll { $0.id == id }
    }
    
    mutating func changeProcessStatus(of task: Task, to newProcessStatus: ProcessStatus) {
        task.processStatus = newProcessStatus
    }
}
