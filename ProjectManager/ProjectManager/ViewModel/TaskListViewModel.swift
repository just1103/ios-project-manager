import Foundation

struct TaskListViewModel {
    var taskManager = TaskManager() // ViewModel은 Logic (Domain)을 가지고, 비즈니스 로직은 모두 Domain이 가지도록??????
    
    // TableView DataSoure
//    private(set) var todoTasks: [Task] = []
//    private(set) var doingTasks: [Task] = []
//    private(set) var doneTasks: [Task] = []
        
    func numberOfRows(of processStatus: ProcessStatus) -> Int {
        switch processStatus {
        case .todo:
            return taskManager.todoTasks.count
        case .doing:
            return taskManager.doingTasks.count
        case .done:
            return taskManager.doneTasks.count
        }
    }
    
    func task(of processStatus: ProcessStatus, at index: Int) -> Task {
        switch processStatus {
        case .todo:
            return taskManager.todoTasks[index]
        case .doing:
            return taskManager.doingTasks[index]
        case .done:
            return taskManager.doneTasks[index]
        }
    }
}

struct CellViewModel {
    
}
